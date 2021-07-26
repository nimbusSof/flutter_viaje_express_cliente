import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_viaje_express_cliente/src/bloc/signIn_bloc/signin_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_dropDown.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/labels.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/logo_signin.dart';

class SignInPage extends StatelessWidget {
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
              //height: MediaQuery.of(context).size.height * 0.8,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  LogoSignIn(),
                  SizedBox(height: 35),
                  SiguientePanel(),
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
      } else if (state.opcion == 2) {
        return _Form2();
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
  final cedulaCtrl = TextEditingController();
  final nombresCtrl = TextEditingController();
  final apellidosCtrl = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'Cédula',
              keyboardType: TextInputType.number,
              textController: cedulaCtrl),
          CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'Nombres',
              keyboardType: TextInputType.name,
              textController: nombresCtrl),
          CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'Apellidos',
              keyboardType: TextInputType.name,
              textController: apellidosCtrl),

          

          CustomButton(
              text: 'Siguiente',
              onPressed: () {
                BlocProvider.of<SigninBloc>(context).add(CambiarPanel(1));
              }),
          SizedBox(height: 35),
          Labels(
            ruta: 'login',
            titulo: '¿Ya tienes cuenta?',
            subtitulo: '¡Ingresa ahora!',
          ),
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
  final telefonoCtrl = TextEditingController();
   List<String> listaGenero = ['masculino', 'femenino', 'otro'];
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: <Widget>[
          CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'Teléfono',
              keyboardType: TextInputType.phone,
              textController: telefonoCtrl),
              CustomDropDown(lista: listaGenero),
          CustomButton(
              text: 'Siguiente',
              onPressed: () {
                BlocProvider.of<SigninBloc>(context).add(CambiarPanel(2));
              }),
              SizedBox(height: 15),
          CustomButton(
              text: 'Regresar',
              onPressed: () {
                BlocProvider.of<SigninBloc>(context).add(CambiarPanel(0));
              }),

              LabelCancelar(subtitulo: 'Cancelar')
        ],
      ),
    );
  }
}

class _Form2 extends StatefulWidget {
  @override
  __Form2State createState() => __Form2State();
}

class __Form2State extends State<_Form2> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final pass2Ctrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
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
          CustomInput(
            icon: Icons.lock_outline,
            placeHolder: 'Confirmar Password',
            isPassword: true,
            textController: pass2Ctrl,
          ),
          CustomButton(
              text: 'Finalizar Registro',
              onPressed: () {
                BlocProvider.of<SigninBloc>(context).add(CambiarPanel(1));
              }),
              SizedBox(height: 15),
          CustomButton(
              text: 'Regresar',
              onPressed: () {
                BlocProvider.of<SigninBloc>(context).add(CambiarPanel(1));
              }),
              LabelCancelar(subtitulo: 'Cancelar')
        ],
      ),
    );
  }
}





