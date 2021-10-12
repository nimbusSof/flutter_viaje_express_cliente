import 'package:flutter/cupertino.dart';

class DatosViajeNuevo with ChangeNotifier {
  TextEditingController _ubicacionCtrl = new TextEditingController();
  TextEditingController _destinoCtrl = new TextEditingController();

  // GET UBICACION RECOJIDA
  TextEditingController get ubicacionCtrl => this._ubicacionCtrl;

  
  // GET DESTINO CTRL
  TextEditingController get destinoCtrl => this._destinoCtrl;
  

// METODOS

  void removerDatos() {
    TextEditingController ubicacionCtrl = new TextEditingController();
    TextEditingController destinoCtrl = new TextEditingController();
    this._ubicacionCtrl = ubicacionCtrl;
    this._destinoCtrl = destinoCtrl;
    notifyListeners();
  }
}
