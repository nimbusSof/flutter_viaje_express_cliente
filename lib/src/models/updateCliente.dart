// To parse this JSON data, do
//
//     final updateCliente = updateClienteFromJson(jsonString);

import 'dart:convert';

UpdateCliente updateClienteFromJson(String str) => UpdateCliente.fromJson(json.decode(str));

String updateClienteToJson(UpdateCliente data) => json.encode(data.toJson());

class UpdateCliente {
    UpdateCliente({
       this.nombre,
       this.apellido,
       this.fechaNacimiento,
       this.genero,
       this.telefono,
       this.correo,
       this.clave,
       this.pathFoto,
       this.modifiedBy,
    });

    String? nombre;
    String? apellido;
    DateTime? fechaNacimiento;
    String? genero;
    String? telefono;
    String? correo;
    String? clave;
    String? pathFoto;
    int? modifiedBy;

   

    factory UpdateCliente.fromJson(Map<String, dynamic> json) => UpdateCliente(
        nombre: json["nombre"],
        apellido: json["apellido"],
        fechaNacimiento: DateTime.parse(json["fecha_nacimiento"]),
        genero: json["genero"],
        telefono: json["telefono"],
        correo: json["correo"],
        clave: json["clave"],
        pathFoto: json["path_foto"],
        modifiedBy: json["modified_by"],
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
        "modified_by": modifiedBy,
    };
}
