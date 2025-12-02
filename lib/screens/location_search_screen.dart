import 'package:flutter/material.dart';
import '../services/location_service.dart';

class LocationSearchScreen extends StatefulWidget {
  const LocationSearchScreen({super.key});

  @override
  State<LocationSearchScreen> createState() => _LocationSearchScreenState();
}

class _LocationSearchScreenState extends State<LocationSearchScreen> {
  final _searchController = TextEditingController();
  final LocationService _locationService = LocationService();
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      _getAutocomplete();
    });
  }

  void _getAutocomplete() async {
    if (_searchController.text.isNotEmpty) {
      final suggestions = await _locationService.getAutocomplete(_searchController.text);
      setState(() {
        _suggestions = suggestions;
      });
    } else {
      setState(() {
        _suggestions = [];
      });
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Enter a location',
            border: InputBorder.none,
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: _suggestions.length,
        itemBuilder: (context, index) {
          final suggestion = _suggestions[index];
          return ListTile(
            title: Text(suggestion),
            onTap: () {
              Navigator.of(context).pop(suggestion);
            },
          );
        },
      ),
    );
  }
}
