import 'package:flutter/material.dart';
import '../widgets/profile_section_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Profile'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          foregroundColor: Colors.black,
          bottom: const TabBar(
              tabs: [Tab(text: 'About you'), Tab(text: 'Account')]),
        ),
        body: TabBarView(children: [AboutYouTab(), AccountTab()]),
      ),
    );
  }
}

class AboutYouTab extends StatelessWidget {
  const AboutYouTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        ProfileSectionCard(
          child: Row(children: [
            CircleAvatar(radius: 28, child: Text('A')),
            const SizedBox(width: 12),
            Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Arjun Kumar',
                      style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('Newcomer')
                ])
          ]),
        ),
        const SizedBox(height: 12),
        Card(
          color: const Color(0xFF00AEEF),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('Complete your profile',
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text(
                  'Add information to help drivers and passengers trust you',
                  style: TextStyle(color: Colors.white70)),
              const SizedBox(height: 8),
              const Text('0 out of 6 complete',
                  style: TextStyle(color: Colors.white)),
              const SizedBox(height: 8),
              Row(
                  children: List.generate(
                      6,
                      (i) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: 30,
                          height: 6,
                          color: Colors.white30))),
              const SizedBox(height: 8),
              TextButton(
                  onPressed: () {},
                  child: const Text('Add profile picture',
                      style: TextStyle(color: Colors.white)))
            ]),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
            onPressed: () {}, child: const Text('Edit personal details')),
        const SizedBox(height: 12),
        const Text('Verify your profile',
            style: TextStyle(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        ListTile(
            leading: const Icon(Icons.verified_user),
            title: const Text('Verify your Govt. ID'),
            trailing: const Icon(Icons.chevron_right)),
        ListTile(
            leading: const Icon(Icons.email),
            title: const Text('Confirm email'),
            trailing: const Icon(Icons.chevron_right)),
        ListTile(
            leading: const Icon(Icons.phone),
            title: const Text('Confirm phone number'),
            trailing: const Icon(Icons.chevron_right)),
        const SizedBox(height: 12),
        const Text('About you', style: TextStyle(fontWeight: FontWeight.w600)),
        ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('Add a mini bio')),
      ]),
    );
  }
}

class AccountTab extends StatelessWidget {
  const AccountTab({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Ratings',
      'Saved passengers',
      'Communication preferences',
      'Password',
      'Postal address',
      'Payout methods',
      'Payouts',
      'Payment methods',
      'Payments & refunds',
      'Help',
      'Terms and conditions',
      'Data protection',
      'Log out',
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: items.length,
      itemBuilder: (context, i) => ListTile(
          title: Text(items[i]), trailing: const Icon(Icons.chevron_right)),
    );
  }
}
