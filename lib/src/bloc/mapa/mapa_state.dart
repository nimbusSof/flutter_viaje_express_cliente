part of 'mapa_bloc.dart';

@immutable
class MapaState {
  final bool mapaListo;
  final bool dibujarRecorrido;
  final bool seguirUbicacion;

  final LatLng? ubicacionCentral;
  final LatLng? ubicacionRecogida;
  final LatLng? ubicacionDestino;
  

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
      Map<String, Polyline>? polylines,
      Map<String, Marker>? markers})
      : this.polylines = polylines ?? new Map(),
      this.markers = markers?? new Map();

  MapaState copyWith(
          {bool? mapaListo,
          bool? dibujarRecorrido,
          bool? seguirUbicacion,
          final LatLng? ubicacionCentral,
          LatLng? ubicacionRecogida,
          LatLng? ubicacionDestino,
          Map<String, Polyline>? polylines,
          Map<String, Marker>? markers}) =>
      new MapaState(
          mapaListo: mapaListo ?? this.mapaListo,
          polylines: polylines ?? this.polylines,
          markers: markers ?? this.markers,
          ubicacionCentral: ubicacionCentral ?? this.ubicacionCentral,
          ubicacionRecogida: ubicacionRecogida ?? this.ubicacionRecogida,
          ubicacionDestino: ubicacionDestino ?? this.ubicacionDestino,
          seguirUbicacion: seguirUbicacion ?? this.seguirUbicacion,
          dibujarRecorrido: dibujarRecorrido ?? this.dibujarRecorrido);
}
