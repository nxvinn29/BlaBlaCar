import '../models/ride.dart';
import '../models/user.dart';
import '../models/mock_data.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DatabaseService {
  // Simulate a database table of rides
  final List<Ride> _rides = mockRides;
  // Simulate a list of booked ride IDs for the current user
  final List<String> _bookedRideIds = [];

  // Simulate a real-time location stream for a driver
  final StreamController<LatLng> _driverLocationController = StreamController<LatLng>.broadcast();
  Stream<LatLng> get driverLocationStream => _driverLocationController.stream;

  // Simulate a stream of data from Firestore
  Stream<List<Ride>> getRides() {
    return Stream.value(_rides);
  }

  Future<Ride> getRideById(String rideId) async {
    await Future.delayed(const Duration(milliseconds: 200));
    return _rides.firstWhere((ride) => ride.id == rideId);
  }

  // Simulate fetching rides based on a query
  Future<List<Ride>> searchRides(String from, String to) async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    return _rides
        .where((ride) =>
            ride.departureCity.toLowerCase().contains(from.toLowerCase()) &&
            ride.arrivalCity.toLowerCase().contains(to.toLowerCase()))
        .toList();
  }

  Future<void> bookSeat(String rideId, User user) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    final ride = _rides.firstWhere((r) => r.id == rideId);
    if (ride.availableSeats > 0 && !ride.passengers.any((p) => p.id == user.id)) {
      ride.passengers.add(user);
      ride.availableSeats--;
      if (!_bookedRideIds.contains(rideId)) {
        _bookedRideIds.add(rideId);
      }
    } else {
      throw Exception('No available seats or already booked.');
    }
  }

  Stream<List<Ride>> getMyBookedRides() {
    final bookedRides = _rides.where((ride) => _bookedRideIds.contains(ride.id)).toList();
    return Stream.value(bookedRides);
  }

  void startRideSimulation(Ride ride) {
    // Simulate a simple linear path from Bengaluru to Chennai for demonstration
    const start = LatLng(12.9716, 77.5946);
    const end = LatLng(13.0827, 80.2707);

    const steps = 100;
    final latStep = (end.latitude - start.latitude) / steps;
    final lngStep = (end.longitude - start.longitude) / steps;

    int currentStep = 0;
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (currentStep > steps) {
        timer.cancel();
      } else {
        final newLat = start.latitude + (latStep * currentStep);
        final newLng = start.longitude + (lngStep * currentStep);
        _driverLocationController.add(LatLng(newLat, newLng));
        currentStep++;
      }
    });
  }

  void dispose() {
    _driverLocationController.close();
  }
}
