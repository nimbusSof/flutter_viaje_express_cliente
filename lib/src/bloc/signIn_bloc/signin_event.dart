part of 'signin_bloc.dart';

@immutable
abstract class SigninEvent {}

class CambiarPanel extends SigninEvent {
  final int opcion;
  CambiarPanel(this.opcion);
}


