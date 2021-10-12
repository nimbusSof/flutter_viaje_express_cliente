import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_viaje_express_cliente/src/providers/perfil/datosConfPerfil_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/global/formsCliente_provider.dart';
import 'package:flutter_viaje_express_cliente/src/services/perfil/updateCliente_service.dart';

import 'package:flutter_viaje_express_cliente/src/services/services.dart';

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
          'perfilUsuario.inicio.btnConfiguracion'.tr(),
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
  @override
  Widget build(BuildContext context) {
    final clienteForm = Provider.of<FormsCliente>(context);
    //referencia donde se encuentran los controladores de los inputs
    final datosConfPerfil = Provider.of<DatosConfPerfil>(context);
    final updateClienteService = Provider.of<UpdateClienteService>(context);
    final prefs = Provider.of<PreferenciasUsuario>(context);
    final size = MediaQuery.of(context).size;

    /*traer los datos guardados en preferencias de usuario*/
    datosConfPerfil.nombresCtrl.text = prefs.nombreUsuario;
    datosConfPerfil.apellidosCtrl.text = prefs.apellidoUsuario;
    datosConfPerfil.emailCtrl.text = prefs.correoUsuario;
    datosConfPerfil.fechaCtrl.text = prefs.fechaNacimiento;
    datosConfPerfil.claveCtrl.text = prefs.clave;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        child: SingleChildScrollView(
          child: Form(
            // formulario unico
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
                  placeHolder: 'inputsGlobals.nombres'.tr(),
                  textController: datosConfPerfil.nombresCtrl,
                  keyboardType: TextInputType.name,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) {
                    if (value.toString().length > 0 ||
                        datosConfPerfil.nombresCtrl.text.length > 0) {
                      return null;
                    } else {
                      return 'alertsGlobals.nombres.null'.tr();
                    }
                  },
                ),
                CustomInput(
                  icon: Icons.person,
                  placeHolder: 'inputsGlobals.apellidos'.tr(),
                  textController: datosConfPerfil.apellidosCtrl,
                  keyboardType: TextInputType.name,
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    LengthLimitingTextInputFormatter(50),
                  ],
                  validator: (value) {
                    if (value.toString().length > 0 ||
                        datosConfPerfil.apellidosCtrl.text.length > 0) {
                      return null;
                    } else {
                      return 'alertsGlobals.apellidos.null'.tr();
                    }
                  },
                ),
                CustomSelectDate(
                    inputFieldDataController: datosConfPerfil.fechaCtrl),
                CustomInput(
                  icon: Icons.email,
                  placeHolder: 'inputsGlobals.correo'.tr(),
                  textController: datosConfPerfil.emailCtrl,
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
                CustomInput(
                  key: UniqueKey(),
                  validator: (value) {
                    print(value.toString() +
                        ' ' +
                        datosConfPerfil.claveCtrl.text);
                    if (value != null && value.length < 6) {
                      return 'alertsGlobals.password.sintaxis'.tr();
                    } else {
                      return null;
                    }
                  },
                  inputFormatter: [],
                  sufixIcon: Icons.visibility,
                  icon: Icons.lock_outline,
                  placeHolder: 'inputsGlobals.password'.tr(),
                  isPassword: true,
                  textController: datosConfPerfil.claveCtrl,
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: CustomButton(
                        text: 'buttonsGlobals.guardar'.tr(),
                        onPressed: () async {
                          FocusManager.instance.primaryFocus?.unfocus();
                          if (clienteForm.isValidFormConfPerfil()) {
                            final authService = Provider.of<AuthService>(
                                context,
                                listen: false);

                            String token = await authService.readToken();
                            String idPersonarol =
                                await authService.readIdPersonaRol();
                            

                            updateClienteService.updateNombre =
                                datosConfPerfil.nombresCtrl.text;

                            updateClienteService.updateApellido =
                                datosConfPerfil.apellidosCtrl.text;

                            updateClienteService.updateFechaNacimiento =
                                datosConfPerfil.fechaCtrl.text;

                            updateClienteService.updatecorreo =
                                datosConfPerfil.emailCtrl.text;

                            updateClienteService.updateClave =
                                datosConfPerfil.claveCtrl.text;

                            updateClienteService.updateModifiedBy =
                                idPersonarol;

                           

                            final bool? exito = await updateClienteService
                                .updateClienteService(idPersonarol, token);

                            if (exito == true) {
                              NotificationsService.showSnackbar(
                                  'perfilUsuario.configuracion.confirmacion'.tr());
                            } else {
                              NotificationsService.showSnackbar(
                                  'perfilUsuario.configuracion.error'.tr());
                            }
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
