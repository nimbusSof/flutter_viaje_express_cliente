import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario extends ChangeNotifier {
  static final PreferenciasUsuario _instancia =
      new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del Genero
  String get genero {
    return _prefs.getString('genero') ?? '';
  }

  set genero(String value) {
    _prefs.setString('genero', value);
    notifyListeners();
  }

  // GET y SET del nombreUsuario
  String get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario(String value) {
    _prefs.setString('nombreUsuario', value);
    notifyListeners();
  }

// GET y SET del apellidoUsuario
  String get apellidoUsuario {
    return _prefs.getString('apellidoUsuario') ?? '';
  }

  set apellidoUsuario(String value) {
    _prefs.setString('apellidoUsuario', value);
    notifyListeners();
  }

  // GET y SET del correoUsuario
  String get correoUsuario {
    return _prefs.getString('correoUsuario') ?? '';
  }

  set correoUsuario(String value) {
    _prefs.setString('correoUsuario', value);
    notifyListeners();
  }

  // GET y SET del correoUsuario
  String get fechaNacimiento {
    return _prefs.getString('fechaNacimiento') ?? '';
  }

  set fechaNacimiento(String value) {
    _prefs.setString('fechaNacimiento', value);
    notifyListeners();
  }

  // GET y SET del clave
  String get clave {
    return _prefs.getString('clave') ?? '';
  }

  set clave(String value) {
    _prefs.setString('clave', value);
    notifyListeners();
  }

// GET y SET del clave
  String get telefono {
    return _prefs.getString('telefono') ?? '';
  }

  set telefono(String value) {
    _prefs.setString('telefono', value);
    notifyListeners();
  }

// GET y SET del clave
  String get pathFoto {
    return _prefs.getString('pathFoto') ?? '';
  }

  set pathFoto(String value) {
    _prefs.setString('pathFoto', value);
    notifyListeners();
  }




  //DATOS DE CONFIGURACIONES

  bool get idioma1 {
    return _prefs.getBool('idioma1') ?? false;
  }

  set idioma1(bool value) {
    _prefs.setBool('idioma1', value);
  }

bool get idioma2 {
    return _prefs.getBool('idioma2') ?? false;
  }

  set idioma2(bool value) {
    _prefs.setBool('idioma2', value);
  }
 

  // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? '';
  }

  set ultimaPagina(String value) {
    _prefs.setString('ultimaPagina', value);
  }
}
