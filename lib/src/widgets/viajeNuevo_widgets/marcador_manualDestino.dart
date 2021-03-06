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

class MarcadorManual extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BusquedaBloc, BusquedaState>(
      builder: (context, state) {
        if (state.seleccionManual) {
          return _BuildMarcadorManual();
        } else {
          return Container();
        }
      },
    );
  }
}

class _BuildMarcadorManual extends StatelessWidget {
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
                          .add(OnDesactivarMarcadorManual());
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
                'Confirmar destino',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.black,
              shape: StadiumBorder(),
              elevation: 0,
              splashColor: Colors.transparent,
              onPressed: () {
                this.calcularDestino(context);
              },
            ))
      ],
    );
  }

  void calcularDestino(BuildContext context) async {
    calculandoAlerta(context);

    final trafficService = new TrafficService();
    final mapaBloc = context.read<MapaBloc>();
    
 
    final inicio = context.read<MiUbicacionBloc>().state.ubicacion;
    final recogida = mapaBloc.state.ubicacionRecogida;
    final destino = mapaBloc.state.ubicacionCentral;

    //obtener informacion del destino
    final reverseQueryResponse =
        await trafficService.getCoordenadasInfo(destino!);
    
      //obtener informacion del lugar de recogida  
    final reverseQueryResponseInicio =
        await trafficService.getCoordenadasInfo(recogida!=null?recogida:inicio!); 
        final nombreInicio = reverseQueryResponseInicio.features![0].text;     

    final trafficResponse = await trafficService.getCoordsInicioYDestino(
        recogida!=null?recogida:inicio!, destino); //destino tiene null por defecto

    final geometry = trafficResponse.routes[0].geometry;
    final duracion = trafficResponse.routes[0].duration;
    final distancia = trafficResponse.routes[0].distance;
    final nombreDestino = reverseQueryResponse.features![0].text;

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
    context.read<BusquedaBloc>().add(OnDesactivarMarcadorManual());
  }
}
