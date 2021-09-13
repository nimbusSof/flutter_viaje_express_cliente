import 'package:dio/dio.dart';
import 'package:flutter_viaje_express_cliente/src/models/traffic_response.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrafficService {
  //singleton
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final _dio = new Dio();
  final baseUrl = 'https://api.mapbox.com/directions/v5';
  final apiKey =
      'pk.eyJ1IjoidmlhamVleHByZXNzIiwiYSI6ImNrdGNoMmhqYzI1b3Ayb3BreXM2MThqa3kifQ.bLua-TbAxENPfkJI7sZPZA';

  Future<DrivingResponse> getCoordsInicioYDestino(LatLng inicio, LatLng destino) async {
    

    final coordString =
        '${inicio.longitude},${inicio.latitude};${destino.longitude},${destino.latitude}';
    final url = '${this.baseUrl}/mapbox/driving/$coordString';

    final resp = await this._dio.get(url, queryParameters: {
      'alternatives': 'true',
      'geometries': 'polyline6',
      'steps': 'false',
      'access_token': this.apiKey,
      'language': 'es',
    });
    //print(resp);

    final data = DrivingResponse.fromJson(resp.data);

    return data;
  }
}
