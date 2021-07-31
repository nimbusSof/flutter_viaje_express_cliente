import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;

  const CustomButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          elevation: 2,
          shape: StadiumBorder(),
          primary: yellowColor,
        ),
        onPressed: this.onPressed,
        child: Container(
          width: double.infinity,
          height: 55,
          child: Center(
            child: Text(
              this.text,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ));
  }
}

class BtnSimple extends StatelessWidget {
  final String texto;
  final String? ruta;

  const BtnSimple({required this.texto, this.ruta});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.003),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: MaterialButton(
        onPressed: () {},
        child: Container(
          padding: EdgeInsets.fromLTRB(0, size.height * 0.02, 0, size.height * 0.02),
            // aquí se define las longitudes del botón
            width: double.infinity,
            height: size.height * 0.07,
            child: RichText(

              text: TextSpan(
                text: this.texto,
                style: TextStyle(fontSize: 20, color: Colors.black)
              )
              
              )
            ),
      ),
    );
  }
}

class BtnSimpleIcon extends StatelessWidget {
  final String texto;
  final String? ruta;
  final IconData icono;
  final Color? color;

  const BtnSimpleIcon(
      {required this.texto, this.ruta, required this.icono, this.color});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: size.height * 0.03),
      margin: EdgeInsets.symmetric(horizontal: size.width * 0.01),
      child: MaterialButton(
        onPressed: () {},
        child: Container(
          // aquí se define las longitudes del botón
          width: double.infinity,
          height: size.height * 0.07,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                this.icono,
                color: this.color != null ? this.color : Colors.black,
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
