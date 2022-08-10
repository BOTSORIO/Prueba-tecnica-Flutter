import 'package:prueba_celuweb/src/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;

  static String _vendedorID = '';
  static String _clienteID = '';
  // static List<String> _productosCarrito = [];
  static List<ProductModel> _productsCar = [];

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  //Usuario logueado

  static String get vendedorID {
    return _prefs.getString('vendedorID') ?? _vendedorID;
  }

  static set vendedorID(String vendedorID) {
    _vendedorID = vendedorID;
    _prefs.setString('vendedorID', vendedorID);
  }

  //Cliente seleccionado

  static String get clienteID {
    return _prefs.getString('clienteID') ?? _clienteID;
  }

  static set clienteID(String clienteID) {
    _clienteID = clienteID;
    _prefs.setString('clienteID', clienteID);
  }

  //Productos carrito

  static setProductCar(ProductModel product) {
    _productsCar.add(product);
  }

  static List<ProductModel> get productosCarrito {
    return _productsCar;
  }
}
