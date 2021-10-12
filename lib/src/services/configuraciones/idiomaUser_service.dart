import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_viaje_express_cliente/src/models/idiomaCliente.dart';
import 'package:flutter_viaje_express_cliente/src/services/global/viajeExpressApi_service.dart';
import 'package:http/http.dart' as http;

class IdiomaUser extends ChangeNotifier {
  ViajeExpressApi _viajeExpressApi = new ViajeExpressApi();
  IdiomaCliente _idiomaCliente = new IdiomaCliente();

  IdiomaCliente get idiomaCliente => this._idiomaCliente;
  set idiomaCliente(IdiomaCliente idiomaCliente) {
    this._idiomaCliente = idiomaCliente;
    notifyListeners();
  }

  //Procesar respuesta para obtener datos del cliente
  Future<String> _procesarRespuesta(Uri url, token) async {
    String? idioma = '';
    final resp = await http.get(url, headers: {
      'token': token, 
      'Content-Type': 'application/json',
      'Accept': 'application/json',});
    
    idiomaCliente = idiomaClienteFromJson(resp.body);

    if (idiomaCliente.exito == true) {
      idioma = idiomaCliente.data!.idioma;
    }

    return idioma!=null ?idioma:'';
  }


  //Se arma la url para procesar servicio obtener idioma cliente
  Future<String> idiomaClienteService(String idpersonarol, String token) async {
    final url =
        Uri.http(_viajeExpressApi.baseUrl, 'Preferencias/obtener', {
          'id_persona_rol': idpersonarol
        });

    return await _procesarRespuesta(url, token);
  }



//Procesar respuesta para obtener datos del cliente
  Future<void> _procesarRespuestaPut(Uri url, String token, String idpersonarol, String idioma) async {
  
    final Map<String, dynamic> idiomaData = {
      'id_persona_rol': idpersonarol,
      'idioma': idioma
    };

    await http.put(url, 
    body: json.encode(idiomaData),
    headers: {
      'token': token, 
      'Content-Type': 'application/json',
      'Accept': 'application/json',});

  }


  //Se arma la url para procesar servicio actualizar idioma cliente
  Future<void> idiomaClienteServicePut(String idpersonarol, String token, String idioma) async {
    final url =
        Uri.http(_viajeExpressApi.baseUrl, 'Preferencias/actualizar');
    await _procesarRespuestaPut(url, token, idpersonarol, idioma);
  }



  //Procesar respuesta para obtener datos del cliente
  Future<void> _procesarRespuestaPost(Uri url, String token, String idpersonarol, String idioma) async {
  
    final Map<String, dynamic> idiomaData = {
      'id_persona_rol': idpersonarol,
      'idioma': idioma
    };

    await http.put(url, 
    body: json.encode(idiomaData),
    headers: {
      'token': token, 
      'Content-Type': 'application/json',
      'Accept': 'application/json',});

  }



  //Se arma la url para procesar servicio insertar idioma cliente
  Future<void> idiomaClienteServicePost(String idpersonarol, String token, String idioma) async {
    final url =
        Uri.http(_viajeExpressApi.baseUrl, 'Preferencias/insertar');
    await _procesarRespuestaPost(url, token, idpersonarol, idioma);
  }



}
