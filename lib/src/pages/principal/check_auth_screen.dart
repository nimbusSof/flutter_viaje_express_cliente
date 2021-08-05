import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/pages/inicio/inicio_page.dart';
import 'package:flutter_viaje_express_cliente/src/pages/principal/login_page.dart';
import 'package:flutter_viaje_express_cliente/src/services/auth_service.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Text('Espere');
            }
            if (snapshot.data=='') {
              Future.microtask(() {
              Navigator.pushReplacement(
                  context, PageRouteBuilder(
                    pageBuilder: (_,__,___)=>LoginPage(),
                    transitionDuration: Duration(seconds: 0)));
            });
            }else{
              Future.microtask(() {
              //Navigator.of(context).pushReplacementNamed('inicio');
              Navigator.pushReplacement(
                  context, PageRouteBuilder(
                    pageBuilder: (_,__,___)=>InicioPage(),
                    transitionDuration: Duration(seconds: 0)));
            });
            }


            
            return Container();
          },
        ),
      ),
    );
  }
}
