import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_viaje_express_cliente/src/models/updateCliente.dart';
import 'package:flutter_viaje_express_cliente/src/share_prefs/preferencias_usuario.dart';
import 'package:http/http.dart' as http;
import '../global/viajeExpressApi_service.dart';

class UpdateClienteService extends ChangeNotifier {
  late UpdateCliente _updateCliente;
  ViajeExpressApi _viajeExpressApi = new ViajeExpressApi();
  late PreferenciasUsuario prefs;

/*Se inicializa el constructor de la clase trayendo los datos de preferencia de usuario y*/
/*añadiendolos al objeto UpdateCliente */

  UpdateClienteService() {
    prefs = new PreferenciasUsuario();
    _updateCliente = new UpdateCliente(
        nombre: prefs.nombreUsuario,
        apellido: prefs.apellidoUsuario,
        fechaNacimiento: DateTime.parse(prefs.fechaNacimiento),
        genero: prefs.genero,
        telefono: prefs.telefono,
        correo: prefs.correoUsuario,
        clave: prefs.clave,
        pathFoto: prefs.pathFoto,
        modifiedBy: 0);
  }

/*GETTERS Y SETTERS DE UPDATE CLIENTE*/

  UpdateCliente get updateCliente => this._updateCliente;

  set updateCliente(UpdateCliente cliente) {
    this._updateCliente = cliente;
  }

  set updateNombre(String nombre) {
    this._updateCliente.nombre = nombre;
    notifyListeners();
  }

  set updateApellido(String apellido) {
    this._updateCliente.apellido = apellido;
    notifyListeners();
  }

  set updateFechaNacimiento(String fechaNacimiento) {
    this._updateCliente.fechaNacimiento = DateTime.parse(fechaNacimiento);
    notifyListeners();
  }

  set updatecorreo(String correo) {
    this._updateCliente.correo = correo;
    notifyListeners();
  }

  set updateClave(String clave) {
    this._updateCliente.clave = clave;
    notifyListeners();
  }

  set updateModifiedBy(String id) {
    this._updateCliente.modifiedBy = int.parse(id);
    notifyListeners();
  }

  set updateTelefono(String telefono) {
    this._updateCliente.telefono = telefono;
    notifyListeners();
  }

// FUNCION: Se procesa la actualización del cliente con una petición tipo PUT
  Future<bool?> _procesarActualizacion(Uri url, token) async {
    final resp = await http
        .put(url, body: updateClienteToJson(this._updateCliente), headers: {
      'token': token,
      'Content-Type': 'application/json',
    });

    final Map<String, dynamic> decodedResp = json.decode(resp.body);
    //print('viendo ${resp.body}');

    if (decodedResp['exito'] == true) {
      prefs.nombreUsuario = this._updateCliente.nombre!;
      prefs.apellidoUsuario = this._updateCliente.apellido!;
      prefs.fechaNacimiento =
          this._updateCliente.fechaNacimiento!.toIso8601String();
      prefs.correoUsuario = this._updateCliente.correo!;
      prefs.clave = this._updateCliente.clave!;
      prefs.telefono = this._updateCliente.telefono!;
    }
    return decodedResp['exito'];
  }

  //FUNCION: Se arma la url y se procesa la actualización de datos del cliente
  Future<bool?> updateClienteService(String idpersonarol, String token) async {
    print('token: ' + token);
    print('id_persona: ' + idpersonarol);

    final url =
        Uri.http(_viajeExpressApi.baseUrl, 'PerfilUsuario/$idpersonarol');

    return await _procesarActualizacion(url, token);
  }
}
