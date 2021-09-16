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

  Polyline _miRutaDestino = new Polyline(
      polylineId: PolylineId('mi_ruta_destino'),
      width: 4,
      color: Colors.black87);

  //SE INICIALIZA EL CONTROLADOR DEL MAPA (ESTE METODO PERMITE IMPLEMENTAR
  //METODOS DE ANIMACION DE CAMARA COMO SEGUIMIENTO DE UBICACION)
  void initMapa(GoogleMapController controller) {
    print('ESTAMOS EN INITMAPA: ${state.mapaListo}');
    if (!state.mapaListo) {
      this._mapController = controller;
      this
          ._mapController
          ?.setMapStyle(jsonEncode(uberMapTheme)); // cambia el estilo del mapa
      print('SE CARGO EL TEMA DEL MAPA');
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
      yield state.copyWith(mapaListo: true);
    } else if (event is OnNuevaUbicacion) {
      yield* this._onNuevaUbicacion(
          event); // yield* no regresa el stream completo , solo la emisión es decir, el yiel del método

    } else if (event is OnMarcarRecorrido) {
      yield* this._onMarcarRecorrido(event);
    } else if (event is OnSeguirUbicacion) {
      yield* this._onSeguirUbicacion(event);
    } else if (event is OnMovioMapa) {
      //print(event.centroMapa);
      yield state.copyWith(ubicacionCentral: event.centroMapa);
    } else if (event is OnMapaCerrado) {
      yield state.copyWith(mapaListo: false);
    } else if (event is OnCrearRutaInicioDestino) {
      yield* _onCrearRutaInicioDestino(event);
    } else if (event is OnCrearMarcadorInicio) {
      yield* _onCrearMarcadorInicio(event);
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

  Stream<MapaState> _onCrearRutaInicioDestino(
      OnCrearRutaInicioDestino event) async* {
    //coloca en la polyline la lista de latitudes y longitudes de la ruta inicioDestino
    this._miRutaDestino =
        this._miRutaDestino.copyWith(pointsParam: event.rutaCoordenadas);

    //coloca en la variable currentPolylines la polyline con la lista de latitudes y longitudes
    final currentPolylines = state.polylines;
    currentPolylines['mi_ruta_destino'] = this._miRutaDestino;

    //Marcadores
    //Marcador de la ubicacion de inicio
    final markerInicio = new Marker(
        markerId: MarkerId('inicio'),
        position: event.rutaCoordenadas[0], //ubicación actual del cliente
        infoWindow: InfoWindow(
            title: 'Mi Ubicación',
            snippet:
                'Duración de la ruta: ${(event.duracion / 60).floor()} minutos'));

    double kilometros = event.distancia / 1000;
    kilometros = (kilometros * 100).floorToDouble();
    kilometros = kilometros / 100;

    //Marcador de la ubicación destino
    final markerDestino = new Marker(
        markerId: MarkerId('destino'),
        position: event.rutaCoordenadas[
            event.rutaCoordenadas.length - 1], //destino del cliente
        infoWindow: InfoWindow(
            title: event.nombreDestino, snippet: 'Distancia: $kilometros Km'));

    //se actualizan los marcadores con la ruta establecida
    final newMarkers = {...state.markers};
    newMarkers['inicio'] = markerInicio;
    newMarkers['destino'] = markerDestino;

    Future.delayed(Duration(milliseconds: 300)).then((value) {
      //_mapController!.showMarkerInfoWindow(MarkerId('inicio'));
      _mapController!.showMarkerInfoWindow(MarkerId('destino'));
    });

    //almaceno las coordenadas del destino
    final ubicacionDestino =
        event.rutaCoordenadas[event.rutaCoordenadas.length - 1];
    //almaceno las coordenadas del lugar de recogida
    final ubicacionRecogida = event.rutaCoordenadas[0];

    //se guardan los polylines de la ruta establecida y los marcadores actualizados
    yield state.copyWith(
        polylines: currentPolylines,
        markers: newMarkers,
        ubicacionDestino: ubicacionDestino,
        ubicacionRecogida: ubicacionRecogida);
  }

  Stream<MapaState> _onCrearMarcadorInicio(OnCrearMarcadorInicio event) async* {
    //cuando no tenga definido el destino del viaje, entonces solo se mostrará el marcador de inicio
    final markerInicio = new Marker(
        markerId: MarkerId(
            'inicio'), //sobre escribe al marcador que tenga este markerId
        position: event.coordenadasMarker, //lugar de recogida del cliente
        infoWindow: InfoWindow(title: 'Lugar de Recogida'));

    final newMarkers = {...state.markers};
    newMarkers['inicio'] = markerInicio;

    print('hola marcador inicio ${event.coordenadasMarker}');

    final ubicacionRecogida = event.coordenadasMarker;

    //se guardan los polylines de la ruta establecida y los marcadores actualizados
    yield state.copyWith(
        markers: newMarkers, ubicacionRecogida: ubicacionRecogida);
  }
}
