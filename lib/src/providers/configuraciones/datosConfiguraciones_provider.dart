import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/services/configuraciones/idiomaUser_service.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';

class DatosConfiguraciones with ChangeNotifier {
 

  TextEditingController _numeroCtrl = new TextEditingController();
  final idiomaUserService = new IdiomaUser();
  final prefs = new PreferenciasUsuario();
  bool _idioma1 = false;
  bool _idioma2 = false;

  inicializar(String token, String idPersonaRol) async {
    print('idPersonaRol idioma: ' + idPersonaRol);
    String idioma =
        await idiomaUserService.idiomaClienteService(idPersonaRol, token);
    if (idioma == 'español') {
      this._idioma1 = true;
      this._idioma2 = false;
    } else if (idioma == 'ingles') {
      this._idioma1 = false;
      this._idioma2 = true;
    }else{
      this._idioma1 = true;
      this._idioma2 = false;
    }

    /* this._idioma1 = prefs.idioma1;
    this._idioma2 = prefs.idioma2; */
  }
  //GETTERS Y SETTERS NOMBRESCTRL

  TextEditingController get numeroCtrl => this._numeroCtrl;
  bool get idioma1 => this._idioma1;
  bool get idioma2 => this._idioma2;

  set idioma1(bool idioma1) {
    this._idioma1 = idioma1;
    notifyListeners();
  }

  set idioma2(bool idioma2) {
    this._idioma2 = idioma2;
    notifyListeners();
  }

  putIdioma1(String token, String idPersonaRol)async{
    await idiomaUserService.idiomaClienteServicePut(idPersonaRol, token, 'español');
    this._idioma1 = true;
    this._idioma2 = false;
    notifyListeners();
  }

  putIdioma2(String token, String idPersonaRol)async{
    await idiomaUserService.idiomaClienteServicePut(idPersonaRol, token, 'ingles');
    this._idioma2 = true;
    this._idioma1 = false;
    notifyListeners();
  }

  void removerDatos() {
    TextEditingController numeroCtrl = new TextEditingController();
    bool idioma1 = false;
    bool idioma2 = false;
    this._numeroCtrl = numeroCtrl;
    this._idioma1 = idioma1;
    this._idioma2 = idioma2;
    notifyListeners();
  }
}
