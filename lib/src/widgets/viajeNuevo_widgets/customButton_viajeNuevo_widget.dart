import 'package:flutter/material.dart';

class BtnSelectRutas extends StatelessWidget {
  final String texto;
  final IconData? icono;

  const BtnSelectRutas({required this.texto, this.icono});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 1),
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        // aquí se define las longitudes del botón
        width: double.infinity,
        height: 55,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
           
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                this.texto,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ),
            Container(
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  )),
            ),
          ],
        ),
      ),
    );
  }


}