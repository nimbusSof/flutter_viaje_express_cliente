import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signin_event.dart';
part 'signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  SigninBloc() : super(SigninState());

  @override
  Stream<SigninState> mapEventToState(SigninEvent event) async* {
    if (event is CambiarPanel) {
      yield SigninState(opcion: event.opcion);
    } 
  }
}
