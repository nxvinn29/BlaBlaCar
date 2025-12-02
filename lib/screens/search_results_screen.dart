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
      body: FutureBuilder<List<Ride>>(
        future: _ridesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,
                        size: 64, color: Colors.red.shade400),
                    const SizedBox(height: 16),
                    Text(
                      'An error occurred',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'We couldn\'t load ride data. Please try again later.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.search_off,
                        size: 64, color: Colors.grey),
                    const SizedBox(height: 16),
                    Text(
                      'No rides found',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Try adjusting your search, or create an alert to be notified when a ride is available.',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        // Placeholder for ride alert functionality
                      },
                      child: const Text('Create a ride alert'),
                    ),
                  ],
                ),
              ),
            );
          } else {
            final rides = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.only(bottom: 24),
              itemCount: rides.length,
              itemBuilder: (context, i) {
                final Ride r = rides[i];
                return RideCard(
                  ride: r,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => RideDetailsScreen(ride: r)),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}