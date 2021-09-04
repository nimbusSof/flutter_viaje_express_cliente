import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_viaje_express_cliente/src/models/personaCliente.dart';
import 'package:flutter_viaje_express_cliente/src/services/viajeExpressApi_service.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  //final String _baseUrl = 'identitytoolkit.googleapis.com';
  //final String _firebaseToken = 'AIzaSyD6c9oUsV7CChy_8JrIKj9L9JrAhPXecp4';

  ViajeExpressApi _viajeExpressApi = new ViajeExpressApi();
  PersonaCliente _personaCliente = new PersonaCliente();
  final storage = new FlutterSecureStorage();
  final prefs = new PreferenciasUsuario();

  String nombres = '';

  //GETTER Y SETTERS DE PERSONA
  set personaCliente(PersonaCliente personaCliente) {
    this._personaCliente = personaCliente;
    notifyListeners();
  }

  PersonaCliente get personaCliente => this._personaCliente;

  //Procesar respuesta para obtener datos del cliente
  Future<PersonaCliente> _procesarRespuesta(Uri url, token) async {
    final resp = await http.get(url, headers: {'token': token});
    //final decodedData = json.decode(resp.body);
    this._personaCliente = personaClienteFromJson(resp.body);
    //se guarda los nombres y apellidos en el storage
    prefs.nombreUsuario = personaCliente.data?.nombre??'null';
    prefs.apellidoUsuario = personaCliente.data?.apellido??'null';
    prefs.correoUsuario = personaCliente.data?.correo??'null';
    return personaCliente;
  }

  //Se obtiene los datos del cliente
  Future<PersonaCliente> datosCliente(String idpersonarol, String token) async {
    final url =
        Uri.http(_viajeExpressApi.baseUrl, 'PerfilUsuario/$idpersonarol');

    return await _procesarRespuesta(url, token);
  }

  // LOGIN DEL USUARIO CLIENTE

  Future<bool?> login(String email, String password) async {
    // parametros para enviar al api
    final Map<String, dynamic> authData = {
      'correo': email,
      'clave': password,
    };

    // emsamble del endpoint
    final url = Uri.http(
      _viajeExpressApi.baseUrl,
      '/Login/Cliente', /*  {'key': _firebaseToken} */
    );

    //se realizar la petición post al  api
    final resp = await http.post(url, body: json.encode(authData), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    //se decodifica la respuesta del api
    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    print(decodedResp['token']);
    if (decodedResp['token']!=null) {
      // El token se guarda en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['token']);
      await storage.write(
          key: 'id_persona_rol',
          value: decodedResp['id_persona_rol'].toString());
      //se traen los datos del cliente
      await datosCliente(
          decodedResp['id_persona_rol'].toString(), decodedResp['token']);
      
    }
    return decodedResp['exito'];
  }

  Future logout() async {
    await storage.delete(key: 'token');
    await storage.delete(key: 'id_persona_rol');
    return;
  }

// LECTURA DE STORAGE
  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<String> readIdPersonaRol() async {
    return await storage.read(key: 'id_persona_rol') ?? '';
  }
}
