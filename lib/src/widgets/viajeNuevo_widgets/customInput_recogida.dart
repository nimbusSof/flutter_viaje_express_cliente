import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/helpers/helpers.dart';
import 'package:flutter_viaje_express_cliente/src/models/search_result.dart';

import 'package:flutter_viaje_express_cliente/src/pages/search/search_recogida.dart';
import 'package:flutter_viaje_express_cliente/src/services/viajeNuevo/traffic_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline_do/polyline_do.dart' as Poly;

import 'package:provider/provider.dart';

class CustomInputSearchRecogida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        //padding: EdgeInsets.symmetric(horizontal: 5),
        width: width,
        child: GestureDetector(
          onTap: () async {
            final proximidad = context.read<MiUbicacionBloc>().state.ubicacion;
            final historial = context.read<BusquedaBloc>().state.historial;

            final resultado = await showSearch(
                context: context,
                delegate: SearchRecogida(proximidad!, historial!));
            this.retornoBusqueda(context, resultado!);
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            width: double.infinity,
            child: Text('Lugar de recogida',
                style: TextStyle(color: Colors.black87)),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Colors.black12,
                      blurRadius: 5,
                      offset: Offset(0, 5))
                ]),
          ),
        ),
      ),
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result) async {
    //si se cancela la busqueda del lugar de recogida entonces retorna null
    if (result.cancelo) return;

    // si el marcador manual esta desactivado entonces activalo
    if (result.manual!) {
      context.read<BusquedaBloc>().add(OnActivarMarcadorManualRecogida());
      return;
    }

    calculandoAlerta(context);

    // calcular la ruta en base al valor: Result

    //final trafficService = TrafficService();
    final mapaBloc = context.read<MapaBloc>();

    final recogida = result.position;
    final destinoSeleccionado = mapaBloc.state.ubicacionDestino;

    if (destinoSeleccionado != null) {
      _crearRutaInicioDestino(context, recogida!, destinoSeleccionado, result);
    } else {
      final trafficService = new TrafficService();
      //obtener informacion del lugar de recogida  
    final reverseQueryResponseInicio =
        await trafficService.getCoordenadasInfo(recogida!); 

        final nombreInicio = reverseQueryResponseInicio.features![0].text; 

      mapaBloc.add(OnCrearMarcadorInicio(
          coordenadasMarker: recogida, nombreUbicacion: nombreInicio!));

      final busquedaBloc = context.read<BusquedaBloc>();
      
      //se mueve la posicion de la pantalla hacia el lugar de recogida
      mapaBloc.moverCamara(recogida);

      Navigator.of(context).pop();
      busquedaBloc.add(OnAgregarHistorial(result));
    }
  }

  void _crearRutaInicioDestino(BuildContext context, LatLng inicio,
      LatLng destino, SearchResult result) async {
    final trafficService = TrafficService();
    final mapaBloc = context.read<MapaBloc>();
    final drivingResponse =
        await trafficService.getCoordsInicioYDestino(inicio, destino);
   
      //obtener informacion del lugar de recogida  
    final reverseQueryResponseInicio =
        await trafficService.getCoordenadasInfo(inicio); 
        final nombreInicio = reverseQueryResponseInicio.features![0].text;     

    final geometry = drivingResponse.routes[0].geometry;
    final duracion = drivingResponse.routes[0].duration;
    final distancia = drivingResponse.routes[0].distance;
    final nombreDestino = result.nombreLugar;

    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6);
    final List<LatLng> rutaCoordenadas = points.decodedCoords
        .map((point) => LatLng(point[0], point[1]))
        .toList();

    mapaBloc.add(OnCrearRutaInicioDestino(
        rutaCoordenadas, distancia, duracion, nombreDestino!, nombreInicio: nombreInicio));

    Navigator.of(context).pop();

    //agregar al historial
    final busquedaBloc = context.read<BusquedaBloc>();
    busquedaBloc.add(OnAgregarHistorial(result));
  }
}
