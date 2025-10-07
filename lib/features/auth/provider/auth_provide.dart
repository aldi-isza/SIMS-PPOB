import 'package:flutter/material.dart';
import 'package:sims_ppob/features/auth/data/auth_api.dart';
import 'package:sims_ppob/features/auth/data/models/login_request.dart';
import 'package:sims_ppob/features/auth/data/models/login_response.dart';
import 'package:sims_ppob/features/auth/data/models/register_response.dart';

class AuthProvide extends ChangeNotifier {
  final AuthApi _api = AuthApi();

  bool _isLoading = false;
  String? _errorMessage;
  LoginResponse? _loginResponse;
  RegisterResponse? _registerResponse;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  LoginResponse? get loginResponse => _loginResponse;
  RegisterResponse? get registerResponse => _registerResponse;


  

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
