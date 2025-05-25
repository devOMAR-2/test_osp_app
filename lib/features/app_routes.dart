import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'auth/login_screen.dart'; // Ensure correct import of LoginScreen
import 'home/home_screen.dart'; // Ensure correct import of HomeScreen
import 'settings/settings.dart'; // Ensure correct import of SettingsPage

class AppRoutes {
  static const String login = '/login';
  static const String home = '/';
  static const String settings = '/settings';

  // Method to navigate to Settings
  static void navigateToSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SettingsScreen()),
    );
  }

  // Map of app routes for easy navigation
  static Map<String, WidgetBuilder> get routes => {
        login: (context) => const LoginScreen(),
        home: (context) => const HomeScreen(),
        settings: (context) => const SettingsScreen(),
      };

  // Method to check if the user is logged in
  static Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ??
        false; // Default to false if no value is found
  }

  // Method to navigate to the login screen if not logged in
  static Future<void> navigateToLogin(BuildContext context) async {
    bool isLoggedIn = await _isLoggedIn();
    if (isLoggedIn) {
      // If already logged in, show a snack bar and navigate to home
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('You are already logged in!')),
      );
      navigateToHome(context);
    } else {
      // If not logged in, navigate to the login screen
      Navigator.pushReplacementNamed(context, login);
    }
  }

  // Method to navigate to the home screen if logged in
  static Future<void> navigateToHome(BuildContext context) async {
    bool isLoggedIn = await _isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, home);
    } else {
      navigateToLogin(context);
    }
  }

  // Method to log out
  static Future<void> logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false); // Set user to not logged in
    navigateToLogin(context); // Navigate back to login screen
  }

  // Method to handle successful login
  static Future<void> loginSuccess(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // Set user as logged in
    navigateToHome(context); // Navigate to home screen
  }
}
