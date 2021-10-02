import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_viaje_express_cliente/src/providers/formsCliente_provider.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_selectDate.dart';
import 'package:provider/provider.dart';

class PagoTarjetaPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'pagoTarjeta';
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
              Navigator.pushReplacementNamed(context, 'metodoPago_inicio');
            }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'metodoPago.tarjeta.titulo'.tr(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.black45,
          ),
        ),
      ),
      body: ChangeNotifierProvider(
          create: (_) => FormsCliente(), child: _EstructuraPage()),
    ));
  }
}

class _EstructuraPage extends StatelessWidget {
  final tarjetaCtrl = new TextEditingController();
  final fechaCtrl = new TextEditingController();
  final cvvCtrl = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final formCliente = Provider.of<FormsCliente>(context);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Form(
            //formulario unico
            key: formCliente.formkeyPagoTarjeta,
            child: Column(
              children: [
                CustomInput(
                  icon: Icons.credit_card,
                  placeHolder: 'metodoPago.tarjeta.numTarjeta.placeholder'.tr(),
                  textController: tarjetaCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16)
                  ],
                  validator: (value) {
                    if (value != null && value.length > 0) {
                      return null;
                    } else {
                      return 'metodoPago.tarjeta.numTarjeta.alerts.null'.tr();
                    }
                  },
                ),
                CustomSelectDate(
                  inputFieldDataController: fechaCtrl,
                  texto: 'metodoPago.tarjeta.fechaVence.placeholder'.tr(),
                ),
                CustomInput(
                  icon: Icons.lock,
                  placeHolder: 'metodoPago.tarjeta.codigoSeg.placeholder'.tr(),
                  textController: cvvCtrl,
                  keyboardType: TextInputType.number,
                  inputFormatter: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(3)
                  ],
                  validator: (value) {
                    if (value != null && value.length > 0) {
                      return null;
                    } else {
                      return 'metodoPago.tarjeta.codigoSeg.alerts.null'.tr();
                    }
                  },
                )
              ],
            ),
          ),
          CustomButton(
              text: 'buttonsGlobals.guardar'.tr(),
              onPressed: () {
                //cierra el teclado del telefono
                FocusManager.instance.primaryFocus?.unfocus();
                if (formCliente.isValidFormPagoTarjeta()) {}
              })
        ],
      ),
    );
  }
}
