import 'package:flutter/cupertino.dart';

class DatosViajeNuevo with ChangeNotifier {
  TextEditingController _ubicacionCtrl = new TextEditingController();
  TextEditingController _destinoCtrl = new TextEditingController();

  // GETTERS Y SETTES DE UBICACION RECOJIDA
  TextEditingController get ubicacionCtrl => this._ubicacionCtrl;

  String get ubicacionCtrlText => this._ubicacionCtrl.text;
  set ubicacionCtrlText(String ubicacionCtrl) {
    this._ubicacionCtrl.text = ubicacionCtrl;
    notifyListeners();
  }

  // GETTERS Y SETTERS DE DESTINO VIAJE
  TextEditingController get destinoCtrl => this._destinoCtrl;
  set destinoCtrl(TextEditingController destinoCtrl) {
    this._destinoCtrl = destinoCtrl;
    notifyListeners();
  }

// METODOS

  void removerDatos() {
    TextEditingController ubicacionCtrl = new TextEditingController();
    TextEditingController destinoCtrl = new TextEditingController();
    this._ubicacionCtrl = ubicacionCtrl;
    this._destinoCtrl = destinoCtrl;
    notifyListeners();
  }
}
