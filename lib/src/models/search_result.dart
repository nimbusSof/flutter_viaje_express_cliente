import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancelo;
  final bool? manual;
  final LatLng? position;
  final String? descripcion;

  SearchResult(
      {required this.cancelo, 
      this.manual, 
      this.position, 
      this.descripcion});
}
