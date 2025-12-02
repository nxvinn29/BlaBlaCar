import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/database_service.dart';
import 'screens/login_screen.dart';
import 'screens/home_shell.dart';
import 'screens/ride_details_screen.dart';

void main() {
  runApp(const RideShareXApp());
}

class RideShareXApp extends StatelessWidget {
  const RideShareXApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        Provider(create: (_) => DatabaseService()),
      ],
      child: MaterialApp(
        title: 'RideShareX',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF00AEEF),
            primary: const Color(0xFF00AEEF),
            secondary: Colors.teal,
            brightness: Brightness.light,
          ),
          scaffoldBackgroundColor: Colors.white,
          cardTheme: CardThemeData(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 2,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00AEEF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              foregroundColor: Colors.white,
              minimumSize: const Size.fromHeight(48),
            ),
          ),
        ),
        home: const AuthWrapper(),
        routes: {
          // SearchResultsScreen.routeName: (c) => const SearchResultsScreen(), // This will now be handled by direct navigation
          RideDetailsScreen.routeName: (c) => const RideDetailsScreen(),
        },
      ),
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    if (authService.currentUser == null) {
      return const LoginScreen();
    } else {
      return const HomeShell();
    }
  }
}