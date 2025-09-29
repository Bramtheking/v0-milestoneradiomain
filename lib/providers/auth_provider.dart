import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  bool _isLoading = false;
  String? _errorMessage;

  User? get user => _user;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  bool get isAuthenticated => _user != null;
  bool get isAdmin => _user != null; // Any authenticated user is admin

  AuthProvider() {
    _auth.authStateChanges().listen((User? user) {
      _user = user;
      notifyListeners();
    });
  }

  Future<bool> signIn(String email, String password) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();
      
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      // Wait a moment for auth state to update
      await Future.delayed(const Duration(milliseconds: 500));
      
      // Check if user is actually signed in (works around Pigeon error)
      _user = _auth.currentUser;
      _isLoading = false;
      
      if (_user != null) {
        _errorMessage = null;
        notifyListeners();
        return true;
      } else {
        _errorMessage = 'Login failed - user not found after authentication';
        notifyListeners();
        return false;
      }
      
    } on FirebaseAuthException catch (e) {
      _isLoading = false;
      
      // Map Firebase error codes to user-friendly messages
      switch (e.code) {
        case 'user-not-found':
          _errorMessage = 'No user found with email: $email\nMake sure the admin account exists in Firebase Authentication.';
          break;
        case 'wrong-password':
          _errorMessage = 'Incorrect password for: $email';
          break;
        case 'invalid-email':
          _errorMessage = 'Invalid email format: $email';
          break;
        case 'user-disabled':
          _errorMessage = 'This user account has been disabled.';
          break;
        case 'too-many-requests':
          _errorMessage = 'Too many failed attempts. Try again later.';
          break;
        case 'invalid-credential':
          _errorMessage = 'Invalid email or password.';
          break;
        default:
          _errorMessage = 'Login failed: ${e.message}';
      }

      notifyListeners();
      return false;
      
    } catch (e) {
      // Catch ALL other errors including Pigeon TypeError
      _isLoading = false;
      
      // Still check if user is signed in despite the error
      await Future.delayed(const Duration(milliseconds: 500));
      _user = _auth.currentUser;
      
      if (_user != null) {
        // Login actually succeeded despite the error
        _errorMessage = null;
        notifyListeners();
        return true;
      }
      
      _errorMessage = 'Login error: ${e.toString()}';
      notifyListeners();
      return false;
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _errorMessage = null;
      notifyListeners();
    } catch (e) {
      _errorMessage = 'Error signing out: ${e.toString()}';
      notifyListeners();
    }
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }
}