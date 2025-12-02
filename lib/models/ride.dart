import 'user.dart';
import 'vehicle.dart';

class Ride {
  final String id;
  final User driver;
  final Vehicle vehicle;
  final String departureCity;
  final String arrivalCity;
  final DateTime departureTime;
  final DateTime arrivalTime;
  final Duration duration;
  final double price;
  int availableSeats;
  List<User> passengers;

  Ride({
    required this.id,
    required this.driver,
    required this.vehicle,
    required this.departureCity,
    required this.arrivalCity,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.price,
    required this.availableSeats,
    List<User>? passengers,
  }) : passengers = passengers ?? [];
}
