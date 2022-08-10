import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/share_preferences/preferences.dart';
import 'package:prueba_celuweb/src/widgets/widgets.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';

class CarritoComprasScreen extends StatefulWidget {
  const CarritoComprasScreen({Key? key}) : super(key: key);

  @override
  State<CarritoComprasScreen> createState() => _CarritoComprasScreenState();
}

class _CarritoComprasScreenState extends State<CarritoComprasScreen> {
  UserModel vendedor =
      UserModel(usuario: '', password: '', bussines: '', name: '');
  List<ProductModel> productosCarrito = Preferences.productosCarrito;

  @override
  void initState() {
    super.initState();
    obtenerVendedor();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
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
            width: 90,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.only(left: 20),
            decoration: BoxDecoration(
              color: const Color(0xff00003D),
              borderRadius: BorderRadius.circular(100),
            ),
            child: const Text(
              'Carrito',
              textAlign: TextAlign.center,
              style: TextStyle(color: Color(0xffEFDA30)),
            ),
          ),
          //
          const SizedBox(height: 25),
          //

          // -> Productos
          Container(
            padding: EdgeInsets.zero,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            width: double.infinity,
            height: size.height * 0.55,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 40,
                  offset: Offset(0, 40),
                )
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 0, bottom: 0),
                physics: const BouncingScrollPhysics(),
                itemCount:
                    (productosCarrito.isEmpty) ? 0 : productosCarrito.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    width: double.infinity,
                    height: 137,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1.5,
                          color: const Color(0xffB5B5B4).withOpacity(0.3),
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 137,
                          width: 130,
                          child: Container(
                            padding: const EdgeInsets.only(
                                top: 0, right: 25, left: 25),
                            child: FadeInImage(
                              image: AssetImage(
                                'assets/products/${productosCarrito[index].archivo}',
                              ),
                              placeholder:
                                  const AssetImage('assets/fadeImage.png'),
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.only(top: 30),
                          width: 112,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                productosCarrito[index].nombre,
                                style: const TextStyle(
                                    color: Color(0xff00003D),
                                    fontWeight: FontWeight.bold,
                                    overflow: TextOverflow.ellipsis),
                                maxLines: 1,
                              ),
                              //
                              Text(
                                productosCarrito[index].codigo,
                                style: const TextStyle(
                                  color: Color(0xffB5B5B4),
                                  fontSize: 12,
                                ),
                              ),
                              //
                              Text(
                                '\$${productosCarrito[index].precio}',
                                style: const TextStyle(
                                  color: Color(0xff757575),
                                  fontSize: 12,
                                ),
                              ),
                              //
                              const SizedBox(height: 10),
                              //
                              Container(
                                margin: EdgeInsets.zero,
                                child: Flexible(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconButton(
                                          alignment: Alignment.centerLeft,
                                          padding: EdgeInsets.zero,
                                          onPressed: () {
                                            if (productosCarrito[index]
                                                    .cantidad <=
                                                1) {
                                              Preferences.productosCarrito
                                                  .remove(
                                                      productosCarrito[index]);
                                            } else {
                                              productosCarrito[index]
                                                  .removeCantidad();
                                            }

                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.circleMinus,
                                            size: 20,
                                            color: Color(0xffB5B5B4),
                                          ),
                                        ),
                                        //
                                        Text(
                                            '${productosCarrito[index].cantidad}'),
                                        //
                                        IconButton(
                                          alignment: Alignment.centerRight,
                                          onPressed: () {
                                            productosCarrito[index]
                                                .addCantidad();

                                            setState(() {});
                                          },
                                          icon: const Icon(
                                            FontAwesomeIcons.circlePlus,
                                            color: Color(0xffB5B5B4),
                                            size: 20,
                                          ),
                                        )
                                      ]),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                          height: 137,
                          width: 68,
                          padding: const EdgeInsets.only(top: 30, left: 5),
                          child: Text(
                            '\$${productosCarrito[index].total}',
                            style: const TextStyle(
                                color: Color(0xff757575),
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis),
                            maxLines: 2,
                          ),
                        ),
                        //
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          //
          const SizedBox(height: 40),
          //
          Container(
            width: double.infinity,
            height: 50,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: MaterialButton(
                onPressed: () {
                  displayDialog(context);
                },
                color: const Color(0xff00003D),
                child: const Text(
                  'Guardar pedido',
                  style: TextStyle(
                    color: Color(0xffEFDA30),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
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

class _Products extends StatelessWidget {
  List<ProductModel> productos;
  int contador;
  Function() onpressed1;
  Function() onpressed2;
  double precioFinal;

  _Products({
    required this.productos,
    required this.contador,
    required this.onpressed1,
    required this.onpressed2,
    required this.precioFinal,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.zero,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      height: size.height * 0.55,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 40,
            offset: Offset(0, 40),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: ListView.builder(
          padding: const EdgeInsets.only(top: 0, bottom: 0),
          physics: const BouncingScrollPhysics(),
          itemCount: (productos.isEmpty) ? 0 : productos.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              width: double.infinity,
              height: 137,
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1.5,
                    color: const Color(0xffB5B5B4).withOpacity(0.3),
                  ),
                ),
              ),
              child: Row(
                children: [
                  Container(
                    height: 137,
                    width: 130,
                    child: Container(
                      padding:
                          const EdgeInsets.only(top: 0, right: 25, left: 25),
                      child: FadeInImage(
                        image: AssetImage(
                          'assets/products/${productos[index].archivo}',
                        ),
                        placeholder: const AssetImage('assets/fadeImage.png'),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(top: 30),
                    width: 104,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          productos[index].nombre,
                          style: const TextStyle(
                              color: Color(0xff00003D),
                              fontWeight: FontWeight.bold,
                              overflow: TextOverflow.ellipsis),
                          maxLines: 1,
                        ),
                        //
                        Text(
                          productos[index].codigo,
                          style: const TextStyle(
                            color: Color(0xffB5B5B4),
                            fontSize: 12,
                          ),
                        ),
                        //
                        Text(
                          '\$${productos[index].precio}',
                          style: const TextStyle(
                            color: Color(0xff757575),
                            fontSize: 12,
                          ),
                        ),
                        //
                        const SizedBox(height: 10),
                        //
                        Container(
                          margin: EdgeInsets.zero,
                          child: Flexible(
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    alignment: Alignment.centerLeft,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {},
                                    icon: const Icon(
                                      FontAwesomeIcons.circleMinus,
                                      size: 20,
                                      color: Color(0xffB5B5B4),
                                    ),
                                  ),
                                  //
                                  Text('$contador'),
                                  //
                                  IconButton(
                                    alignment: Alignment.centerRight,
                                    onPressed: () {},
                                    icon: const Icon(
                                      FontAwesomeIcons.circlePlus,
                                      color: Color(0xffB5B5B4),
                                      size: 20,
                                    ),
                                  )
                                ]),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 137,
                    width: 76,
                    padding: const EdgeInsets.only(top: 30, left: 5),
                    child: Text(
                      '\$$precioFinal',
                      style: const TextStyle(
                          color: Color(0xff757575),
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          overflow: TextOverflow.ellipsis),
                    ),
                  ),
                  //
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
