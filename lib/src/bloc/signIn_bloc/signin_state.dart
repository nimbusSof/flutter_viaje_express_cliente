part of 'signin_bloc.dart';

@immutable
class SigninState {
  final int opcion;

  SigninState({this.opcion = 0});

  SigninState copyWith({int? opcion}) => new SigninState(opcion: opcion??this.opcion);
}
