import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/utils/colors.dart';

class Comentarios extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 3,
      itemBuilder: (context, int index)=>ComentarioTile());
  }
}


class ComentarioTile extends StatelessWidget {
  const ComentarioTile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text('UC'),
        backgroundColor: grisOscuroColor,
      ),
      title: Container(child: Text('Comentario del chofer')),
    );
  }
}
