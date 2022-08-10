class OrdenModel {
  String? codigo;
  String fecha;
  String descripcion;
  double total;
  String cliente;
  String vendedor;

  OrdenModel({
    this.codigo,
    required this.total,
    required this.fecha,
    required this.cliente,
    required this.descripcion,
    required this.vendedor,
  });

  factory OrdenModel.fromJson(Map<String, dynamic> json) => OrdenModel(
        codigo: json["codigo"].toString(),
        total: json["total"].toDouble(),
        fecha: json["fecha"],
        cliente: json["cliente"],
        descripcion: json["descripcion"] ?? '',
        vendedor: json["vendedor"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "total": total,
        "fecha": fecha,
        "cliente": cliente,
        "descripcion": descripcion,
        "vendedor": vendedor,
      };
}
