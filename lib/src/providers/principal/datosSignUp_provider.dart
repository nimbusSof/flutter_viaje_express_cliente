import 'package:flutter/cupertino.dart';
import 'package:flutter_viaje_express_cliente/src/models/registroCliente.dart';

class SignUpProvider with ChangeNotifier {
  RegistroCliente _cliente = new RegistroCliente();
  String _claveConfirmacion = '';

  RegistroCliente get cliente => this._cliente;

  set cliente(RegistroCliente cliente) {
    this._cliente = cliente;
    notifyListeners();
  }

  String get claveConfirmacion => this._claveConfirmacion;
  
  set claveConfirmacion(String claveConfirmacion) {
    this._claveConfirmacion = claveConfirmacion;
    notifyListeners();
  }

  // DATOS DEL FORMULARIO 1
  void agregarNombres(String nombres) {
    this._cliente.nombre = nombres;
    notifyListeners();
  }

  void agregarApellidos(String apellidos) {
    this._cliente.apellido = apellidos;
  }

  void agregarCedula(String cedula) {
    this._cliente.cedula = cedula;
  }

// DATOS DEL FORMULARIO 2

  void agregarTelefono(String telefono) {
    this._cliente.telefono = telefono;
  }

  void agregarGenero(String genero) {
    this._cliente.genero = genero;
  }

  void agregarFechaNacimiento(DateTime fecha) {
    this._cliente.fechaNacimiento = fecha;
  }

// DATOS DEL FORMULARIO 3

  void agregarCorreo(String correo) {
    this._cliente.correo = correo;
  }

  void agregarPassword(String password) {
    this._cliente.clave = password;
  }

  void agregarConfirmacionPassword(String confirmacion) {
    this._claveConfirmacion = confirmacion;
  }




// METODOS
  void removerCliente() {
    RegistroCliente cliente = new RegistroCliente();
    this._cliente = cliente;
    this._claveConfirmacion = '';
    notifyListeners();
  }
  
}
