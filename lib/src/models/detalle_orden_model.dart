class DetalleOrdenModel {
  String? codigo;
  String producto;
  String? pedido;
  double cantidad;

  DetalleOrdenModel({
    this.codigo,
    required this.producto,
    this.pedido,
    required this.cantidad,
  });

  factory DetalleOrdenModel.fromJson(Map<String, dynamic> json) =>
      DetalleOrdenModel(
        codigo: json["codigo"],
        producto: json["producto"],
        pedido: json["pedido"],
        cantidad: json["cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "producto": producto,
        "pedido": pedido,
        "cantidad": cantidad,
      };
}
