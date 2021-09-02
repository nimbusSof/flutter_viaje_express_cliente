import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BtnUbicacion extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mapaBloc = BlocProvider.of<MapaBloc>(context);
    final miUbicacionBloc = BlocProvider.of<MiUbicacionBloc>(context);
    final ubicacionDefecto = LatLng(-0.16050138340851247, -78.47380863777701);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(
            Icons.my_location,
            color: Colors.black87,
          ),
          onPressed: () {
            final destino = miUbicacionBloc.state.ubicacion;
            print('btnUbicacion $destino');
            mapaBloc.moverCamara(destino ?? ubicacionDefecto);
          },
        ),
      ),
    );
  }
}
