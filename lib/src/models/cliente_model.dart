class ClienteModel {
  String codigo;
  String nombre;
  String razonS;
  String nit;
  String telefono;

  ClienteModel({
    required this.codigo,
    required this.nombre,
    required this.razonS,
    required this.nit,
    required this.telefono,
  });

  factory ClienteModel.fromJson(Map<String, dynamic> json) => ClienteModel(
        codigo: json["Codigo"],
        nombre: json["Nombre"],
        razonS: json["Razonsocial"],
        nit: json["Nit"],
        telefono: json["Telefono"],
      );

  Map<String, dynamic> toJson() => {
        "Codigo": codigo,
        "Nombre": nombre,
        "Razonsocial": razonS,
        "Nit": nit,
        "Telefono": telefono,
      };
}
