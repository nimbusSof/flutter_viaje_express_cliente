import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'signUp_event.dart';
part 'signUp_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc() : super(SignUpState());

  @override
  Stream<SignUpState> mapEventToState(SignUpEvent event) async* {
    if (event is CambiarPanel) {
      yield SignUpState(opcion: event.opcion);
    } 
  }
}
