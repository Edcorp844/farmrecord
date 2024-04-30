import 'dart:async';

import 'package:farmrecords/modal.dart';
import 'package:farmrecords/services/storage.dart';

class AuthService {
  // Singleton instance
  static final AuthService _instance = AuthService._internal();
  factory AuthService() => _instance;
  AuthService._internal();

  final _userController = StreamController<User?>.broadcast();
  Stream<User?> get userStream => _userController.stream;
  User? _currentUser;

 Future<void> login(String email, String password) async {
  print('Attempting login with email: $email, password: $password');

  // Perform authentication using StorageService
  Map<String, dynamic>? userData = await StorageService.instance.loginUser(email, password);
  
  if (userData != null) {
    _currentUser = User(
      id: userData['id'],
      name: userData['name'],
      email: userData['email'],
      password: userData['password'],
      phone: userData['phone'],
      location: userData['location'],
      gender: userData['gender'],
      farmName: userData['farmName'],
    );
    _userController.add(_currentUser); // Notify listeners
    print(_currentUser);
  } else {
    print('Login failed: no user data found');
    throw Exception('Login failed'); // Handle login failure
  }
}


  // Method to log out the current user
  Future<void> logout() async {
    _currentUser = null;
    _userController.add(null); // Notify listeners
  }

  // Method to check if a user is authenticated
  bool isAuthenticated() {
    return _currentUser != null;
  }

  // Method to get the current user
  User? getCurrentUser() {
    return _currentUser;
  }
}
