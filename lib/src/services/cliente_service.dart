import 'package:flutter/material.dart';

import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';

class ClienteService extends ChangeNotifier {
  List<ClienteModel> clients = [];

  ClienteService() {
    getClientes();
  }

  Future<List<ClienteModel>> getClientes() async {
    final clientes = await DBProvider.db.getClientes();

    clients = clientes;

    return clients;
  }
}
