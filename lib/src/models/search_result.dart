import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancelo;
  final bool? manual;
  final bool? lugarRecogida;
  final bool? lugardestino;
  final LatLng? position;
  final String? nombreLugar;
  final String? descripcion;

  SearchResult( 
      {required this.cancelo,
      this.lugarRecogida, 
      this.lugardestino, 
      this.manual, 
      this.position,
      this.nombreLugar, 
      this.descripcion});
}
