import 'package:flutter/cupertino.dart';

class DatosConfPerfil with ChangeNotifier {
  TextEditingController _nombresCtrl = new TextEditingController();
  TextEditingController _apellidosCtrl = new TextEditingController();
  TextEditingController _emailCtrl = new TextEditingController();
  TextEditingController _fechaCtrl = new TextEditingController();
  TextEditingController _claveCtrl = new TextEditingController();

  //GETTERS Y SETTERS NOMBRESCTRL

  TextEditingController get nombresCtrl => this._nombresCtrl;
  TextEditingController get apellidosCtrl => this._apellidosCtrl;
  TextEditingController get emailCtrl => this._emailCtrl;
  TextEditingController get fechaCtrl => this._fechaCtrl;
  TextEditingController get claveCtrl => this._claveCtrl;

  //METODOS
  void removerDatos() {
    TextEditingController nombresCtrl = new TextEditingController();
    TextEditingController apellidosCtrl = new TextEditingController();
    TextEditingController emailCtrl = new TextEditingController();
    TextEditingController fechaCtrl = new TextEditingController();
    TextEditingController claveCtrl = new TextEditingController();

    this._nombresCtrl = nombresCtrl;
    this._apellidosCtrl = apellidosCtrl;
    this._emailCtrl = emailCtrl;
    this._fechaCtrl = fechaCtrl;
    this._claveCtrl = claveCtrl;
    notifyListeners();
  }
}
