import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_viaje_express_cliente/src/providers/providers.dart';
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
        body: ChangeNotifierProvider(
            create: (_) => FormsCliente(), child: _EstructuraPage()),
      ),
    );
  }
}

class _EstructuraPage extends StatefulWidget {
  @override
  __EstructuraPageState createState() => __EstructuraPageState();
}

class __EstructuraPageState extends State<_EstructuraPage> {
  final telefonoCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final formsCliente = Provider.of<FormsCliente>(context);

    return Container(
        padding: EdgeInsets.all(size.height * 0.03),
        child: Form(
          key: formsCliente.formkeyCambiarNumero,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[texto(), telefono(), boton()],
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

  telefono() {
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

  boton() {
    final formsCliente = Provider.of<FormsCliente>(context);
    return CustomButton(
        text: 'Guardar',
        onPressed: () {
          
          //cierra el teclado del telefono
          FocusManager.instance.primaryFocus?.unfocus();
          if (formsCliente.isValidFormCambiarNumero()) {
           
          }
        });
  }
}
