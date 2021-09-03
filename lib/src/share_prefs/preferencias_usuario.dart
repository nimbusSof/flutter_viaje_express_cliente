import 'package:shared_preferences/shared_preferences.dart';

class PreferenciasUsuario {

  static final PreferenciasUsuario _instancia = new PreferenciasUsuario._internal();

  factory PreferenciasUsuario() {
    return _instancia;
  }

  PreferenciasUsuario._internal();

  late SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GET y SET del Genero
  int get genero {
    return _prefs.getInt('genero') ?? 1;
  }

  set genero( int value ) {
    _prefs.setInt('genero', value);
  }

 


  // GET y SET del nombreUsuario
  String get nombreUsuario {
    return _prefs.getString('nombreUsuario') ?? '';
  }

  set nombreUsuario( String value ) {
    _prefs.setString('nombreUsuario', value);
  }


// GET y SET del apellidoUsuario
  String get apellidoUsuario {
    return _prefs.getString('apellidoUsuario') ?? '';
  }

  set apellidoUsuario( String value ) {
    _prefs.setString('apellidoUsuario', value);
  }

  // GET y SET del correoUsuario
  String get correoUsuario {
    return _prefs.getString('correoUsuario') ?? '';
  }

  set correoUsuario( String value ) {
    _prefs.setString('correoUsuario', value);
  }

    // GET y SET de la última página
  String get ultimaPagina {
    return _prefs.getString('ultimaPagina') ?? '';
  }

  set ultimaPagina( String value ) {
    _prefs.setString('ultimaPagina', value);
  }

}


