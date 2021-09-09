part of 'signUp_bloc.dart';

@immutable
abstract class SignUpEvent {}

class CambiarPanel extends SignUpEvent {
  final int opcion;
  CambiarPanel(this.opcion);
}


