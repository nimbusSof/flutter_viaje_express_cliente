import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/providers/signin/forms_signIn_provider.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:provider/provider.dart';

class ReiniciarClave extends StatelessWidget {
  const ReiniciarClave({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: _EstructuraPage(),
    ));
  }
}

class _EstructuraPage extends StatelessWidget {
  const _EstructuraPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
          height: 340,
          margin: EdgeInsets.symmetric(horizontal: 22),
          padding: EdgeInsets.fromLTRB(20, 30, 10, 20),
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Column(
            //crossAxisAlignment: CrossAxisAlignment.center,
            //mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              titulo(),
              SizedBox(height: 15),
              subtitulo(),
              SizedBox(height: 15),
              email(context),
              SizedBox(height: 12),
              botonReiniciar(),
              SizedBox(height: 12),
              botonRegresar(context)
            ],
          )),
    );
  }

  titulo() {
    return Text('Viaje Express', style: TextStyle(fontSize: 20));
  }

  subtitulo() {
    return Text(
      'reiniciarClave.titulo'.tr(),
      style: TextStyle(fontSize: 30),
    );
  }

  email(BuildContext context) {
    final signInForm = Provider.of<SignInFormProvider>(context);
    TextEditingController emailCtrl = new TextEditingController();
    return Form(
      key: signInForm.formReiniciarClave,
      child: CustomInput(
        icon: Icons.email,
        placeHolder: 'inputsGlobals.correo'.tr(),
        textController: emailCtrl,
        keyboardType: TextInputType.emailAddress,
        inputFormatter: [],
        validator: (value) {
          if (value != null && value.length > 0) {
            String pattern =
                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
            RegExp regExp = new RegExp(pattern);
            return regExp.hasMatch(value)
                ? null
                : 'alertsGlobals.correo.sintaxis'.tr();
          } else {
            return 'alertsGlobals.correo.null'.tr();
          }
        },
      ),
    );
  }

  botonReiniciar() {
    return CustomButton(text: 'reiniciarClave.btnReiniciar'.tr(), onPressed: () {});
  }

  botonRegresar(BuildContext context) {
    return TextButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, 'signin');
        },
        child: Text(
          'reiniciarClave.regresar'.tr(),
          style: TextStyle(
              fontSize: 20, color: Colors.blue, fontWeight: FontWeight.normal),
        ));
  }
}
