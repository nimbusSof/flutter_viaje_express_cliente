import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  //final String _baseUrl = 'identitytoolkit.googleapis.com';
  //final String _firebaseToken = 'AIzaSyD6c9oUsV7CChy_8JrIKj9L9JrAhPXecp4';
  final String _baseUrl = '10.0.2.2:59454';

  final storage = new FlutterSecureStorage();

  // si retornamos algo, es un error, sino todo bien!
  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(
      _baseUrl,
      '/v1/accounts:signUp', /* {'key': _firebaseToken} */
    );

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // El token se guarda en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }



  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'correo': email,
      'clave': password,
    };

    final url = Uri.http(
      _baseUrl,
      '/Login/Cliente', /*  {'key': _firebaseToken} */
    );


    final resp = await http.post(url,
        body: json.encode(authData),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json',});
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('token')) {
      // El token se guarda en un lugar seguro
      await storage.write(key: 'token', value: decodedResp['token']);
      return null;
    } else {
      return decodedResp['exito'];
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await storage.read(key: 'token') ?? '';
  }
}