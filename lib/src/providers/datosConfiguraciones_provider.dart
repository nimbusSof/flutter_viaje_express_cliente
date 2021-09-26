import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class DatosConfiguraciones with ChangeNotifier {
  TextEditingController _numeroCtrl = new TextEditingController();

  //GETTERS Y SETTERS NOMBRESCTRL

  TextEditingController get numeroCtrl => this._numeroCtrl;

  void removerDatos() {
    TextEditingController numeroCtrl = new TextEditingController();
    this._numeroCtrl = numeroCtrl;
    notifyListeners();
  }
}
