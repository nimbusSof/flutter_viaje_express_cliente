import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_viaje_express_cliente/src/providers/viajeNuevo/datosViajeNuevo_provider.dart';
import 'package:flutter_viaje_express_cliente/src/providers/global/formsCliente_provider.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/customButton_viajeNuevo_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/customInput_destino.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/customInput_recogida.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/radioButtons_viajeNuevo_widget.dart';
import 'package:provider/provider.dart';

import 'package:sliding_up_panel/sliding_up_panel.dart';

class EstructuraPage extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  const EstructuraPage(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: EdgeInsets.zero,
        controller: controller,
        children: <Widget>[
          SizedBox(height: 36),
          Estructura(controller: controller, panelController: panelController),
          SizedBox(
            height: 24,
          )
        ],
      );
}

class Estructura extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  Estructura(
      {Key? key, required this.controller, required this.panelController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formCliente = Provider.of<FormsCliente>(context);
    final datosViajeNuevo = Provider.of<DatosViajeNuevo>(context);

    return Container(
      child: Form(
        key: formCliente.formkeyViajeNuevo,
        child: Column(
          children: <Widget>[
            //CabeceraMapa(),
            buildDragHandle(),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  /* CustomInput(
                    icon: Icons.location_on,
                    placeHolder: 'Mi ubicación',
                    textController: datosViajeNuevo.ubicacionCtrl,
                    inputFormatter: [],
                    validator: (value) {
                      if (value != null && value.length > 0) {
                        return null;
                      } else {
                        return 'Porfavor ingresa tu ubicación de viaje';
                      }
                    },
                  ), */

                  CustomInputSearchRecogida(),
                  
                  SizedBox(height: 15,),

                    //aqui va el input
                  CustomInputSearchDestino(),
                  
                  BtnSelectRutas(texto: 'viajeNuevo.button.seleccionar'.tr()),
                  RbtnMetodoPago(),
                  CustomButton(
                      text: 'viajeNuevo.button.solicitar'.tr(),
                      onPressed: () {
                        //cierra el teclado del teléfono
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formCliente.isValidFormViajeNuevo()) {
                          datosViajeNuevo.removerDatos();
                        }
                      })
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  buildDragHandle() => GestureDetector(
        child: Center(
          child: Container(
            width: 30,
            height: 5,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
        onTap: togglePanel,
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();

  
}
