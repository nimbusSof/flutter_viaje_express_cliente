import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/cabecera_widgets/cabecera_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/customComponents_widgets/custom_button.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/sideBar_widgets/sideBar_widget.dart';

class PerfilInicioPage extends StatefulWidget {
  @override
  _PerfilInicioPageState createState() => _PerfilInicioPageState();
}

class _PerfilInicioPageState extends State<PerfilInicioPage> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'perfil_inicio';
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
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Cabecera(titulo: 'perfilUsuario.inicio.titulo'.tr(), subtitulo: 'Viaje Express'),
        BtnSimpleIcon(
          texto: 'perfilUsuario.inicio.btnConfiguracion'.tr(),
          icono: Icons.person,
          color: grisOscuroColor,
          ruta: 'configuracionPerfil',
        ),
        BtnSimpleIcon(
          texto: 'perfilUsuario.inicio.btnCalificacion'.tr(),
          icono: Icons.star,
          color: grisOscuroColor,
          ruta: 'clasificaciónPerfil',
        )
      ],
    );
  }
}
