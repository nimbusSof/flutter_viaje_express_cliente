import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_viaje_express_cliente/src/bloc/signIn_bloc/signin_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/labels.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/logo_signin.dart';

class SignInPage extends StatelessWidget {
  final int op = 0;
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => SigninBloc(),
        )
      ],
      child: Scaffold(
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
                  LogoSignIn(),
                  SiguientePanel(),
                  Labels(
                    ruta: 'login',
                    titulo: '¿Ya tienes cuenta?',
                    subtitulo: '¡Ingresa ahora!',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  
}


class SiguientePanel extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SigninBloc, SigninState>(builder: (_, state) {
      if (state.opcion == 0) {
        return _Form();
      } else if (state.opcion == 1) {
        return _Form1();
      } else {
        return _Form();
      }
    });
  }
}



class _Form extends StatefulWidget {
  @override
  __FormState createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'Nombre',
              keyboardType: TextInputType.name,
              textController: nameCtrl),
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
              text: 'Siguiente',
              onPressed: () {
                BlocProvider.of<SigninBloc>(context).add(CambiarPanel(1));
              })
        ],
      ),
    );
  }
}

class _Form1 extends StatefulWidget {
  @override
  __Form1State createState() => __Form1State();
}

class __Form1State extends State<_Form1> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final nameCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'Nombre',
              keyboardType: TextInputType.name,
              textController: nameCtrl),
          CustomButton(text: 'Siguiente', onPressed: () {})
        ],
      ),
    );
  }
}
