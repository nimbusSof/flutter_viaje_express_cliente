import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/providers/forms_signIn_signUp_provider.dart';
import 'package:flutter_viaje_express_cliente/src/services/configuraciones/idiomaUser_service.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/principal_widgets/labels.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/principal_widgets/login_widget/logo.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          physics:
              BouncingScrollPhysics(), //animacion rebote tanto en IOs como en android
          child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Logo(
                  titulo: 'signIn.frase'.tr(),
                ),
                ChangeNotifierProvider(
                    create: (_) => SignInFormProvider(), child: _Form()),
                Labels(
                  ruta: 'signin',
                  titulo: 'signIn.cuentaPregunta'.tr(),
                  subtitulo: 'signIn.crearCuenta'.tr(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signInForm = Provider.of<SignInFormProvider>(context);
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: signInForm.formkeylogin,
        //autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: <Widget>[
            CustomInput(
              key: UniqueKey(),
              icon: Icons.mail_outline,
              placeHolder: 'inputsGlobals.correo'.tr(),
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
              inputFormatter: [],
              validator: (value) {
                if (value != null && value.length > 0) {
                  String pattern =
                      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                  RegExp regExp = new RegExp(pattern);
                  return regExp.hasMatch(value.trim())
                      ? null
                      : 'Sintaxis de correo es errónea';
                } else {
                  return 'alertsGlobals.correo.null'.tr();
                }
              },
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomInput(
                  key: UniqueKey(),
                  icon: Icons.lock_outline,
                  placeHolder: 'inputsGlobals.password'.tr(),
                  isPassword: true,
                  textController: passCtrl,
                  validator: (value) {
                    if (value != null && value.length > 0) {
                      return null;
                    } else {
                      return 'alertsGlobals.password.null'.tr();
                    }
                  },
                  inputFormatter: []),
            ),
            CustomButton(
                text: 'buttonsGlobals.ingresar'.tr(),
                onPressed: () async {
                  //cierra el teclado del telefono
                  FocusScope.of(context).unfocus();
                  //instancia provider

                  if (signInForm.isValidFormLogin()) {
                    final authService =
                        Provider.of<AuthService>(context, listen: false);

                    final bool? exito =
                        await authService.login(emailCtrl.text, passCtrl.text);

                    if (exito != null && exito == true) {
                      inicializarIdioma();
                      Navigator.pushReplacementNamed(context, 'inicio');
                    } else {
                      // mostrar error en pantalla
                      NotificationsService.showSnackbar(
                          'signIn.mensaje.credenciales'.tr());
                    }
                  }
                })
          ],
        ),
      ),
    );
  }

  void inicializarIdioma() async {
    final idiomaUserService = new IdiomaUser();
    final authService = Provider.of<AuthService>(context, listen: false);
    String token = await authService.readToken();
    String idPersonarol = await authService.readIdPersonaRol();
    String idioma =
        await idiomaUserService.idiomaClienteService(idPersonarol, token);
    String idiomita = '';

    if (idioma == 'español') {
      await context.setLocale(Locale('es'));
    } else if (idioma == 'ingles') {
      await context.setLocale(Locale('en'));
    } else if (idioma == '') {
      String idiomaDispositivo =
          context.deviceLocale.toString().substring(0, 2);

      if (idiomaDispositivo == 'es' || idiomaDispositivo == 'en') {
        if (idiomaDispositivo == 'es') {
          idiomita = 'español';
        }
        if (idiomaDispositivo == 'en') {
          idiomita = 'ingles';
        }
        await context.setLocale(Locale(idiomaDispositivo));
        await idiomaUserService.idiomaClienteServicePost(
            idPersonarol, token, idiomita);
      } else {
        //se coloca idioma ingles por defecto en caso de que el dispositivo tenga otro idima
        context.setLocale(context.locale);
        await idiomaUserService.idiomaClienteServicePost(
            idPersonarol, token, 'ingles');
      }
    }
  }
}
