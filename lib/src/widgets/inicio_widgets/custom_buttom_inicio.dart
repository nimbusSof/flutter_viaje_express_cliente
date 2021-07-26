import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class BtnViajar extends StatelessWidget {
  final String texto;
  final IconData? icono;

  const BtnViajar({required this.texto, this.icono});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 50),
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            // aquí se le da estilo al botón
            elevation: 2,
            shape: StadiumBorder(),
            primary: grisColor,
          ),
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
          )),
    );
  }


}

class BtnRutasGuardadas extends StatelessWidget {
  final String texto;

  const BtnRutasGuardadas({required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            // aquí se le da estilo al botón
            elevation: 2,
            shape: StadiumBorder(),
            primary: grisColor,
          ),
          child: Container(
            // aquí se define las longitudes del botón
            width: double.infinity,
            height: 55,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.star,
                  color: Colors.black,
                ),
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
          )),
    );
  }
}
