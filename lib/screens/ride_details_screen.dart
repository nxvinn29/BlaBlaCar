import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/ride.dart';
import '../services/auth_service.dart';
import '../services/database_service.dart';
import 'live_trip_screen.dart';

class RideDetailsScreen extends StatefulWidget {
  static const routeName = '/ride';
  final Ride? ride;

  const RideDetailsScreen({super.key, this.ride});

  @override
  State<RideDetailsScreen> createState() => _RideDetailsScreenState();
}

class _RideDetailsScreenState extends State<RideDetailsScreen> {
  Ride? _ride;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_ride == null) {
      if (widget.ride == null) {
        _ride = ModalRoute.of(context)!.settings.arguments as Ride?;
      } else {
        _ride = widget.ride!;
      }
    }
  }

  Future<void> _bookSeat() async {
    final authService = Provider.of<AuthService>(context, listen: false);
    final databaseService = Provider.of<DatabaseService>(context, listen: false);
    final currentUser = authService.currentUser;

    if (currentUser == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You must be logged in to book.')),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await databaseService.bookSeat(_ride!.id, currentUser);
      setState(() {
        // The local _ride object is modified by the database service
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Booking successful!'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Booking failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_ride == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    
    final Ride r = _ride!;
    final authService = context.watch<AuthService>();
    final alreadyBooked = r.passengers.any((p) => p.id == authService.currentUser?.id);

    String fmtDate(DateTime d) {
      return '${_weekday(d.weekday)}, ${d.day} ${_month(d.month)}';
    }

    return Scaffold(
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(fmtDate(r.departureTime),
                style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${_time(r.departureTime)} · ${r.departureCity}'),
                              const SizedBox(height: 6),
                              Row(children: const [
                                Icon(Icons.map, size: 16),
                                SizedBox(width: 6),
                                Text('Address')
                              ])
                            ]),
                        const Spacer(),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                  '${_time(r.arrivalTime)} · ${r.arrivalCity}'),
                              const SizedBox(height: 6),
                              Row(children: const [
                                Icon(Icons.map, size: 16),
                                SizedBox(width: 6),
                                Text('Address')
                              ])
                            ]),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                        'Duration: ${r.duration.inHours}h${(r.duration.inMinutes % 60).toString().padLeft(2, '0')}',
                        style: const TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(children: [
                        CircleAvatar(
                            child: Text(r.driver.fullName.split(' ').first[0])),
                        const SizedBox(width: 12),
                        Expanded(
                            child: Text(r.driver.fullName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600))),
                        const Icon(Icons.star, color: Colors.amber),
                        Text(
                            '${r.driver.rating}/5 - ${r.driver.ratingCount} rating')
                      ]),
                      const SizedBox(height: 8),
                      Row(children: const [
                        Icon(Icons.check_circle_outline),
                        SizedBox(width: 8),
                        Expanded(child: Text('Never cancels rides'))
                      ]),
                      const SizedBox(height: 6),
                      Row(children: const [
                        Icon(Icons.info_outline),
                        SizedBox(width: 8),
                        Expanded(
                            child: Text(
                                "Your booking won't be confirmed until the driver approves your request"))
                      ]),
                      const SizedBox(height: 6),
                      Row(children: const [
                        Icon(Icons.group),
                        SizedBox(width: 8),
                        Expanded(child: Text('Max. 2 in the back'))
                      ]),
                      const SizedBox(height: 6),
                      Row(children: [
                        const Icon(Icons.directions_car),
                        const SizedBox(width: 8),
                        Expanded(
                            child: Text(
                                '${r.vehicle.make} ${r.vehicle.model} - ${r.vehicle.color}'))
                      ]),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton(
                                onPressed: () {},
                                child: const Text('Contact driver')),
                          ),
                          if (alreadyBooked) ...[
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => LiveTripScreen(ride: r)));
                                },
                                child: const Text('Track Ride'),
                              ),
                            ),
                          ]
                        ],
                      )
                    ]),
              ),
            ),
            const SizedBox(height: 12),
            const Text('Passengers',
                style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...r.passengers.map((p) => ListTile(
                leading:
                    CircleAvatar(child: Text(p.fullName.split(' ').first[0])),
                title: Text(p.fullName))),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : ElevatedButton.icon(
                      onPressed: alreadyBooked || r.availableSeats == 0 ? null : _bookSeat,
                      icon: Icon(alreadyBooked
                          ? Icons.check_circle
                          : Icons.credit_card),
                      label: Text(alreadyBooked
                          ? 'Booked'
                          : r.availableSeats > 0
                              ? 'Request to book'
                              : 'No seats available'),
                    ),
            )
          ],
        ),
      ),
    );
  }

  String _weekday(int w) {
    const names = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return names[(w - 1) % 7];
  }

  String _month(int m) {
    const names = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return names[(m - 1) % 12];
  }

  String _time(DateTime dt) =>
      '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
}