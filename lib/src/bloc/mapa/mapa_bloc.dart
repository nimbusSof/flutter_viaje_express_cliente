import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart' show Colors;
import 'package:flutter_viaje_express_cliente/src/themes/uber_map_themes.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';

part 'mapa_event.dart';
part 'mapa_state.dart';

class MapaBloc extends Bloc<MapaEvent, MapaState> {
  MapaBloc() : super(new MapaState());

  //controlador del mapa
  GoogleMapController? _mapController;

  // Polyline
  Polyline _miRuta = new Polyline(
      polylineId: PolylineId('mi_ruta'), width: 4, color: Colors.transparent);

  void initMapa(GoogleMapController controller) {
    if (!state.mapaListo) {
      this._mapController = controller;
      this
          ._mapController
          ?.setMapStyle(jsonEncode(uberMapTheme)); // cambia el estilo del mapa

      add(OnMapaListo());
    }
  }

  void moverCamara(LatLng destino) {
    final cameraUpdate = CameraUpdate.newLatLng(destino);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapaState> mapEventToState(
    MapaEvent event,
  ) async* {
    if (event is OnMapaListo) {
      print('mapa listo');
      yield state.copyWith(mapaListo: true);
    } else if (event is OnNuevaUbicacion) {
      yield* this._onNuevaUbicacion(
          event); // yield* no regresa el stream completo , solo la emisión es decir, el yiel del método

    } else if (event is OnMarcarRecorrido) {
      yield* this._onMarcarRecorrido(event);
    } else if (event is OnSeguirUbicacion) {
      yield* this._onSeguirUbicacion(event);
    } else if (event is OnMovioMapa) {
      print(event.centroMapa);
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    }
  }

  Stream<MapaState> _onNuevaUbicacion(OnNuevaUbicacion event) async* {
    //async* función generadora

    if (state.seguirUbicacion) {
      this.moverCamara(event.ubicacion);
    }

    List<LatLng> points = [...this._miRuta.points, event.ubicacion];
    this._miRuta = this._miRuta.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;

    yield state.copyWith(polylines: currentPolylines);
  }

  Stream<MapaState> _onMarcarRecorrido(OnMarcarRecorrido event) async* {
    //async* función generadora
    if (!state.dibujarRecorrido) {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.black87);
    } else {
      this._miRuta = this._miRuta.copyWith(colorParam: Colors.transparent);
    }

    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta'] = this._miRuta;

    yield state.copyWith(
        dibujarRecorrido: !state.dibujarRecorrido, polylines: currentPolylines);
  }

  Stream<MapaState> _onSeguirUbicacion(OnSeguirUbicacion event) async* {
    if (!state.seguirUbicacion) {
      this.moverCamara(this._miRuta.points[this._miRuta.points.length - 1]);
    }
    yield state.copyWith(seguirUbicacion: !state.seguirUbicacion);
  }
}
