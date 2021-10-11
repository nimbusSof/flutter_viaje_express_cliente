import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/signUp_bloc/signUp_bloc.dart';

import 'package:flutter_viaje_express_cliente/src/providers/providers.dart';
import 'package:flutter_viaje_express_cliente/src/providers/forms_signIn_signUp_provider.dart';

import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:flutter_viaje_express_cliente/src/providers/principal/datosSignUp_provider.dart';
import 'package:flutter_viaje_express_cliente/src/utils/Validaciones/validaciones.dart';
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
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    final signUpService = Provider.of<SignUpProvider>(context);
    final signInForm = Provider.of<SignInFormProvider>(context);

    // se pone fecha por defecto al signUp
    /* if (signUpService.cliente.fechaNacimiento == null) {
      signUpService.agregarFechaNacimiento(DateTime.parse('1935-08-12'));
    } */

    cedulaCtrl.text = signUpService.cliente.cedula;
    nombresCtrl.text = signUpService.cliente.nombre;
    apellidosCtrl.text = signUpService.cliente.apellido;

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: signInForm.formkey0,
        child: Column(
          children: <Widget>[
            CustomInput(
              icon: Icons.perm_identity,
              placeHolder: 'inputsGlobals.cedula'.tr(),
              keyboardType: TextInputType.number,
              textController: cedulaCtrl,
              validator: (value) {
                if (value != null && value.length > 0) {
                  if (cedulaEcuatorianaValida(value)) {
                    return null;
                  } else {
                    return 'alertsGlobals.cedula.sintaxis'.tr();
                  }
                } else {
                  return 'alertsGlobals.cedula.null'.tr();
                }
              },
              inputFormatter: [
                LengthLimitingTextInputFormatter(10),
                FilteringTextInputFormatter.digitsOnly
              ],
            ),
            CustomInput(
                icon: Icons.perm_identity,
                placeHolder: 'inputsGlobals.nombres'.tr(),
                keyboardType: TextInputType.name,
                textController: nombresCtrl,
                validator: (value) {
                  if (value != null && value.length > 0) {
                    return null;
                  } else {
                    return 'alertsGlobals.nombres.null'.tr();
                  }
                },
                inputFormatter: [
                  FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                  LengthLimitingTextInputFormatter(50),
                ]),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomInput(
                  icon: Icons.perm_identity,
                  placeHolder: 'inputsGlobals.apellidos'.tr(),
                  keyboardType: TextInputType.name,
                  textController: apellidosCtrl,
                  validator: (value) {
                    if (value != null && value.length > 0) {
                      return null;
                    } else {
                      return 'alertsGlobals.apellidos.null'.tr();
                    }
                  },
                  inputFormatter: [
                    FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")),
                    LengthLimitingTextInputFormatter(50),
                  ]),
            ),
            CustomButton(
                text: 'buttonsGlobals.ingresar'.tr(),
                onPressed: () {
                  //cierra el teclado del telefono
                  FocusManager.instance.primaryFocus?.unfocus();
                  //ejecuta validaciones
                  if (signInForm.isValidForm0()) {
                    signUpService.agregarCedula(cedulaCtrl.text);
                    signUpService.agregarNombres(nombresCtrl.text);
                    signUpService.agregarApellidos(apellidosCtrl.text);
                    signUpBloc.add(CambiarPanel(1));
                  }
                }),
            SizedBox(height: 35),
            Labels(
              ruta      : 'login',
              titulo    : 'signUp.cuentaPregunta'.tr(),
              subtitulo : 'signUp.cuentaIngresar'.tr(),
            ),
          ],
        ),
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

  @override
  Widget build(BuildContext context) {
    final signUpBloc = BlocProvider.of<SignUpBloc>(context);
    final signUpService = Provider.of<SignUpProvider>(context);
    final signInForm = Provider.of<SignInFormProvider>(context);

    telefonoCtrl.text = signUpService.cliente.telefono;

    // agrega la fecha fuardada en el estado provider
    if (signUpService.cliente.fechaNacimiento != null) {
      dateCtrl.text = signUpService.cliente.fechaNacimiento.toString();
    }

    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: signInForm.formkey1,
        child: Column(
          children: <Widget>[
            CustomInput(
                icon: Icons.perm_identity,
                placeHolder: 'inputsGlobals.telefono'.tr(),
                keyboardType: TextInputType.phone,
                textController: telefonoCtrl,
                validator: (value) {
                  if (value != null && value.length > 0) {
                    String pattern = r'(^09)[1-9]{8}$';
                    RegExp regExp = new RegExp(pattern);
                    return regExp.hasMatch(value.trim())
                        ? null
                        : 'alertsGlobals.telefono.sintaxis'.tr();
                  } else {
                    return 'alertsGlobals.telefono.null'.tr();
                  }
                },
                inputFormatter: [FilteringTextInputFormatter.digitsOnly]),
            //dropdown tiene lista género en su clase
            CustomDropDown(genero: true),
            Container(
                margin: EdgeInsets.only(bottom: 10),
                child: CustomSelectDate(inputFieldDataController: dateCtrl)),
            CustomButton(
                text: 'buttonsGlobals.siguiente'.tr(),
                onPressed: () async {
                  //cierra el teclado del telefono
                  FocusManager.instance.primaryFocus?.unfocus();
                  //FocusScope.of(context).unfocus(); //activar esta linea provoca un bug en el teclado
                  //validacion del formulario
                  if (signInForm.isValidForm1()) {
                    signUpService.agregarTelefono(telefonoCtrl.text);
                    signUpService
                        .agregarFechaNacimiento(DateTime.parse(dateCtrl.text));
                    signUpBloc.add(CambiarPanel(2));
                  }
                }),
            SizedBox(height: 15),
            CustomButton(
                text: 'buttonsGlobals.regresar'.tr(),
                onPressed: () {
                  BlocProvider.of<SignUpBloc>(context).add(CambiarPanel(0));
                }),
            LabelCancelar(subtitulo: 'signUp.cancelar'.tr())
          ],
        ),
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
    final signUpService = Provider.of<SignUpProvider>(context);
    final signInForm = Provider.of<SignInFormProvider>(context);

    emailCtrl.text = signUpService.cliente.correo;
    passCtrl.text = signUpService.cliente.clave;
    pass2Ctrl.text = signUpService.claveConfirmacion;
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 50),
      child: Form(
        key: signInForm.formkey2,
        child: Column(
          children: <Widget>[
            CustomInput(
              icon: Icons.mail_outline,
              placeHolder: 'inputsGlobals.correo'.tr(),
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
              inputFormatter: [],
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
            ),

            //  PASSWORD 
            CustomInput(
              key: UniqueKey(),
              validator: (value) {
                //print(value.toString() + ' ' + pass2Ctrl.text);
                if (value != null && value.length < 6) {
                  return 'alertsGlobals.password.sintaxis'.tr();
                } else if (value.toString() != pass2Ctrl.text) {
                  return 'alertsGlobals.password.concidencia'.tr();
                } else {
                  return null;
                }
              },
              inputFormatter: [],
              sufixIcon: Icons.visibility,
              icon: Icons.lock_outline,
              placeHolder: 'inputsGlobals.password'.tr(),
              isPassword: true,
              textController: passCtrl,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: CustomInput(
                key: UniqueKey(),
                validator: (value) {
                  if (value != null && value.length < 6) {
                    return 'alertsGlobals.password.sintaxis'.tr();
                  } else {
                    return null;
                  }
                },
                inputFormatter: [],
                sufixIcon: Icons.visibility,
                icon: Icons.lock_outline,
                placeHolder: 'inputsGlobals.password2'.tr(),
                isPassword: true,
                textController: pass2Ctrl,
              ),
            ),
            CustomButton(
                text: 'buttonsGlobals.finalizarReg'.tr(),
                onPressed: () async {
                  //cierra el teclado del telefono
                  FocusManager.instance.primaryFocus?.unfocus();
                  //FocusScope.of(context).unfocus(); //linea bug (cierra el teclado pero muestra el en los input el estado anterior)
                  //providers
                  if (signInForm.isValidForm2()) {
                    //ejecuta validaciones
                    final SignUpService signUp = new SignUpService();
                    final signUpService =
                        Provider.of<SignUpProvider>(context, listen: false);

                    signUpService.agregarConfirmacionPassword(pass2Ctrl.text);
                    signUpService.agregarPassword(passCtrl.text != ''
                        ? passCtrl.text
                        : signUpService.cliente.cedula);
                    signUpService.agregarCorreo(emailCtrl.text);

                    // Transformar el genero para ingresar a la base de datos
                    if (signUpService.cliente.genero == 'inputsGlobals.ddGenero.masculino'.tr()) {
                      signUpService.agregarGenero('M');
                    } else if (signUpService.cliente.genero == 'inputsGlobals.ddGenero.femenino'.tr()) {
                      signUpService.agregarGenero('F');
                    } else if (signUpService.cliente.genero == 'inputsGlobals.ddGenero.otro'.tr()) {
                      signUpService.agregarGenero('O');
                    }
                    //print('genero: ' + signUpService.cliente.genero);
                    final bool? exito =
                        await signUp.createUser(signUpService.cliente);

                    if (exito == true) {
                      signUpService.removerCliente();
                      NotificationsService.showSnackbar(
                          'signUp.mensaje.confirmacion'.tr());
                      Navigator.pushReplacementNamed(context, 'login');
                    } else {
                      // mostrar error en pantalla
                      NotificationsService.showSnackbar(
                          'signUp.mensaje.error'.tr());
                      BlocProvider.of<SignUpBloc>(context).add(CambiarPanel(0));
                    }
                  }
                }),
            SizedBox(height: 15),
            CustomButton(
                text: 'buttonsGlobals.regresar'.tr(),
                onPressed: () {
                  signUpService.agregarCorreo(emailCtrl.text);
                  signUpService.agregarPassword(passCtrl.text);
                  signUpService.agregarConfirmacionPassword(pass2Ctrl.text);
                  BlocProvider.of<SignUpBloc>(context).add(CambiarPanel(1));
                }),
            LabelCancelar(subtitulo: 'signUp.cancelar'.tr())
          ],
        ),
      ),
    );
  }
}
