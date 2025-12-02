import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import '../models/ride.dart';
import '../services/database_service.dart';

class LiveTripScreen extends StatefulWidget {
  final Ride ride;
  const LiveTripScreen({super.key, required this.ride});

  @override
  State<LiveTripScreen> createState() => _LiveTripScreenState();
}

class _LiveTripScreenState extends State<LiveTripScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  Marker? _driverMarker;
  StreamSubscription? _locationSubscription;

  @override
  void initState() {
    super.initState();
    final databaseService = Provider.of<DatabaseService>(context, listen: false);
    databaseService.startRideSimulation(widget.ride);

    _locationSubscription = databaseService.driverLocationStream.listen((location) {
      setState(() {
        _driverMarker = Marker(
          markerId: const MarkerId('driver'),
          position: location,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
        );
      });
      _moveCamera(location);
    });
  }

  @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

  Future<void> _moveCamera(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(target: position, zoom: 14.5),
    ));
  }

  @override
  Widget build(BuildContext context) {
    // For simplicity, we're not drawing a polyline for the route.
    // In a real app, you would use the Google Maps Directions API for this.
    final initialCameraPosition = CameraPosition(
      target: LatLng(
        // A midpoint for initial camera position
        (12.9716 + 13.0827) / 2,
        (77.5946 + 80.2707) / 2,
      ),
      zoom: 7,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Trip'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _driverMarker == null ? {} : {_driverMarker!},
      ),
    );
  }
}
