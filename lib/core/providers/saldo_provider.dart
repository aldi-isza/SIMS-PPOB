import 'package:flutter/foundation.dart';

class SaldoProvider extends ChangeNotifier {
  int _saldo = 0;
  bool _isHidden = false;

  int get saldo => _saldo;
  bool get isHidden => _isHidden;

  void setSaldo(int newSaldo) {
    _saldo = newSaldo;
    notifyListeners();
  }

  void toggleVisibility() {
    _isHidden = !_isHidden;
  }
}
