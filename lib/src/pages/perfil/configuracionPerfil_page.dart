import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_viaje_express_cliente/src/providers/formsCliente_provider.dart';

import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_selectDate.dart';
import 'package:provider/provider.dart';

class ConfiguracionPerfilPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'configuracionPerfil';
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(
              Icons.arrow_back,
              size: 30,
              color: grisOscuroColor,
            ),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'perfil_inicio');
            }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'Configuración de perfil',
          style: TextStyle(
            fontSize: 20,
            color: Colors.black45,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
          create: (_) => FormsCliente(), child: _EstructuraPage()),
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
    final clienteForm = Provider.of<FormsCliente>(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SingleChildScrollView(
          child: Form( // formulario unico
            key: clienteForm.formkeyConfPerfil,
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
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) {
                    if (value.toString().length > 0 ||
                        nombresCtrl.text.length > 0) {
                      return null;
                    } else {
                      return 'Porfavor ingresa tus nombres';
                    }
                  },
                ),
                CustomInput(
                  icon: Icons.person,
                  placeHolder: 'Apellidos',
                  textController: apellidosCtrl,
                  keyboardType: TextInputType.name,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) {
                    if (value.toString().length > 0 ||
                        apellidosCtrl.text.length > 0) {
                      return null;
                    } else {
                      return 'Porfavor ingresa tus apellidos';
                    }
                  },
                ),
                CustomSelectDate(inputFieldDataController: fechaCtrl),
                CustomInput(
                  icon: Icons.email,
                  placeHolder: 'Correo electrónico',
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
                          : 'Sintaxis de correo es errónea';
                    } else {
                      return 'Porfavor ingresa tu correo electrónico';
                    }
                  },
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: CustomButton(
                        text: 'Guardar',
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (clienteForm.isValidFormConfPerfil()) {
                            print('bien validado crack');
                          }
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
