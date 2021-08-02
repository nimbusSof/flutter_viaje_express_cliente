import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_selectDate.dart';

class ConfiguracionPerfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: Text(
          'Configuración de perfil',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black45,
          ),
        ),
      ),
      body: _EstructuraPage(),
    );
  }
}

class _EstructuraPage extends StatelessWidget {
  final nombresCtrl = new TextEditingController();
  final apellidosCtrl = new TextEditingController();
  final emailCtrl = new TextEditingController();
  final fechaCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width*0.05),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(vertical: 45),
                child: Center(
                  child: CircleAvatar(
                    backgroundColor: grisOscuroColor,
                    radius: 80,
                  ),
                ),
              ),
              CustomInput(
                icon: Icons.person,
                placeHolder: 'Nombres',
                textController: nombresCtrl,
                keyboardType: TextInputType.name,
              ),
              CustomInput(
                icon: Icons.person,
                placeHolder: 'Apellidos',
                textController: apellidosCtrl,
                keyboardType: TextInputType.name,
              ),

              CustomSelectDate(inputFieldDataController: fechaCtrl),

              CustomInput(
                icon: Icons.email,
                placeHolder: 'Correo electrónico',
                textController: emailCtrl,
                keyboardType: TextInputType.emailAddress,
              ),
              CustomButton(text: 'Guardar', onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }
}