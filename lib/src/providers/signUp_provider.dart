import 'dart:convert';

import 'package:flutter_viaje_express_cliente/src/models/registroCliente.dart';
import 'package:flutter_viaje_express_cliente/src/services/viajeExpressApi_service.dart';
import 'package:http/http.dart' as http;

class SignUpProvider {
  ViajeExpressApi _viajeExpressApi = new ViajeExpressApi();

  // REGISTRO DEL USUARIO CLIENTE

  // si retornamos true entonces el cliente se registró con éxito
  Future<bool?> createUser(RegistroCliente registroCliente) async {
    final Map<String, dynamic> registro = {
      "nombre": registroCliente.nombre,
      "apellido": registroCliente.nombre,
      "fecha_nacimiento": registroCliente.fechaNacimiento!.toIso8601String(),
      "genero": registroCliente.genero,
      "telefono": registroCliente.telefono,
      "correo": registroCliente.correo,
      "clave": registroCliente.clave,
      "path_foto": registroCliente.pathFoto,
      "cedula": registroCliente.cedula
    };

    final url = Uri.http(
      _viajeExpressApi.baseUrl,
      '/CuentaCliente/registro_cliente',
    );

    /* final resp = await http.post(url, body: json.encode(registro), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    }); */

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
