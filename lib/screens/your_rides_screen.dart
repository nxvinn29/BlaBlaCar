import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database_service.dart';
import '../models/ride.dart';
import '../widgets/ride_card.dart';
import 'ride_details_screen.dart';

class YourRidesScreen extends StatefulWidget {
  const YourRidesScreen({super.key});

  @override
  State<YourRidesScreen> createState() => _YourRidesScreenState();
}

class _YourRidesScreenState extends State<YourRidesScreen> {
  @override
  Widget build(BuildContext context) {
    final databaseService = Provider.of<DatabaseService>(context, listen: false);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Rides'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: StreamBuilder<List<Ride>>(
          stream: databaseService.getMyBookedRides(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return TabBarView(
                children: [
                  Center(child: Text('No upcoming rides booked.', style: TextStyle(color: Colors.grey.shade700))),
                  Center(child: Text('No past rides.', style: TextStyle(color: Colors.grey.shade700))),
                ],
              );
            } else {
              final allMyRides = snapshot.data!;
              final upcomingRides = allMyRides.where((r) => r.departureTime.isAfter(DateTime.now())).toList();
              final pastRides = allMyRides.where((r) => r.departureTime.isBefore(DateTime.now())).toList();
              
              return TabBarView(
                children: [
                  _buildRidesList(upcomingRides, 'No upcoming rides booked.'),
                  _buildRidesList(pastRides, 'No past rides.'),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildRidesList(List<Ride> rides, String noRidesMessage) {
    if (rides.isEmpty) {
      return Center(
        child: Text(
          noRidesMessage,
          style: TextStyle(color: Colors.grey.shade700),
        ),
      );
    }

    return ListView.builder(
      itemCount: rides.length,
      itemBuilder: (context, index) {
        final ride = rides[index];
        return RideCard(
          ride: ride,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RideDetailsScreen(ride: ride),
              ),
            );
          },
        );
      },
    );
  }
}
