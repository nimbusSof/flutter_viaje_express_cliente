part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class CambiarPanel extends SigninEvent {
  final int opcion;
  CambiarPanel(this.opcion);
}

class ActivarCliente extends SigninEvent {
  final RegistroCliente cliente;
  ActivarCliente(this.cliente);
}

class CambiarNombres extends SigninEvent {
  final String nombres;
  CambiarNombres(this.nombres);
}

class CambiarApellidos extends SigninEvent {
  final String apellidos;
  CambiarApellidos(this.apellidos);
}

class CambiarFechaNacimiento extends SigninEvent {
  final String fecha;
  CambiarFechaNacimiento(this.fecha);
}

class CambiarGenero extends SigninEvent {
  final String genero;
  CambiarGenero(this.genero);
}

class CambiarTelefono extends SigninEvent {
  final String telefono;
  CambiarTelefono(this.telefono);
}

class CambiarCorreo extends SigninEvent {
  final String correo;
  CambiarCorreo(this.correo);
}

class CambiarClave extends SigninEvent {
  final String clave;
  CambiarClave(this.clave);
}

class CambiarPathFoto extends SigninEvent {
  final String pathFoto;
  CambiarPathFoto(this.pathFoto);
}

class CambiarCedula extends SigninEvent {
  final String cedula;
  CambiarCedula(this.cedula);
}
