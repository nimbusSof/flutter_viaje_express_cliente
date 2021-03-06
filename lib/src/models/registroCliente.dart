// To parse this JSON data, do
//
//     final registroCliente = registroClienteFromJson(jsonString);

import 'dart:convert';

RegistroCliente registroClienteFromJson(String str) =>
    RegistroCliente.fromJson(json.decode(str));

String registroClienteToJson(RegistroCliente data) =>
    json.encode(data.toJson());



class RegistroCliente {
  String nombre;
  String apellido;
  DateTime? fechaNacimiento;
  String genero;
  String telefono;
  String correo;
  String clave;
  String pathFoto;
  String cedula;

  RegistroCliente({
    this.nombre = '',
    this.apellido = '',
    this.fechaNacimiento,
    this.genero = '',
    this.telefono = '',
    this.correo = '',
    this.clave = '',
    this.pathFoto = 'image/image',
    this.cedula = '',
  });

  RegistroCliente copyWith({
    String? nombre,
    String? apellido,
    DateTime? fechaNacimiento,
    String? genero,
    String? telefono,
    String? correo,
    String? clave,
    String? pathFoto,
    String? cedula,
  }) =>
      RegistroCliente(
        nombre: nombre ?? this.nombre,
        apellido: apellido ?? this.apellido,
        //fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
        genero: genero ?? this.genero,
        telefono: telefono ?? this.telefono,
        correo: correo ?? this.correo,
        clave: clave ?? this.clave,
        pathFoto: pathFoto ?? this.pathFoto,
        cedula: cedula ?? this.cedula,
      );

  factory RegistroCliente.fromJson(Map<String, dynamic> json) =>
      RegistroCliente(
        nombre: json["nombre"],
        apellido: json["apellido"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        genero: json["genero"],
        telefono: json["telefono"],
        correo: json["correo"],
        clave: json["clave"],
        pathFoto: json["path_foto"],
        cedula: json["cedula"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre,
        "apellido": apellido,
        "fecha_nacimiento": fechaNacimiento!.toIso8601String(),
        "genero": genero,
        "telefono": telefono,
        "correo": correo,
        "clave": clave,
        "path_foto": pathFoto,
        "cedula": cedula,
      };
}
