import 'package:flutter/material.dart';
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
                  titulo: 'Login',
                ),
                _Form(),
                Labels(
                  ruta: 'signin',
                  titulo: '¿No tienes cuenta?',
                  subtitulo: '¡Crea una ahora!',
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
    return Container(
      margin: EdgeInsets.only(top: 30),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
            icon: Icons.mail_outline,
            placeHolder: 'Correo',
            keyboardType: TextInputType.emailAddress,
            textController: emailCtrl,
          ),
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            isPassword: true,
            textController: passCtrl,
          ),
          CustomButton(
              text: 'Ingresar',
              onPressed: () async {
                //print('estoy ingresando');
                //instancia provider
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                

                final bool? exito =
                    await authService.login(emailCtrl.text, passCtrl.text);
                
                if (exito == true) {
                  Navigator.pushReplacementNamed(context, 'inicio');
                } else {
                  // mostrar error en pantalla
                  //print(errorMessage);
                  NotificationsService.showSnackbar('Credenciales erroneas');
                }
              })
        ],
      ),
    );
  }
}
