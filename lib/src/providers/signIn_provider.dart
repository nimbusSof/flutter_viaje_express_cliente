import 'package:flutter/cupertino.dart';

class SignInFormProvider extends ChangeNotifier {
  GlobalKey<FormState> formkeylogin = new GlobalKey<FormState>();
  GlobalKey<FormState> formkey0 = new GlobalKey<FormState>();
  GlobalKey<FormState> formkey1 = new GlobalKey<FormState>();
  GlobalKey<FormState> formkey2 = new GlobalKey<FormState>();



  bool isValidFormLogin() {
    return formkeylogin.currentState?.validate() ?? false;
  }

  bool isValidForm0() {
    return formkey0.currentState?.validate() ?? false;
  }
  bool isValidForm1() {
    return formkey1.currentState?.validate() ?? false;
  }
  bool isValidForm2() {
    return formkey2.currentState?.validate() ?? false;
  }
}
