import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:flutter_viaje_express_cliente/src/themes/colors.dart';

class CambiarFormatosPage extends StatelessWidget {
  final prefs = new PreferenciasUsuario();
  @override
  Widget build(BuildContext context) {
    prefs.ultimaPagina = 'cambiarFormatos';
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
            child: Icon(Icons.arrow_back, size: 30,color: grisOscuroColor,),
            onTap: () {
              Navigator.pushReplacementNamed(context, 'configuraciones_inicio');
            }),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        title: Text(
          'configuraciones.formatos.titulo'.tr(),
          style: TextStyle(
            fontSize: 20,
            color: Colors.black45,
          ),
        ),
      ),
      body: _EstructuraPage(),
    ));
  }
}

class _EstructuraPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        margin: EdgeInsets.only(bottom: 10, top: 10),
        child: Column(
          children: <Widget>[
            horas(),
            Divider(),
            unidadesDistancia(),
            Divider()
          ],
        ));
  }

  horas() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            'configuraciones.formatos.fhoras'.tr(),
            style: TextStyle(fontSize: 18),
          ),
          Switch(value: true, onChanged: (value) {})
        ],
      ),
    );
  }

  unidadesDistancia() {
    return Align(
      alignment: Alignment.centerLeft,
      child: MaterialButton(
        onPressed: () {},
        child: Container(
          width: double.infinity,
          child: RichText(
              textAlign: TextAlign.start,
              text: TextSpan(
                  text: 'configuraciones.formatos.fdistancia'.tr()+'\n',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                  children: [
                    TextSpan(
                      text: 'configuraciones.formatos.unimedida'.tr(),
                      style: TextStyle(color: Colors.green, fontSize: 18),
                    )
                  ])),
        ),
      ),
    );
  }
}
