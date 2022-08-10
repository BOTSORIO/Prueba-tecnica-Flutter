import 'package:flutter/material.dart';

import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';

class ClienteService extends ChangeNotifier {
  List<ProductModel> products = [];

  ClienteService() {
    getProducts();
  }

  Future<List<ProductModel>> getProducts() async {
    final productos = await DBProvider.db.getProductos();

    products = productos;

    return products;
  }
}
