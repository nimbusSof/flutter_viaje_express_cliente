import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/helpers/helpers.dart';
import 'package:flutter_viaje_express_cliente/src/models/search_result.dart';
import 'package:flutter_viaje_express_cliente/src/pages/search/search_destino.dart';
import 'package:flutter_viaje_express_cliente/src/services/viajeNuevo/traffic_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline_do/polyline_do.dart' as Poly;

import 'package:provider/provider.dart';

class CustomInputSearchDestino extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return BlocBuilder<MapaBloc, MapaState>(
      builder: (context, state) {
       return SafeArea(
          child: Container(
            //padding: EdgeInsets.symmetric(horizontal: 5),
            width: width,
            child: GestureDetector(
              onTap: () async {
                final proximidad =
                    context.read<MiUbicacionBloc>().state.ubicacion;
                final historial = context.read<BusquedaBloc>().state.historial;

                final resultado = await showSearch(
                    context: context,
                    delegate: SearchDestino(proximidad!, historial!));
                this.retornoBusqueda(context, resultado!);
              },
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                width: double.infinity,
                child: Text(state.nombreDestino?? 'Lugar de destino',
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
      },
    );
  }

  void retornoBusqueda(BuildContext context, SearchResult result) async {
    if (result.cancelo) return;

    if (result.manual!) {
      context.read<BusquedaBloc>().add(OnActivarMarcadorManual());
      return;
    }

    calculandoAlerta(context);

    // calcular la ruta en base al valor: Result

    final trafficService = TrafficService();
    final mapaBloc = context.read<MapaBloc>();
    final recogida = mapaBloc.state.ubicacionRecogida;
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final destino = result.position;

    //si hay un lugarRecogida definido previamente, entonces se crea la ruta tomando en
    //cuenta ese lugarRecogida, sino existe este lugarRecogida entonces se crea la ruta
    //en base a la ubicacionActual y el destino que se buscó

    final drivingResponse = await trafficService.getCoordsInicioYDestino(
        recogida != null ? recogida : inicio!, destino!);

    final reverseQueryResponseInicio = await trafficService
        .getCoordenadasInfo(recogida != null ? recogida : inicio!);

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
        rutaCoordenadas: rutaCoordenadas, 
        distancia: distancia, 
        duracion: duracion, 
        nombreDestino: nombreDestino!,
        nombreInicio: nombreInicio));

    mapaBloc.moverCamara(destino);
    Navigator.of(context).pop();

    //agregar al historial
    final busquedaBloc = context.read<BusquedaBloc>();
    busquedaBloc.add(OnAgregarHistorial(result));
  }
}
