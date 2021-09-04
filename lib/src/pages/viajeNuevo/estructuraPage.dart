import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/customButton_viajeNuevo_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/radioButtons_viajeNuevo_widget.dart';

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

  final ubicacionCtrl = new TextEditingController();
  final destinoCtrl = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          //CabeceraMapa(),
          buildDragHandle(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(
                  height: 15,
                ),
                CustomInput(
                    icon: Icons.location_on,
                    placeHolder: 'Mi ubicación',
                    textController: ubicacionCtrl,
                    inputFormatter: [],
                    validator: (value){},),
                CustomInput(
                    icon: Icons.location_on,
                    placeHolder: 'Mi destino',
                    textController: destinoCtrl,
                    inputFormatter: [],
                    validator: (value){},),
                BtnSelectRutas(texto: 'Seleccionar una ruta guardada'),
                RbtnMetodoPago(),
                CustomButton(text: 'Solicitar un auto', onPressed: () {})
              ],
            ),
          )
        ],
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