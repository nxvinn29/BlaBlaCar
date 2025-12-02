import 'message.dart';
import 'ride.dart';
import 'user.dart';
import 'vehicle.dart';

final mockUsers = <User>[
  User(
      id: 'u1',
      fullName: 'Arjun Kumar',
      email: 'arjun.kumar@example.com',
      avatarUrl: null,
      rating: 5.0,
      ratingCount: 1),
  User(
      id: 'u2',
      fullName: 'Sneha Rao',
      email: 'sneha.rao@example.com',
      avatarUrl: null,
      rating: 4.8,
      ratingCount: 12),
  User(
      id: 'u3',
      fullName: 'Rahul Mehta',
      email: 'rahul.mehta@example.com',
      avatarUrl: null,
      rating: 4.9,
      ratingCount: 5),
];

final mockVehicles = <Vehicle>[
  Vehicle(make: 'Maruti', model: 'Swift', color: 'white', seats: 4),
  Vehicle(make: 'Hyundai', model: 'i20', color: 'silver', seats: 4),
];

final mockRides = <Ride>[
  Ride(
    id: 'r1',
    driver: mockUsers[0],
    vehicle: mockVehicles[0],
    departureCity: 'Bengaluru, Karnataka',
    arrivalCity: 'Chennai, Tamil Nadu',
    departureTime: DateTime.now().add(const Duration(hours: 3)),
    arrivalTime: DateTime.now().add(const Duration(hours: 8, minutes: 20)),
    duration: const Duration(hours: 5, minutes: 20),
    price: 700.0,
    availableSeats: 2,
    passengers: [mockUsers[2]],
  ),
  Ride(
    id: 'r2',
    driver: mockUsers[1],
    vehicle: mockVehicles[1],
    departureCity: 'Bengaluru, Karnataka',
    arrivalCity: 'Hyderabad, Telangana',
    departureTime: DateTime.now().add(const Duration(hours: 1)),
    arrivalTime: DateTime.now().add(const Duration(hours: 6, minutes: 0)),
    duration: const Duration(hours: 5),
    price: 850.0,
    availableSeats: 3,
    passengers: [],
  ),
];

final mockRecentSearches = <String>[
  'Bengaluru, Karnataka → Chennai, Tamil Nadu',
  'Bengaluru, Karnataka → Hyderabad, Telangana',
  'Mysuru, Karnataka → Bangalore, Karnataka',
];

final mockMessages = <Message>[
  Message(
    id: 'm1',
    from: mockUsers[1],
    to: mockUsers[0],
    text: 'Hey! Is the seat still available?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
  ),
  Message(
    id: 'm2',
    from: mockUsers[2],
    to: mockUsers[0],
    text: 'Can you pick me up from a different location?',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
  ),
];
