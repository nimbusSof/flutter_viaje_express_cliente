import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/pages/viajeNuevo/estructuraPage.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/sideBar_widgets/sideBar_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/customButton_viajeNuevo_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/radioButtons_viajeNuevo_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/viajeNuevo_inicio_widget.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ViajeNuevoInicioPage extends StatefulWidget {
  @override
  _ViajeNuevoInicioPageState createState() => _ViajeNuevoInicioPageState();
}

class _ViajeNuevoInicioPageState extends State<ViajeNuevoInicioPage> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  static const double fabHeightClosed = 116.0;
  double fabHeight = fabHeightClosed;
  final panelController = new PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.6;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.088;

    return Scaffold(
        key: _scafoldKey,
        drawer: SideBar(),
        body: SafeArea(
            child: Stack(
          children: [
             SlidingUpPanel(
            controller: panelController,
            maxHeight: panelHeightOpen,
            minHeight: panelHeightClosed,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: Container( // aqui va el mapa de google
              color: grisOscuroColor,
            ),
            panelBuilder: (controller) => EstructuraPage(controller: controller, panelController: panelController),
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            onPanelSlide: (position) => setState(() {
              final panelMaxScrollExtent = panelHeightOpen - panelHeightClosed;
              fabHeight = position * panelMaxScrollExtent + fabHeightClosed;
            }),
          ),
           
            Positioned(
              top: 10,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
              _buttonDrawer(),
                ],
              ),
            ),
          ],
        )));
  }

  Widget _buttonDrawer() {
    return Container(
      alignment: Alignment.centerLeft,
      child: IconButton(
        onPressed: () => _scafoldKey.currentState!.openDrawer(),
        icon: Icon(
          Icons.menu,
          size: 35,
          color: Colors.black,
        ),
      ),
    );
  }
}


