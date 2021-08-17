import 'package:flutter/cupertino.dart';

class CustomIputService with ChangeNotifier {
  bool _passwordVisible = true;
  bool _passwordVisible2 = true;

  bool get passwordVisible => this._passwordVisible;
  set passwordVisible(bool passwordVisible) {
    this._passwordVisible = passwordVisible;
     notifyListeners();
  }

  bool get passwordVisible2 => this._passwordVisible2;
  set passwordVisible2(bool passwordVisible2) {
    this._passwordVisible2 = passwordVisible2;
     notifyListeners();
  }
}
