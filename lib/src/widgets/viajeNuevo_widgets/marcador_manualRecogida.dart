import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/busqueda/busqueda_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mapa/mapa_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/bloc/mi_ubicacion/mi_ubicacion_bloc.dart';
import 'package:flutter_viaje_express_cliente/src/helpers/helpers.dart';

import 'package:flutter_viaje_express_cliente/src/services/viajeNuevo/traffic_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:polyline_do/polyline_do.dart' as Poly;

import 'package:provider/provider.dart';

class MarcadorManualRecogida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManualRecogida) {
          return _BuildMarcadorRecogida();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorRecogida extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        //Boton regresar
        Positioned(
            top: 30,
            left: 20,
            child: FadeInLeft(
              duration: Duration(milliseconds: 160),
              child: CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                    onPressed: () {
                      context
                          .read<BusquedaBloc>()
                          .add(OnDesactivarMarcadorManualRecogida());
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.black87,
                    )),
              ),
            )),

        Center(
          child: Transform.translate(
            offset: Offset(0, -12),
            child: BounceInDown(
              from: 100,
              child: Icon(
                Icons.location_on,
                size: 50,
              ),
            ),
          ),
        ),

        //boton confirmar destino
        Positioned(
            bottom: 30,
            left: 50,
            child: MaterialButton(
              minWidth: width - 120,
              child: Text(
                'Hecho',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                this._colocarMarcadorRecogida(context);
              },
            ))
      ],
    );
  }

  void _colocarMarcadorRecogida(BuildContext context) async {
    final mapaBloc = context.read<MapaBloc>();
    final recogida = mapaBloc.state.ubicacionCentral;
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion!;
    final destino = mapaBloc.state.ubicacionDestino;

    if (destino != null) {
      _calcularDestino(context, recogida!=null?recogida:inicio, destino);

    } else {
      final trafficService = new TrafficService();
      //obtener informacion del lugar de recogida  
    final reverseQueryResponseInicio =
        await trafficService.getCoordenadasInfo(recogida!); 
        final nombreInicio = reverseQueryResponseInicio.features![0].text; 
      mapaBloc.add(OnCrearMarcadorInicio(
        coordenadasMarker: recogida, 
        nombreUbicacion: nombreInicio!));
      context.read<BusquedaBloc>().add(OnDesactivarMarcadorManualRecogida());
    }
  }

  void _calcularDestino(
      BuildContext context, LatLng inicio, LatLng destino) async {
    calculandoAlerta(context);

    final trafficService = new TrafficService();
    final mapaBloc = context.read<MapaBloc>();


    //obtener informacion del destino
    final reverseQueryResponseDestino =
        await trafficService.getCoordenadasInfo(destino);

    //obtener informacion del lugar de recogida  
    final reverseQueryResponseInicio =
        await trafficService.getCoordenadasInfo(inicio);  

   
    final trafficResponse = await trafficService.getCoordsInicioYDestino(
        inicio, destino); 

    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;
    final nombreDestino = reverseQueryResponseDestino.features![0].text;
    final nombreInicio = reverseQueryResponseInicio.features![0].text;

    //Decodificar los puntos geometry
    final points = Poly.Polyline.Decode(encodedString: geometry, precision: 6)
        .decodedCoords;
    final List<LatLng> rutaCoordenadas =
        points.map((point) => LatLng(point[0], point[1])).toList();

    mapaBloc.add(OnCrearRutaInicioDestino(
        rutaCoordenadas: rutaCoordenadas, 
        distancia: distancia, 
        duracion: duracion, 
        nombreDestino: nombreDestino!, 
        nombreInicio: nombreInicio));

    Navigator.of(context).pop();
    context.read<BusquedaBloc>().add(OnDesactivarMarcadorManualRecogida());
  }
}
