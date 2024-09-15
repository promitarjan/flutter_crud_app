// user_provider.dart
import 'package:flutter/material.dart';
import 'api_service.dart';
import 'user_model.dart';

class UserProvider with ChangeNotifier {
  List<User> _users = [];
  final ApiService apiService = ApiService();

  List<User> get users => _users;

  // Fetch users from API
  Future<void> fetchUsers() async {
    _users = await apiService.getUsers();
    notifyListeners();
  }

  // Add a new user
  Future<void> addUser(User user) async {
    User newUser = await apiService.createUser(user);
    _users.add(newUser);
    notifyListeners();
  }

  // Update a user
  Future<void> updateUser(User user) async {
    await apiService.updateUser(user);
    int index = _users.indexWhere((u) => u.id == user.id);
    _users[index] = user;
    notifyListeners();
  }

  // Delete a user
  Future<void> deleteUser(int id) async {
    await apiService.deleteUser(id);
    _users.removeWhere((user) => user.id == id);
    notifyListeners();
  }
}
