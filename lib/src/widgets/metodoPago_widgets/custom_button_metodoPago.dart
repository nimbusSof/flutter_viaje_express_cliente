import 'package:flutter/material.dart';

class BtnMetodoPago extends StatelessWidget {
  final String texto;
  final String? ruta;
  final IconData icono;
  final Color ? color;

  const BtnMetodoPago({required this.texto, this.ruta, required this.icono, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      margin: EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: () {},
        child: Container(
          // aquí se define las longitudes del botón
          width: double.infinity,
          height: 55,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                this.icono,
                color: this.color!=null ? this.color: Colors.black ,
                size: 32,
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                this.texto,
                style: TextStyle(fontSize: 20, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
