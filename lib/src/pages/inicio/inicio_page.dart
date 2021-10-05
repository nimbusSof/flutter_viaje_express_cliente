import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/services/configuraciones/idiomaUser_service.dart';
import 'package:flutter_viaje_express_cliente/src/services/services.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/sideBar_widgets/sideBar_widget.dart';

import 'package:flutter_viaje_express_cliente/src/widgets/global_widgets/cabecera_widgets/cabecera_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/inicio_widgets/contenedorMapa_widget.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/inicio_widgets/custom_buttom_inicio.dart';
import 'package:provider/provider.dart';

class InicioPage extends StatefulWidget {
  @override
  _InicioPageState createState() => _InicioPageState();
}

class _InicioPageState extends State<InicioPage> {
  GlobalKey<ScaffoldState> _scafoldKey = GlobalKey<ScaffoldState>();
  final prefs = new PreferenciasUsuario();

  @override
  Widget build(BuildContext context) {
    //inicializarIdioma();
    prefs.ultimaPagina = 'inicio';
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

  /* void inicializarIdioma() async {
    final idiomaUserService = new IdiomaUser();
    final authService = Provider.of<AuthService>(context, listen: false);
    String token = await authService.readToken();
    String idPersonarol = await authService.readIdPersonaRol();
    String idioma =
        await idiomaUserService.idiomaClienteService(idPersonarol, token);
    String idiomita = '';

    if (idioma == 'español') {
      await context.setLocale(Locale('es'));
    } else if (idioma == 'ingles') {
      await context.setLocale(Locale('en'));
    } else if (idioma == '') {
      String idiomaDispositivo =
          context.deviceLocale.toString().substring(0, 2);

      if (idiomaDispositivo == 'es' || idiomaDispositivo == 'en') {
        if (idiomaDispositivo == 'es') {
          idiomita = 'español';
        }
        if (idiomaDispositivo == 'en') {
          idiomita = 'ingles';
        }
        await context.setLocale(Locale(idiomaDispositivo));
        await idiomaUserService.idiomaClienteServicePost(
            idPersonarol, token, idiomita);
      } else {
        //se coloca idioma ingles por defecto en caso de que el dispositivo tenga otro idima
        context.setLocale(context.locale);
         await idiomaUserService.idiomaClienteServicePost(
            idPersonarol, token, 'ingles');
      }
    }
  }
 */
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
        Cabecera(titulo: 'inicio.titulo'.tr(), subtitulo: 'Viaje Express'),
        BtnViajar(texto: 'inicio.button.pregunta'.tr()),
        BtnRutasGuardadas(texto: 'inicio.button.seleccionar'.tr()),
        SizedBox(height: 25),
        ContenedorMapa()
      ],
    );
  }
}
