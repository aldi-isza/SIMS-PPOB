import 'package:flutter/foundation.dart';
import 'package:sims_ppob/core/services/local_storage_service.dart';
import 'package:sims_ppob/features/auth/data/auth_api.dart';
import 'package:sims_ppob/features/auth/data/models/login_request.dart';
import 'package:sims_ppob/features/auth/data/models/login_response.dart';
import 'package:sims_ppob/features/auth/data/models/register_request.dart';
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
  Future<void> register({
    required String email,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    if (!_validationEmail(email)) {
      _setError("Format email tidak valid");
      return;
    }
    if (!_validatePassword(password)) {
      _setError("Passwword minimal 9 karakter");
    }
    _setLoading(true);
    _clearError();

    try {
      final req = RegisterRequest(
        email: email,
        firstName: firstName,
        lastName: lastName,
        password: password,
      );
      final res = await _api.register(req);
      _registerResponse = res;
      if (!res.success) {
        _setError(res.message);
      }
    } catch (e) {
      _setError('Gagal register: $e');
    } finally {
      _setLoading(false);
    }
  }

  // LOGIN
  Future<void> login({required String email, required String password}) async {
    if (!_validationEmail(email)) {
      _setError("Format email tidak valid");
      return;
    }
    // password has min 8 character
    if (!_validatePassword(password)) {
      _setError("Password minimal 8 karakter");
      return;
    }

    _setLoading(true);
    _clearError();

    try {
      final req = LoginRequest(email: email, password: password);
      final res = await _api.login(req);
      _loginResponse = res;
      if (res.success && res.token != null) {
        _token = res.token;
        _isAunthenticated = true;

        // save token -> SharedPreferences
        await _storage.saveToken(_token!);
        if (kDebugMode) {
          print("Login sukses, token disimpan: $_token");
        }
      } else {
        _setError(res.message);
      }
    } catch (e) {
      _setError("Gagal login: $e");
    } finally {
      _setLoading(false);
    }
  }
}
