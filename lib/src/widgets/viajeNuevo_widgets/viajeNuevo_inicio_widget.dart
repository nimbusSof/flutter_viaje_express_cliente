import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';


class CabeceraMapa extends StatelessWidget {
  



  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.symmetric(vertical: size.height*0.22),
          decoration: BoxDecoration(color: grisOscuroColor),
        ),
      ],
    );
  }
}