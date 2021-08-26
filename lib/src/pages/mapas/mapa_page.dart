import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/mapa_widgets/btn_mi_ruta.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/mapa_widgets/btn_seguir_ubicacion.dart';
import 'package:flutter_viaje_express_cliente/src/widgets/mapa_widgets/btn_ubicacion.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaPage extends StatefulWidget {
  @override
  _MapaPageState createState() => _MapaPageState();
}

class _MapaPageState extends State<MapaPage> {
  @override
  void initState() {
    BlocProvider.of<MiUbicacionBloc>(context).iniciarSeguimiento();
    super.initState();
  }

  @override
  void dispose() {
    BlocProvider.of<MiUbicacionBloc>(context).cancelarSeguimiento();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MiUbicacionBloc, MiUbicacionState>(
          builder: (_, state) => crearMapa(state)),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [BtnUbicacion(), BtnSeguirUbicacion(), BtnMiRuta()],
      ),
    );
  }

  Widget crearMapa(MiUbicacionState state) {
    final ubicacionDefecto = LatLng(-0.16050138340851247, -78.47380863777701);
    if (!state.existeUbicacion) return Center(child: Text('Ubicando...'));
    final mapaBloc = BlocProvider.of<MapaBloc>(context);

    mapaBloc.add(OnNuevaUbicacion(state.ubicacion??ubicacionDefecto));

    final cameraPosition = new CameraPosition(
        target: state.ubicacion ??
            ubicacionDefecto, // se mostrara una ubicación por defecto si no se encuentra ninguna
        zoom: 15);

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      onMapCreated: mapaBloc.initMapa, // el primer argumento de onMapCreated se asignara al mapaBloc.initMap
      polylines: mapaBloc.state.polylines.values.toSet(),
    );
  }
}
