import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/services.dart';

import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/share_preferences/preferences.dart';

class DBProvider {
  static Database? _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database?> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  Future initDB() async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, "database.db");

    final exist = await databaseExists(path);
    if (exist) {
      print('The DB exists ');
    } else {
      print('Generating copy');

      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      ByteData data = await rootBundle.load(join("assets", "database.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(
      path,
      version: 2,
      onOpen: (db) async {
        print('InitDB');

        final res = await db.rawQuery(
            ''' SELECT count(*) FROM sqlite_master WHERE type='table' AND name='Pedido' ''');
        if (res.first.values.first == 0) {
          await db.execute('''
          CREATE TABLE Pedido(
              codigo INTEGER PRIMARY KEY AUTOINCREMENT,
              fecha TEXT,
              total INTEGER,
              cliente TEXT,
              vendedor TEXT,
              descripcion TEXT,
              productos TEXT,
              FOREIGN KEY ('cliente') REFERENCES 'Clientes'('Codigo'),
              FOREIGN KEY ('vendedor') REFERENCES 'Vendedor'('Codigo')
          ) ''');
        } else {
          print('Exist table P');
        }

        final res2 = await db.rawQuery(
            ''' SELECT count(*) FROM sqlite_master WHERE type='table' AND name='DetalleProducto' ''');
        if (res2.first.values.first == 0) {
          await db.execute('''
          CREATE TABLE DetalleProducto(
            codigo INTEGER PRIMARY KEY AUTOINCREMENT,
            producto TEXT,
            pedido TEXT,
            cantidad INTEGER,
            FOREIGN KEY ('producto') REFERENCES 'ProductosCatalogo'('Codigo'),
            FOREIGN KEY ('pedido') REFERENCES 'Pedido'('Codigo')
          ) ''');
        } else {
          print('Exist table DP');
        }
      },
    );
  }

  //Metodo que valida el usuario loguado
  Future<UserModel?> getUserLogin(
      String usuario, String password, String bussines) async {
    final db = await database;

    final res = await db?.rawQuery('''
        SELECT * FROM Usuario WHERE usuario = '$usuario' AND password = '$password' AND empresa = '$bussines'    
      ''');

    if (res!.isNotEmpty) {
      return UserModel.fromJson(res.first);
    } else {
      return null;
    }
  }

  //Metodo que obtiene los clientes registrados en la base de datos
  Future<List<ClienteModel>> getClientes() async {
    final db = await database;

    final res = await db?.rawQuery('''
        SELECT codigo, nombre, razonsocial, nit, telefono FROM Clientes
        ''');

    return res!.isNotEmpty
        ? res.map((c) => ClienteModel.fromJson(c)).toList()
        : [];
  }

  //Metodo que obtiene los productos registrados en la base de datos
  Future<List<ProductModel>> getProductos() async {
    final db = await database;

    final res = await db?.rawQuery('''
        SELECT archivo, nombre, precio, codigo FROM ProductosCatalogo
        ''');

    return res!.isNotEmpty
        ? res.map((c) => ProductModel.fromJson(c)).toList()
        : [];
  }

  //Metodo que obtiene el usuario logueado
  Future<UserModel?> getVendedor() async {
    final db = await database;
    final res = await db?.rawQuery('''
          SELECT nombre, codigo, empresa FROM Vendedor WHERE codigo = '${Preferences.vendedorID}'    
        ''');
    return res!.isNotEmpty ? UserModel.fromJson(res.first) : null;
  }

  //Medoto que inserta la orden en la base de datos
  Future<int?> agregarOrden(String date, String description) async {
    List<DetalleOrdenModel> details = [];
    double total = 0;
    for (int i = 0; i < Preferences.productosCarrito.length; i++) {
      ProductModel producto = Preferences.productosCarrito[i];
      details.add(DetalleOrdenModel(
          producto: producto.codigo, cantidad: producto.total));
      total += producto.total;
    }

    OrdenModel order = OrdenModel(
        total: total,
        fecha: date,
        cliente: Preferences.clienteID,
        descripcion: description,
        vendedor: Preferences.vendedorID);
    final db = await database;
    final res = await db?.insert('Pedido', order.toJson());

    for (int i = 0; i < details.length; i++) {
      details[i].pedido = res.toString();
      await db?.insert('DetalleProducto', details[i].toJson());
    }

    Preferences.productosCarrito.clear();
    return res;
  }

  //Metodo que obtiene los pedidos registrados en la base de datos
  Future<List<OrdenModel>> getOrdenes() async {
    final db = await database;

    final res = await db?.rawQuery('''
        SELECT c.nombre as cliente,fecha, total FROM Pedido P JOIN Clientes C ON C.codigo = P.cliente;
        ''');

    return res!.isNotEmpty
        ? res.map((c) => OrdenModel.fromJson(c)).toList()
        : [];
  }
}
