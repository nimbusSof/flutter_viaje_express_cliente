part of 'signin_bloc.dart';

class SigninState {
  final int opcion;
  final bool existeUsuario;
  final RegistroCliente? registroCliente;

  SigninState(
      {this.opcion = 0,  RegistroCliente? cliente})
      : registroCliente = cliente ?? null,
        existeUsuario = (cliente != null) ? true : false;

  SigninState copyWith(
          {int? opcion,
          bool? existeUsuario,
          RegistroCliente? registroCliente}) =>
      SigninState(
          opcion: opcion ?? this.opcion,
          cliente: registroCliente ?? this.registroCliente);

  SigninState estadoInicial() => new SigninState();
}
