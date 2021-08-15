import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter_viaje_express_cliente/src/models/registroCliente.dart';

import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninState());

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is CambiarPanel) {
      yield SigninState(opcion: event.opcion);
    } else if (event is CambiarNombres) {
      yield state.copyWith(
          registroCliente:
              state.registroCliente!.copyWith(nombre: event.nombres));
    } else if (event is CambiarApellidos) {
      yield state.copyWith(
          registroCliente:
              state.registroCliente!.copyWith(apellido: event.apellidos));
    } else if (event is CambiarCedula) {
      
      yield state.copyWith(
          registroCliente:
              state.registroCliente!.copyWith(cedula: event.cedula));
    } else if (event is ActivarCliente) {
      
      final newUsuario = new RegistroCliente(
        nombre: '',
        apellido: '',
        fechaNacimiento: new DateTime.now(),
        genero: '',
        telefono: '',
        correo: '',
        clave: '',
        pathFoto: '',
        cedula: '',
      );
      yield state.copyWith(registroCliente: newUsuario);
    }
  }
}
