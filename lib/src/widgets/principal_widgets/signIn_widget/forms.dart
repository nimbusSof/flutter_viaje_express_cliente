import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/signIn_bloc/signin_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/providers/providers.dart';

import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:flutter_viaje_express_cliente/src/services/signUp_services/signUp_service.dart';
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
    final signUpService = Provider.of<SignUpServide>(context);

    if (signUpService.cliente.fechaNacimiento == null) {
      signUpService.agregarFechaNacimiento(DateTime.parse('1935-08-12'));
    }

    cedulaCtrl.text = signUpService.cliente.cedula;
    nombresCtrl.text = signUpService.cliente.nombre;
    apellidosCtrl.text = signUpService.cliente.apellido;

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
                signUpService.agregarCedula(cedulaCtrl.text);
                signUpService.agregarNombres(nombresCtrl.text);
                signUpService.agregarApellidos(apellidosCtrl.text);
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
    final signInBloc = BlocProvider.of<SigninBloc>(context);
    final signUpService = Provider.of<SignUpServide>(context);

    telefonoCtrl.text = signUpService.cliente.telefono;
    dateCtrl.text = signUpService.cliente.fechaNacimiento.toString();

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
                signUpService.agregarTelefono(telefonoCtrl.text);
                signUpService
                    .agregarFechaNacimiento(DateTime.parse(dateCtrl.text));
                signInBloc.add(CambiarPanel(2));
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
    final signUpService = Provider.of<SignUpServide>(context);

    emailCtrl.text = signUpService.cliente.correo;
    passCtrl.text = signUpService.cliente.clave;
    pass2Ctrl.text = signUpService.claveConfirmacion;
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
            key: UniqueKey(),
            sufixIcon: Icons.visibility,
            icon: Icons.lock_outline,
            placeHolder: 'Password',
            isPassword: true,
            textController: passCtrl,
          ),
          CustomInput(
            key: UniqueKey(),
            sufixIcon: Icons.visibility,
            icon: Icons.lock_outline,
            placeHolder: 'Confirmar Password',
            isPassword: true,
            textController: pass2Ctrl,
          ),
          CustomButton(
              text: 'Finalizar Registro',
              onPressed: () async {
                final SignUpProvider signUp = new SignUpProvider();
                final signUpService =
                    Provider.of<SignUpServide>(context, listen: false);
                signUpService.agregarPassword(passCtrl.text != ''
                    ? passCtrl.text
                    : signUpService.cliente.cedula);
                signUpService.agregarCorreo(emailCtrl.text);

                // Transformar el genero para ingresar a la base de datos
                if (signUpService.cliente.genero == 'masculino') {
                  signUpService.agregarGenero('M');
                } else if (signUpService.cliente.genero == 'femenino') {
                  signUpService.agregarGenero('F');
                } else if (signUpService.cliente.genero == 'otro') {
                  signUpService.agregarGenero('O');
                }
                print('genero: '+signUpService.cliente.genero);
                final bool? exito =
                    await signUp.createUser(signUpService.cliente);

                if (exito == true) {
                  signUpService.removerCliente();
                  NotificationsService.showSnackbar(
                      '¡Usuario creado exitosamente!');
                  Navigator.pushReplacementNamed(context, 'login');
                } else {
                  // mostrar error en pantalla
                  NotificationsService.showSnackbar(
                      'No se pudo registrar el usuario');
                  BlocProvider.of<SigninBloc>(context).add(CambiarPanel(0));
                }
              }),
          SizedBox(height: 15),
          CustomButton(
              text: 'Regresar',
              onPressed: () {
                signUpService.agregarCorreo(emailCtrl.text);
                signUpService.agregarPassword(passCtrl.text);
                signUpService.agregarConfirmacionPassword(pass2Ctrl.text);
                BlocProvider.of<SigninBloc>(context).add(CambiarPanel(1));
              }),
          LabelCancelar(subtitulo: 'Cancelar')
        ],
      ),
    );
  }
}
