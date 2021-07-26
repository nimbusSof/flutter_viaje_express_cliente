import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/signIn_bloc/signin_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_dropDown.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/custom_selectDate.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/principal_widgtets/labels.dart';




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