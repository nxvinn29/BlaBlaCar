import 'package:flutter/material.dart';
import '../models/ride.dart';

class RideCard extends StatelessWidget {
  final Ride ride;
  final VoidCallback? onTap;

  const RideCard({super.key, required this.ride, this.onTap});

  @override
  Widget build(BuildContext context) {
    final priceText = '₹${ride.price.toStringAsFixed(2)}';

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              CircleAvatar(
                  child: Text(ride.driver.fullName.split(' ').first[0])),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(ride.driver.fullName,
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600))),
                        const Icon(Icons.flash_on,
                            color: Colors.orange, size: 18),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  '${_time(ride.departureTime)} · ${ride.departureCity}',
                                  style: const TextStyle(fontSize: 13)),
                              const SizedBox(height: 4),
                              Text(
                                  '${_time(ride.arrivalTime)} · ${ride.arrivalCity}',
                                  style: const TextStyle(fontSize: 13)),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(priceText,
                                style: const TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 8),
                            Text(
                                '${ride.duration.inHours}h${(ride.duration.inMinutes % 60).toString().padLeft(2, '0')}',
                                style: const TextStyle(color: Colors.grey)),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String _time(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}
