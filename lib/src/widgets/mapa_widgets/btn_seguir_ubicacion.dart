import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class BtnSeguirUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) => this._crearBoton(context, state)
    );
  }

  Widget _crearBoton(BuildContext context,MapaState state){
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            state.seguirUbicacion
             ? Icons.directions_run
             : Icons.accessibility_new,
            color: Colors.black87,
          ),
          onPressed: () {
            mapaBloc.add(OnSeguirUbicacion());
          },
        ),
      ),
    );
  }
}
