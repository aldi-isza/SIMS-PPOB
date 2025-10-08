import 'dart:math';

import 'package:flutter/material.dart';
import 'package:sims_ppob/core/services/local_storage_service.dart';
import 'package:sims_ppob/features/auth/data/auth_api.dart';
import 'package:sims_ppob/features/auth/data/models/login_request.dart';
import 'package:sims_ppob/features/auth/data/models/login_response.dart';
import 'package:sims_ppob/features/auth/data/models/register_response.dart';

class AuthProvide extends ChangeNotifier {
  final AuthApi _api = AuthApi();
  final LocalStorageService _storage = LocalStorageService();

  bool _isLoading = false;
  bool _isAunthenticated = false;
  String? _errorMessage;
  String? _token;

  LoginResponse? _loginResponse;
  RegisterResponse? _registerResponse;

  // GETTER
  bool get isLoading => _isLoading;
  bool get isAunthenticated => _isAunthenticated;
  String? get errorMessage => _errorMessage;
  String? get token => _token;
  LoginResponse? get loginResponse => _loginResponse;
  RegisterResponse? get registerResponse => _registerResponse;

  // HELPER
  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void _setError(String? message) {
    _errorMessage = message;
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
  }

  // VALIDATION
  bool _validationEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9._].\[a-zA-Z0-9]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  bool _validatePassword(String password) => password.length >= 8;

  // REGISTER
  Future<void> Register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    if (!_validationEmail(email)) {}
  }

  Future<void> Login({required String email, required String password}) async {
    final emailregExp = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-].\[a-zA-Z0-9]{2,}$',
    );
    if (!emailregExp.hasMatch(email)) {
      _errorMessage = 'Format tidak valid';
      notifyListeners();
      return;
    }
    // password has min 8 character
    if (password.length < 8) {
      _errorMessage = 'Password minimal 8 karakter';
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final request = LoginRequest(email: email, password: password);
      _loginResponse = await _api.login(request);
      if (!_loginResponse!.success) {
        _errorMessage = _loginResponse!.message;
      } else {
        print("JWT TOKEN : ${_loginResponse!.token}");
      }
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
