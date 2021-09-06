import 'dart:convert';

import 'package:flutter_viaje_express_cliente/src/models/registroCliente.dart';
import 'package:flutter_viaje_express_cliente/src/services/viajeExpressApi_service.dart';
import 'package:http/http.dart' as http;

class SignUpService {
  ViajeExpressApi _viajeExpressApi = new ViajeExpressApi();

  // REGISTRO DEL USUARIO CLIENTE

  // si retornamos true entonces el cliente se registró con éxito
  Future<bool?> createUser(RegistroCliente registroCliente) async {
  

    final url = Uri.http(
      _viajeExpressApi.baseUrl,
      '/CuentaCliente/registro_cliente',
    );

    

    final resp = await http
        .post(url, body: registroClienteToJson(registroCliente), 
        headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print('mensaje: ' + decodedResp['mensaje']);
    return decodedResp['exito'];
  }
}
