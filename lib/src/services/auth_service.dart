import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_viaje_express_cliente/src/services/viajeExpressApi_service.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  //final String _baseUrl = 'identitytoolkit.googleapis.com';
  //final String _firebaseToken = 'AIzaSyD6c9oUsV7CChy_8JrIKj9L9JrAhPXecp4';

  ViajeExpressApi viajeExpressApi = new ViajeExpressApi();
  final storage = new FlutterSecureStorage();

 
  // LOGIN DEL USUARIO CLIENTE

  Future<bool?> login(String email, String password) async {
    // parametros para enviar al api
    final Map<String, dynamic> authData = {
      'correo': email,
      'clave': password,
    };

    // emsamble del endpoint
    final url = Uri.http(
      viajeExpressApi.baseUrl,
      '/Login/Cliente', /*  {'key': _firebaseToken} */
    );

    //se realizar la petición post al  api
    final resp = await http.post(url, body: json.encode(authData), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    //se decodifica la respuesta del api
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp);
    if (decodedResp.containsKey('token')) {
      // El token se guarda en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['token']);
      await storage.write(key: 'id_persona_rol', value: decodedResp['id_persona_rol'].toString());
      return decodedResp['exito'];
    }
  }



  Future logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'id_persona_rol');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
  Future<String> readIdPersonaRol() async {
    return await storage.read(key: 'id_persona_rol') ?? '';
  }
}
