import 'package:flutter/material.dart';

import 'package:prueba_celuweb/src/providers/providers.dart';

class AuthService extends ChangeNotifier {
  Future<String?> login(String user, String password, String bussines) async {
    final userFind = await DBProvider.db.getUserLogin(user, password, bussines);

    if (userFind != null) {
      return null;
    } else {
      return '¡Datos incorrectos!';
    }
  }
}
