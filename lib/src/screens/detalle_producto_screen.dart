import 'package:flutter/material.dart';

import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/services/services.dart';
import 'package:prueba_celuweb/src/widgets/widgets.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';
import 'package:prueba_celuweb/src/share_preferences/preferences.dart';

class DetalleProductoScreen extends StatefulWidget {
  const DetalleProductoScreen({Key? key}) : super(key: key);

  @override
  State<DetalleProductoScreen> createState() => _DetalleProductoScreenState();
}

class _DetalleProductoScreenState extends State<DetalleProductoScreen> {
  UserModel vendedor =
      UserModel(usuario: '', password: '', bussines: '', name: '');
  int contador = 0;

  @override
  void initState() {
    super.initState();
    obtenerVendedor();
  }

  @override
  Widget build(BuildContext context) {
    final ProductModel producto =
        ModalRoute.of(context)!.settings.arguments as ProductModel;

    bool isExists = false;

    List<ProductModel> productosC = Preferences.productosCarrito;

    for (int i = 0; i < productosC.length; i++) {
      if (productosC[i].codigo == producto.codigo) {
        isExists = true;
      } else {
        isExists = false;
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomAppbar(
            onpressed: () {
              Navigator.pushNamed(context, 'catalogo');
            },
            nombre: vendedor.name!,
            onTap: () {
              Navigator.pushNamed(context, 'carrito');
            },
          ),
          //
          const SizedBox(height: 30),
          //
          Container(
            width: 140,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: const Color(0xff00003D),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Text(
              'Detalle producto',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xffEFDA30)),
            ),
          ),
          //
          const SizedBox(height: 25),
          //
          _ProductCard(
            image: producto.archivo,
            nombre: producto.nombre,
            codigo: producto.codigo,
            precio: producto.precio,
          ),
          //
          const SizedBox(height: 20),
          //
          Container(
            margin: const EdgeInsets.only(left: 20),
            child: const Text(
              'Detalle',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xff00003D),
                fontSize: 15,
              ),
            ),
          ),
          //
          const SizedBox(height: 8),
          //
          _DetalleCard(),
          //
          const SizedBox(height: 20),
          //
          Container(
            height: 55,
            width: double.infinity,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                _BotonIncremental(
                  contador: producto.cantidad,
                  onpressed1: () {
                    if (producto.cantidad <= 0) {
                      contador = 0;
                    } else {
                      producto.removeCantidad();
                    }
                    setState(() {});
                  },
                  onpressed2: () {
                    producto.addCantidad();

                    setState(() {});
                  },
                ),
                //
                const SizedBox(width: 10),
                //
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: MaterialButton(
                    minWidth: 105,
                    padding: const EdgeInsets.all(8),
                    onPressed: (isExists)
                        ? null
                        : () {
                            if (producto.cantidad <= 0) {
                              NotificationsService.showSnackbar(
                                  'La cantidad deber ser mayor a 0');
                            } else {
                              Preferences.setProductCar(producto);
                              Navigator.pushNamed(context, 'catalogo');
                            }
                          },
                    color: const Color(0xff00003D),
                    child: Text(
                      isExists ? '' : 'Agregar',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xffEFDA30),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  void obtenerVendedor() async {
    final vendedorBase = await DBProvider.db.getVendedor();
    vendedor = vendedorBase!;

    setState(() {});
  }
}

class _BotonIncremental extends StatelessWidget {
  final Function() onpressed1;
  final Function() onpressed2;
  final int contador;

  const _BotonIncremental({
    required this.onpressed1,
    required this.onpressed2,
    required this.contador,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(width: 1, color: const Color(0xffB5B5B4)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //
          IconButton(
            padding: const EdgeInsets.only(bottom: 1),
            onPressed: onpressed1,
            icon: const Icon(
              Icons.remove,
              color: Color(0xff757575),
              size: 30,
            ),
          ),
          //
          Text('$contador'),
          //
          IconButton(
            padding: const EdgeInsets.only(bottom: 1),
            onPressed: onpressed2,
            icon: const Icon(
              Icons.add,
              color: Color(0xff757575),
              size: 30,
            ),
          ),
        ],
      ),
    );
  }
}

class _DetalleCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(15),
      width: double.infinity,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 40,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: const Text(
        'La leche proporciona nutrientes esenciales y es una fuente importante de energía alimentaria, proteínas de alta calidad y grasas. La leche puede contribuir considerablemente a la ingestión necesaria de nutrientes como el calcio, magnesio, selenio, riboflavina, vitamina B12 y ácido pantoténico.',
        maxLines: 4,
        textAlign: TextAlign.justify,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: 10, color: Color(0xff757575)),
      ),
    );
  }
}

class _ProductCard extends StatelessWidget {
  String image;
  String nombre;
  String codigo;
  double precio;

  _ProductCard({
    required this.image,
    required this.nombre,
    required this.codigo,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 40,
            offset: Offset(0, 10),
          )
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 30),
          //
          _ProductImage(
            image: image,
          ),
          //
          const SizedBox(height: 20),
          //
          _Textos(
            nombre: nombre,
            codigo: codigo,
            precio: precio,
          ),
          //
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _Textos extends StatelessWidget {
  String nombre;
  String codigo;
  double precio;

  _Textos({
    required this.nombre,
    required this.codigo,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            nombre,
            style: const TextStyle(
              color: Color(0xff00003D),
              fontWeight: FontWeight.bold,
              fontSize: 23,
            ),
          ),
          Text(
            codigo,
            style: const TextStyle(
              color: Color(0xff757575),
              fontSize: 15,
            ),
          ),
          Text(
            '\$$precio',
            style: const TextStyle(
              color: Color(0xff00003D),
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  String image;

  _ProductImage({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190,
      height: 180,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 70,
            offset: Offset(0, 20),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: FadeInImage(
          placeholder: const AssetImage('assets/fadeImage.png'),
          image: AssetImage('assets/products/$image'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
