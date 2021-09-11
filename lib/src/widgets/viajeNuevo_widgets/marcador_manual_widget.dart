import 'package:flutter/material.dart';

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        //Boton regresar
        Positioned(
            top: 70,
            left: 20,
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black87,
                  )),
            )),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: Icon(
              Icons.location_on,
              size: 50,
            ),
          ),
        ),

        //boton confirmar destino
        Positioned(
            bottom: 70,
            left: 40,
            child: MaterialButton(
              minWidth: width-120,
              child: Text('Confirmar destino', style: TextStyle(color: Colors.white),),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {},
            ))
      ],
    );
  }
}
