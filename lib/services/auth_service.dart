import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../models/mock_data.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  // In-memory store for users and their passwords (for simulation only)
  final Map<String, String> _userPasswords = {
    'arjun.kumar@example.com': 'password123',
    'sneha.rao@example.com': 'password123',
    'rahul.mehta@example.com': 'password123',
  };
  final List<User> _users = mockUsers;

  Future<User?> signInWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (_userPasswords.containsKey(email) && _userPasswords[email] == password) {
      _currentUser = _users.firstWhere((user) => user.email == email);
      notifyListeners();
      return _currentUser;
    }
    return null;
  }

  Future<User?> createUserWithEmailAndPassword(String fullName, String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    if (_userPasswords.containsKey(email)) {
      // User with this email already exists
      return null;
    }

    final newUser = User(
      id: 'u${_users.length + 1}',
      fullName: fullName,
      email: email,
    );

    _users.add(newUser);
    _userPasswords[email] = password;

    _currentUser = newUser;
    notifyListeners();
    return _currentUser;
  }

  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    _currentUser = null;
    notifyListeners();
  }
}
