import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/signIn_bloc/signin_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/models/registroCliente.dart';

import 'package:flutter_viaje_express_cliente/src/services/auth_service.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_dropDown.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_selectDate.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/principal_widgets/labels.dart';
import 'package:provider/provider.dart';

// FORMULARIO CON LOS CAMPOS: CÉDULA, NOMBRES, APELLIDOS

class Form0 extends StatefulWidget {
  @override
  FormState createState() => FormState();
}

class FormState extends State<Form0> {
  final cedulaCtrl = TextEditingController();
  final nombresCtrl = TextEditingController();
  final apellidosCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final signInBloc = BlocProvider.of<SigninBloc>(context);

    cedulaCtrl.text = signInBloc.state.registroCliente?.cedula ?? '';
    nombresCtrl.text = signInBloc.state.registroCliente?.nombre ?? '';
    apellidosCtrl.text = signInBloc.state.registroCliente?.apellido ?? '';
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
                if (signInBloc.state.existeUsuario) {
                  print('opcion1');
                  signInBloc.add(CambiarCedula(cedulaCtrl.text));
                  signInBloc.add(CambiarNombres(nombresCtrl.text));
                  signInBloc.add(CambiarApellidos(apellidosCtrl.text));
                  print('Usuario: ${signInBloc.state.registroCliente!.cedula}');
                  print('Usuario: ${signInBloc.state.registroCliente!.nombre}');
                  print(
                      'Usuario: ${signInBloc.state.registroCliente!.apellido}');
                } else {
                   print('opcion2');
                  RegistroCliente cliente = new RegistroCliente();
                  signInBloc.add(ActivarCliente(cliente));
                  signInBloc.add(CambiarCedula(cedulaCtrl.text));
                  signInBloc.add(CambiarNombres(nombresCtrl.text));
                  signInBloc.add(CambiarApellidos(apellidosCtrl.text));
                  print('Usuario: ${signInBloc.state.registroCliente!.cedula}');
                  print('Usuario: ${signInBloc.state.registroCliente!.nombre}');
                  print(
                      'Usuario: ${signInBloc.state.registroCliente!.apellido}');
                }

                signInBloc.add(CambiarPanel(1));
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

// FORMULARIO CON LOS CAMPOS: TELÉFONO, FECHA DE NACIMIENTO, GÉNERO

class Form1 extends StatefulWidget {
  @override
  Form1State createState() => Form1State();
}

class Form1State extends State<Form1> {
  final telefonoCtrl = TextEditingController();
  final dateCtrl = TextEditingController();
  List<String> listaGenero = ['masculino', 'femenino', 'otro'];
  @override
  Widget build(BuildContext context) {
    //final signInBloc = BlocProvider.of<SigninBloc>(context);

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
          CustomSelectDate(inputFieldDataController: dateCtrl),
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

//FORMULARIO CON LOS CAMPOS: CORREO, PASSWORD, PASSWORD CONFIRMACIÓN

class Form2 extends StatefulWidget {
  @override
  Form2State createState() => Form2State();
}

class Form2State extends State<Form2> {
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
              onPressed: () async {
                final authService =
                    Provider.of<AuthService>(context, listen: false);
                final String? errorMessage =
                    await authService.createUser(emailCtrl.text, passCtrl.text);
                if (errorMessage == null) {
                } else {
                  // mostrar error en pantalla
                  print(errorMessage);
                }
                BlocProvider.of<SigninBloc>(context).add(CambiarPanel(0));
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
