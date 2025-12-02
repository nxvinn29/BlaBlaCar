import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../services/location_service.dart';

class MapPickerScreen extends StatefulWidget {
  const MapPickerScreen({super.key});

  @override
  State<MapPickerScreen> createState() => _MapPickerScreenState();
}

class _MapPickerScreenState extends State<MapPickerScreen> {
  final LocationService _locationService = LocationService();
  GoogleMapController? _mapController;
  LatLng? _pickedLocation;
  LatLng _initialPosition = const LatLng(12.9716, 77.5946); // Default to Bengaluru

  @override
  void initState() {
    super.initState();
    _locationService.getCurrentPosition().then((position) {
      setState(() {
        _initialPosition = LatLng(position.latitude, position.longitude);
      });
    }).catchError((e) {
      // Handle error, maybe show a snackbar
      print(e);
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }

  void _onTap(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick a Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _pickedLocation == null
                ? null
                : () {
                    Navigator.of(context).pop(_pickedLocation);
                  },
          ),
        ],
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 11.0,
        ),
        onTap: _onTap,
        markers: _pickedLocation == null
            ? {}
            : {
                Marker(
                  markerId: const MarkerId('picked_location'),
                  position: _pickedLocation!,
                ),
              },
      ),
    );
  }
}
