import 'package:flutter/material.dart';

import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';

class PedidoService extends ChangeNotifier {
  List<OrdenModel> pedidos = [];

  PedidoService() {
    getPedidos();
  }

  Future<List<OrdenModel>> getPedidos() async {
    final aux = await DBProvider.db.getOrdenes();

    pedidos = aux;

    return pedidos;
  }
}
