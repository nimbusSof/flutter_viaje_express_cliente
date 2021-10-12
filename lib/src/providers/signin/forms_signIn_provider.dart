import 'package:flutter/material.dart';

class SignInFormProvider extends ChangeNotifier {

  GlobalKey<FormState> formkeylogin = new GlobalKey<FormState>();
  GlobalKey<FormState> formReiniciarClave = new GlobalKey<FormState>();


  bool isValidFormLogin() {
    return formkeylogin.currentState?.validate() ?? false;
  }

  bool isValidFormReiniciarClave() {
    return formReiniciarClave.currentState?.validate() ?? false;
  }

}
