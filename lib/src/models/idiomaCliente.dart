// To parse this JSON data, do
//
//     final idiomaCliente = idiomaClienteFromJson(jsonString);

import 'dart:convert';

IdiomaCliente idiomaClienteFromJson(String str) => IdiomaCliente.fromJson(json.decode(str));

String idiomaClienteToJson(IdiomaCliente data) => json.encode(data.toJson());

class IdiomaCliente {
    IdiomaCliente({
        this.exito,
        this.codigo,
        this.mensaje,
        this.data,
    });

    bool? exito;
    int? codigo;
    String? mensaje;
    Data? data;

    factory IdiomaCliente.fromJson(Map<String, dynamic> json) => IdiomaCliente(
        exito: json["exito"],
        codigo: json["codigo"],
        mensaje: json["mensaje"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "exito": exito,
        "codigo": codigo,
        "mensaje": mensaje,
        "data": data!.toJson(),
    };
}

class Data {
    Data({
        this.idPersonaRol,
        this.idioma,
    });

    int? idPersonaRol;
    String? idioma;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        idPersonaRol: json["id_persona_rol"],
        idioma: json["idioma"],
    );

    Map<String, dynamic> toJson() => {
        "id_persona_rol": idPersonaRol,
        "idioma": idioma,
    };
}
