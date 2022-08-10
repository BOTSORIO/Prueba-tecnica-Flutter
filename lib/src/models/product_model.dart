class ProductModel {
  String archivo;
  String nombre;
  double precio;
  String codigo;

  int cantidad;
  double total;

  void addCantidad() {
    if (cantidad == 98) {
      cantidad = 98;
    } else {
      cantidad++;
      total = precio * cantidad;
    }
  }

  void removeCantidad() {
    cantidad--;
    total = precio * cantidad;
  }

  ProductModel({
    required this.archivo,
    required this.nombre,
    required this.precio,
    required this.codigo,
    required this.cantidad,
    required this.total,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        archivo: json["Archivo"],
        nombre: json["Nombre"],
        precio: json["Precio"],
        codigo: json["Codigo"],
        cantidad: 0,
        total: 0.0,
      );

  Map<String, dynamic> toJson() => {
        "Archivo": archivo,
        "Nombre": nombre,
        "Precio": precio,
        "Codigo": codigo,
      };
}
