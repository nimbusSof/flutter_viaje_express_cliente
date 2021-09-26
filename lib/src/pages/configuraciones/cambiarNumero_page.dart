import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_viaje_express_cliente/src/providers/datosConfiguraciones_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/providers.dart';
import 'package:flutter_viaje_express_cliente/src/services/perfil_services/updateCliente_service.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:provider/provider.dart';

class CambiarNumeroPage extends StatefulWidget {
  @override
  _CambiarNumeroPageState createState() => _CambiarNumeroPageState();
}

class _CambiarNumeroPageState extends State<CambiarNumeroPage> {
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'cambiarNumero';
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
              child: Icon(
                Icons.arrow_back,
                size: 30,
                color: grisOscuroColor,
              ),
              onTap: () {
                Navigator.pushReplacementNamed(
                    context, 'configuraciones_inicio');
              }),
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          title: Text(
            'Cambiar número',
            style: TextStyle(
              fontSize: 20,
              color: Colors.black45,
            ),
          ),
        ),
        body: _EstructuraPage(),
      ),
    );
  }
}

class _EstructuraPage extends StatefulWidget {
  @override
  __EstructuraPageState createState() => __EstructuraPageState();
}

class __EstructuraPageState extends State<_EstructuraPage> {
  //final telefonoCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final datosConf = Provider.of<DatosConfiguraciones>(context);
    final prefs = Provider.of<PreferenciasUsuario>(context);

    final size = MediaQuery.of(context).size;
    final formsCliente = Provider.of<FormsCliente>(context);

    //inicializar datos del constructor
    datosConf.numeroCtrl.text = prefs.telefono;

    return Container(
        padding: EdgeInsets.all(size.height * 0.03),
        child: Form(
          key: formsCliente.formkeyCambiarNumero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              texto(),
              telefono(datosConf.numeroCtrl),
              boton(datosConf.numeroCtrl)
            ],
          ),
        ));
  }

  texto() {
    return Container(
      child: RichText(
        text: TextSpan(
            text:
                'Al cambiar su número, su cuenta y sus datos se transferiran' +
                    'a su nuevo número',
            style: TextStyle(color: Colors.black54)),
      ),
    );
  }

  telefono(TextEditingController telefonoCtrl) {
    return CustomInput(
      icon: Icons.phone,
      placeHolder: 'Su número de teléfono',
      textController: telefonoCtrl,
      keyboardType: TextInputType.phone,
      inputFormatter: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      validator: (value) {
        if (value != null && value.length > 0) {
          String pattern = r'(^09)[1-9]{8}$';
          RegExp regExp = new RegExp(pattern);
          return regExp.hasMatch(value.trim())
              ? null
              : 'número de teléfono inválido';
        } else {
          return 'Porfavor ingresa tu número de teléfono';
        }
      },
    );
  }

  boton(TextEditingController telefonoCtrl) {
    final formsCliente = Provider.of<FormsCliente>(context);
    return CustomButton(
        text: 'Guardar',
        onPressed: () async {
          //cierra el teclado del telefono
          FocusManager.instance.primaryFocus?.unfocus();

          if (formsCliente.isValidFormCambiarNumero()) {

            final authService =
                Provider.of<AuthService>(context, listen: false);

            final updateClienteService =
                Provider.of<UpdateClienteService>(context, listen: false);    

            String token = await authService.readToken();
            String idPersona_rol = await authService.readIdPersonaRol();

            

            updateClienteService.updateTelefono = telefonoCtrl.text;

            final bool? exito = await updateClienteService.updateClienteService(
                idPersona_rol, token);

            if (exito == true) {
              NotificationsService.showSnackbar('¡Teléfono actualizado!');
            } else {
              NotificationsService.showSnackbar(
                  'Actualización de teléfono fallida');
            }
          }
        });
  }
}
