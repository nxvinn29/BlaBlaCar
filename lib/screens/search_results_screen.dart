import 'package:flutter/material.dart';
import '../services/database_service.dart';
import '../widgets/ride_card.dart';
import '../models/ride.dart';
import 'ride_details_screen.dart';

class SearchResultsScreen extends StatefulWidget {
  static const routeName = '/results';
  final String from;
  final String to;

  const SearchResultsScreen({super.key, required this.from, required this.to});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  final DatabaseService _databaseService = DatabaseService();
  late Future<List<Ride>> _ridesFuture;

  @override
  void initState() {
    super.initState();
    _ridesFuture = _databaseService.searchRides(widget.from, widget.to);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.from} → ${widget.to}'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Ride>>(
              future: _ridesFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No rides found.'));
                } else {
                  final rides = snapshot.data!;
                  return ListView.builder(
                    padding: const EdgeInsets.only(bottom: 80),
                    itemCount: rides.length,
                    itemBuilder: (context, i) {
                      final Ride r = rides[i];
                      return RideCard(
                        ride: r,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => RideDetailsScreen(ride: r)),
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            child: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                shape: const StadiumBorder(),
                side: const BorderSide(color: Colors.grey),
              ),
              child: const Text('Create a ride alert'),
            ),
          )
        ],
      ),
    );
  }
}