// To parse this JSON data, do
//
//     final registroCliente = registroClienteFromJson(jsonString);

import 'dart:convert';

PersonaCliente personaClienteFromJson(String str) => PersonaCliente.fromJson(json.decode(str));

String personaClienteToJson(PersonaCliente data) => json.encode(data.toJson());

class PersonaCliente {
    PersonaCliente({
        this.exito,
        this.codigo,
        this.mensaje,
        this.data,
    });

    final bool? exito;
    final int? codigo;
    final String? mensaje;
    final Data? data;

    PersonaCliente copyWith({
        bool? exito,
        int? codigo,
        String? mensaje,
        Data? data,
    }) => 
        PersonaCliente(
            exito: exito ?? this.exito,
            codigo: codigo ?? this.codigo,
            mensaje: mensaje ?? this.mensaje,
            data: data ?? this.data,
        );

    factory PersonaCliente.fromJson(Map<String, dynamic> json) => PersonaCliente(
        exito: json["exito"],
        codigo: json["codigo"],
        mensaje: json["mensaje"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "exito": exito,
        "codigo": codigo,
        "mensaje": mensaje,
        "data": data?.toJson(),
    };
}

class Data {
    Data({
        this.cedula,
        this.rol,
        this.calificacion,
        this.nombre,
        this.apellido,
        this.fechaNacimiento,
        this.genero,
        this.telefono,
        this.correo,
        this.clave,
        this.pathFoto,
    });

    final String? cedula;
    final String? rol;
    final int? calificacion;
    final String? nombre;
    final String? apellido;
    final String? fechaNacimiento;
    final String? genero;
    final String? telefono;
    final String? correo;
    final String? clave;
    final String? pathFoto;

    Data copyWith({
        String? cedula,
        String? rol,
        int? calificacion,
        String? nombre,
        String? apellido,
        String? fechaNacimiento,
        String? genero,
        String? telefono,
        String? correo,
        String? clave,
        String? pathFoto,
    }) => 
        Data(
            cedula: cedula ?? this.cedula,
            rol: rol ?? this.rol,
            calificacion: calificacion ?? this.calificacion,
            nombre: nombre ?? this.nombre,
            apellido: apellido ?? this.apellido,
            fechaNacimiento: fechaNacimiento ?? this.fechaNacimiento,
            genero: genero ?? this.genero,
            telefono: telefono ?? this.telefono,
            correo: correo ?? this.correo,
            clave: clave ?? this.clave,
            pathFoto: pathFoto ?? this.pathFoto,
        );

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        cedula: json["cedula"],
        rol: json["rol"],
        calificacion: json["calificacion"],
        nombre: json["nombre"],
        apellido: json["apellido"],
        fechaNacimiento: json["fecha_nacimiento"],
        genero: json["genero"],
        telefono: json["telefono"],
        correo: json["correo"],
        clave: json["clave"],
        pathFoto: json["path_foto"],
    );

    Map<String, dynamic> toJson() => {
        "cedula": cedula,
        "rol": rol,
        "calificacion": calificacion,
        "nombre": nombre,
        "apellido": apellido,
        "fecha_nacimiento": fechaNacimiento,
        "genero": genero,
        "telefono": telefono,
        "correo": correo,
        "clave": clave,
        "path_foto": pathFoto,
    };
}
