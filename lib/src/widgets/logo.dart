import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final String titulo;

  const Logo({Key? key, required this.titulo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: 50),
        child: Column(
          children: <Widget>[
            Image(
              image: AssetImage('assets/img_login/taxi_logo3.png'),
              width: size.width * 0.5,
              fit: BoxFit.contain,
            ),
            SizedBox(height: 20),
            Text(
              'Viaje Express',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                this.titulo,
                style: TextStyle(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
