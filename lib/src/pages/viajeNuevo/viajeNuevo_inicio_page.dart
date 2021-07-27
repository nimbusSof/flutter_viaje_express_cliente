import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_input.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/sideBar_widgets/sideBar_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/customButton_viajeNuevo_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/radioButtons_viajeNuevo_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/viajeNuevo_widgets/viajeNuevo_inicio_widget.dart';

class ViajeNuevoInicioPage extends StatefulWidget {
  @override
  _ViajeNuevoInicioPageState createState() => _ViajeNuevoInicioPageState();
}

class _ViajeNuevoInicioPageState extends State<ViajeNuevoInicioPage> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scafoldKey,
        drawer: SideBar(),
        body: SafeArea(
            child: SingleChildScrollView(
                child: Stack(
          children: [
            _EstructuraPage(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buttonDrawer(),
              ],
            ),
          ],
        ))));
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

class _EstructuraPage extends StatelessWidget {
  final ubicacionCtrl = new TextEditingController ();
  final destinoCtrl = new TextEditingController ();


  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CabeceraMapa(),
        SizedBox(height: 15,),
        CustomInput(
            icon: Icons.location_on,
            placeHolder: 'Mi ubicación',
            textController: ubicacionCtrl),
        CustomInput(
            icon: Icons.location_on,
            placeHolder: 'Mi destino',
            textController: destinoCtrl),
        BtnSelectRutas(texto: 'Seleccionar una ruta guardada'),
        RbtnMetodoPago(),
        CustomButton(text: 'Solicitar un auto', onPressed: (){})    

      ],
    );
  }
}
