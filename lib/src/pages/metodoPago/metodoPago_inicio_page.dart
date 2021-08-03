import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/cabecera_widgets/cabecera_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/sideBar_widgets/sideBar_widget.dart';



class MetodoPagoInicioPage extends StatefulWidget {
  @override
  _MetodoPagoInicioPageState createState() => _MetodoPagoInicioPageState();
}

class _MetodoPagoInicioPageState extends State<MetodoPagoInicioPage> {
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
        )))
    );
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
  

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Cabecera(
            titulo: 'Método de Pago', subtitulo: 'Viaje Express'),
        BtnSimpleIcon(texto: 'Tarjeta de crédito o débito', icono: Icons.credit_card, color: Colors.blue, ruta: 'pagoTarjeta',),
        BtnSimpleIcon(texto: 'Dinero en efectivo', icono: Icons.attach_money, color: Colors.green,),
      ],
    );
  }
}