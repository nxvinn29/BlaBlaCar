import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/mock_data.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Assuming the current user is mockUsers[0]
    final currentUser = mockUsers[0];
    final messages = mockMessages.where((m) => m.to.id == currentUser.id).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Inbox'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey.shade200,
              ),
            ),
          ),
          Expanded(
            child: messages.isEmpty
                ? Center(
                    child: Text(
                      'No messages yet',
                      style: TextStyle(color: Colors.grey.shade700),
                    ),
                  )
                : ListView.builder(
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final message = messages[index];
                      return ListTile(
                        leading: CircleAvatar(
                          child: Text(message.from.fullName.split(' ').first[0]),
                        ),
                        title: Text(message.from.fullName, style: const TextStyle(fontWeight: FontWeight.w600)),
                        subtitle: Text(message.text, maxLines: 1, overflow: TextOverflow.ellipsis),
                        trailing: Text(
                          DateFormat.jm().format(message.timestamp),
                          style: const TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                        onTap: () {
                          // TODO: Implement chat screen
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}