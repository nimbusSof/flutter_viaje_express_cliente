part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;

  final LatLng? ubicacionCentral;
  final LatLng? ubicacionRecogida;
  final LatLng? ubicacionDestino;

  final String? nombrePuntoInicial; 
  final String? nombreInicio;
  final String? nombreDestino;

  //Polylines
  final Map<String, Polyline> polylines;
  final Map<String, Marker> markers;

  MapaState(
      {this.mapaListo = false,
      this.dibujarRecorrido = false,
      this.seguirUbicacion = false,
      this.ubicacionCentral,
      this.ubicacionRecogida,
      this.ubicacionDestino,
      this.nombrePuntoInicial='',
      this.nombreInicio='',
      this.nombreDestino,
      Map<String, Polyline>? polylines,
      Map<String, Marker>? markers})
      : this.polylines = polylines ?? new Map(),
        this.markers = markers ?? new Map();

  MapaState copyWith(
          {bool? mapaListo,
          bool? dibujarRecorrido,
          bool? seguirUbicacion,
          final LatLng? ubicacionCentral,
          LatLng? ubicacionRecogida,
          LatLng? ubicacionDestino,
          String? nombrePuntoInicial,
          String? nombreInicio,
          String? nombreDestino,
          Map<String, Polyline>? polylines,
          Map<String, Marker>? markers}) =>
      new MapaState(
          mapaListo: mapaListo ?? this.mapaListo,
          polylines: polylines ?? this.polylines,
          markers: markers ?? this.markers,
          ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
          ubicacionRecogida: ubicacionRecogida ?? this.ubicacionRecogida,
          ubicacionDestino: ubicacionDestino ?? this.ubicacionDestino,
          nombrePuntoInicial: nombrePuntoInicial ?? this.nombrePuntoInicial,
          nombreDestino: nombreDestino ?? this.nombreDestino,
          nombreInicio: nombreInicio ?? this.nombreInicio,
          seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
          dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido);
}
