import 'package:blabla/screens/location_search_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/mock_data.dart';
import 'search_results_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _fromController = TextEditingController(text: 'Bengaluru, Karnataka');
  final _toController = TextEditingController(text: 'Chennai, Tamil Nadu');

  DateTime _selectedDate = DateTime.now();
  int _passengerCount = 1;

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _selectLocation(BuildContext context, TextEditingController controller,
      String label) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LocationSearchScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 24),
                Text(
                  'Your pick of rides at low prices',
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),
                Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 120,
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [primary, primary.withOpacity(0.7)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.directions_car_filled_outlined,
                          color: Colors.white,
                          size: 64,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 80,
                      left: 16,
                      right: 16,
                      child: Card(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        elevation: 8,
                        shadowColor: Colors.black.withOpacity(0.1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _buildLocationField(
                                controller: _fromController,
                                icon: Icons.radio_button_checked,
                                label: 'Leaving from',
                              ),
                              const Divider(height: 1),
                              _buildLocationField(
                                controller: _toController,
                                icon: Icons.place,
                                label: 'Going to',
                              ),
                              const Divider(height: 1),
                              Row(
                                children: [
                                  Expanded(
                                    child: _buildInfoRow(
                                      icon: Icons.calendar_today,
                                      text: DateFormat('EEE, d MMM')
                                          .format(_selectedDate),
                                      onTap: () => _selectDate(context),
                                    ),
                                  ),
                                  const SizedBox(
                                      height: 32, child: VerticalDivider()),
                                  Expanded(
                                    child: _buildPassengerCounter(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: ElevatedButton(
                                  onPressed: () {
                                    // Navigate to search results
                                    if (_fromController.text.isNotEmpty &&
                                        _toController.text.isNotEmpty) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => SearchResultsScreen(
                                            from: _fromController.text,
                                            to: _toController.text,
                                            // date: _selectedDate,
                                            // passengers: _passengerCount,
                                          ),
                                        ),
                                      );
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Please select both locations.'),
                                        ),
                                      );
                                    }
                                  },
                                  child: const Text('Search'),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.25),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent searches',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...mockRecentSearches.map(
                        (s) => Card(
                          margin: const EdgeInsets.only(bottom: 8),
                          elevation: 1,
                          shadowColor: Colors.black.withOpacity(0.05),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: ListTile(
                            leading:
                                const Icon(Icons.history, color: Colors.grey),
                            title: Text(s),
                            subtitle: const Text('1 passenger'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () {},
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
  }) {
    return InkWell(
      onTap: () => _selectLocation(context, controller, label),
      child: IgnorePointer(
        child: TextField(
          controller: controller,
          decoration: InputDecoration(
            prefixIcon:
                Icon(icon, color: Theme.of(context).colorScheme.primary),
            labelText: label,
            border: InputBorder.none,
          ),
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      {required IconData icon, required String text, VoidCallback? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: Colors.grey.shade700),
            const SizedBox(width: 12),
            Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildPassengerCounter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: const Icon(Icons.remove_circle_outline),
          onPressed: _passengerCount > 1
              ? () => setState(() => _passengerCount--)
              : null,
        ),
        Text('$_passengerCount',
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
        IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: _passengerCount < 8
              ? () => setState(() => _passengerCount++)
              : null,
        ),
      ],
    );
  }
}
