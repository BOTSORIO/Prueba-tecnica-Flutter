import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/share_preferences/preferences.dart';
import 'package:prueba_celuweb/src/widgets/widgets.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';

class ClienteScreen extends StatefulWidget {
  const ClienteScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ClienteScreen> createState() => _ClienteScreenState();
}

class _ClienteScreenState extends State<ClienteScreen> {
  List<ProductModel> productos = [];
  int contador = 0;
  UserModel vendedor =
      UserModel(usuario: '', password: '', bussines: '', name: '');

  @override
  void initState() {
    super.initState();
    cargarProductos();
    obtenerVendedor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomAppbar(
          onpressed: () {
            Navigator.pushNamed(context, 'home');
            Preferences.clienteID = '';
            Preferences.productosCarrito.clear();
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
          padding: const EdgeInsets.all(8),
          width: 90,
          margin: const EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
            color: const Color(0xff00003D),
            borderRadius: BorderRadius.circular(100),
          ),
          child: const Text(
            'Catalogo',
            textAlign: TextAlign.center,
            style: TextStyle(color: Color(0xffEFDA30)),
          ),
        ),
        //
        const SizedBox(height: 30),
        //
        Expanded(
          flex: 1,
          child: GridView.count(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.vertical,
            childAspectRatio: 200 / 315,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: List.generate(productos.length, (index) {
              final ProductModel producto = productos[index];

              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, 'detalle', arguments: producto);
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 10,
                          offset: Offset(0, 6),
                        )
                      ]),
                  child: Column(
                    children: [
                      _Image(image: productos[index].archivo),
                      //
                      const SizedBox(height: 10),
                      //
                      _Textos(
                        titulo: productos[index].nombre,
                        subtitulo: productos[index].codigo,
                        precio: '${productos[index].precio}',
                      ),
                      //
                      const SizedBox(height: 5),
                      //
                      _Botones(
                        onpresed1: () {
                          if (productos[index].cantidad <= 0) {
                            productos[index].cantidad = 0;
                          } else {
                            productos[index].removeCantidad();
                          }

                          setState(() {});
                        },
                        onpresed2: () {
                          if (productos[index].cantidad >= 9) {
                            productos[index].cantidad = 9;
                          } else {
                            productos[index].addCantidad();
                          }
                          setState(() {});
                        },
                        contador: productos[index].cantidad,
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
          //
        ),
        //
        const SizedBox(height: 15),
      ],
    ));
  }

  void cargarProductos() async {
    final productosBase = await DBProvider.db.getProductos();
    productos.clear();

    for (int i = 0; i < productosBase.length; i++) {
      productos.add(productosBase[i]);
    }

    setState(() {});
  }

  void obtenerVendedor() async {
    final vendedorBase = await DBProvider.db.getVendedor();
    vendedor = vendedorBase!;

    setState(() {});
  }
}

class _Botones extends StatelessWidget {
  int contador;
  Function() onpresed1;
  Function() onpresed2;

  _Botones({
    required this.contador,
    required this.onpresed1,
    required this.onpresed2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: onpresed1,
            icon: const Icon(
              FontAwesomeIcons.circleMinus,
              size: 28,
              color: Color(0xffB5B5B4),
              shadows: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 50,
                  offset: Offset(0, 10),
                )
              ],
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            '$contador',
            style: const TextStyle(color: Color(0xffB5B5B4)),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            onPressed: onpresed2,
            icon: const Icon(
              FontAwesomeIcons.circlePlus,
              size: 28,
              color: Color(0xffB5B5B4),
              shadows: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 50,
                  offset: Offset(0, 10),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Textos extends StatelessWidget {
  String titulo;
  String subtitulo;
  String precio;

  _Textos({
    required this.titulo,
    required this.subtitulo,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            titulo,
            style: const TextStyle(
              overflow: TextOverflow.ellipsis,
              color: Color(0xff00003D),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            subtitulo,
            style: const TextStyle(
              color: Color(0xff757575),
            ),
          ),
          Text(
            '\$$precio',
            style: const TextStyle(
              color: Color(0xff00003D),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ],
      ),
    );
  }
}

class _Image extends StatelessWidget {
  String image;

  _Image({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: 90,
      height: 90,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 40,
            offset: Offset(0, 8),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: FadeInImage(
          placeholder: const AssetImage('assets/fadeImage.png'),
          image: AssetImage('assets/products/$image'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
