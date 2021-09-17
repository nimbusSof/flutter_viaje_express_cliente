part of 'mapa_bloc.dart';

@immutable
abstract class MapaEvent {}

class OnMapaListo extends MapaEvent {}

class OnMapaCerrado extends MapaEvent {}

class OnMarcarRecorrido extends MapaEvent {}

class OnSeguirUbicacion extends MapaEvent {}

class OnCrearRutaInicioDestino extends MapaEvent {
  final List<LatLng> rutaCoordenadas;
  final double distancia;
  final double duracion;
  final String? nombreDestino;
  final String? nombreInicio;

  OnCrearRutaInicioDestino(
      {required this.rutaCoordenadas, required this.distancia, required this.duracion, this.nombreDestino,
      this.nombreInicio});
}

class OnCrearMarcadorInicio extends MapaEvent {
  final List<LatLng>? rutaCoordenadas;
  final LatLng coordenadasMarker;
  final String nombreUbicacion;
  OnCrearMarcadorInicio(
      {required this.coordenadasMarker,
      required this.nombreUbicacion,
      this.rutaCoordenadas});
}

class OnCrearUbicacionInicial extends MapaEvent {
  final String? ubicacionInicial;
  final LatLng? coordenadas;
  OnCrearUbicacionInicial({this.ubicacionInicial, this.coordenadas});
}

class OnMovioMapa extends MapaEvent {
  final LatLng centroMapa;
  OnMovioMapa(this.centroMapa);
}

class OnNuevaUbicacion extends MapaEvent {
  final LatLng ubicacion;
  OnNuevaUbicacion(this.ubicacion);
}
