import 'package:flutter/cupertino.dart';

class FormsCliente extends ChangeNotifier {
  GlobalKey<FormState> formkeyConfPerfil = new GlobalKey<FormState>();
  GlobalKey<FormState> formkeyCambiarNumero = new GlobalKey<FormState>();
  GlobalKey<FormState> formkeyPagoTarjeta = new GlobalKey<FormState>();
  GlobalKey<FormState> formkeyViajeNuevo = new GlobalKey<FormState>();

  bool isValidFormConfPerfil() {
    return formkeyConfPerfil.currentState?.validate() ?? false;
  }

  bool isValidFormCambiarNumero() {
    return formkeyCambiarNumero.currentState?.validate() ?? false;
  }

  bool isValidFormPagoTarjeta() {
    return formkeyPagoTarjeta.currentState?.validate() ?? false;
  }

  bool isValidFormViajeNuevo() {
    return formkeyViajeNuevo.currentState?.validate() ?? false;
  }
}
