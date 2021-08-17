
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_viaje_express_cliente/src/models/personaCliente.dart';
import 'package:flutter_viaje_express_cliente/src/services/viajeExpressApi_service.dart';

class ObtenerClienteService with ChangeNotifier {
  ViajeExpressApi _viajeExpressApi = new ViajeExpressApi();
  PersonaCliente _personaCliente = new PersonaCliente();

  set personaCliente(PersonaCliente personaCliente) {
    this._personaCliente = personaCliente;
    notifyListeners();
  }

  PersonaCliente get personaCliente => this._personaCliente;

  Future<PersonaCliente> _procesarRespuesta(Uri url, token) async {
    final resp = await http.get(url, headers: {'token': token});
    //final decodedData = json.decode(resp.body);

    this._personaCliente = personaClienteFromJson(resp.body);

    return personaCliente;
  }

  Future<PersonaCliente> datosCliente(String idpersonarol, String token) async {
    final url = Uri.http(_viajeExpressApi.baseUrl, 'PerfilUsuario/$idpersonarol');
    
    return await _procesarRespuesta(url, token);
  }
}
