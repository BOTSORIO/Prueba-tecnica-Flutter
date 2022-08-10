import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';

class PedidosScreen extends StatefulWidget {
  const PedidosScreen({Key? key}) : super(key: key);

  @override
  State<PedidosScreen> createState() => _PedidosScreenState();
}

class _PedidosScreenState extends State<PedidosScreen> {
  List<OrdenModel> pedidos = [];
  UserModel vendedor =
      UserModel(usuario: '', password: '', bussines: '', name: '');

  @override
  void initState() {
    super.initState();
    obtenerVendedor();
    cargarPedidos();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: size.height * 0.9,
            child: CustomPaint(
              painter: _HeaderPicoPainter(),
              child: SafeArea(
                child: Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      height: 130,
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      width: double.infinity,
                      child: Column(
                        children: [
                          const Icon(
                            Icons.person_pin,
                            size: 80,
                            color: Color(0xffEFDA30),
                          ),
                          //
                          _TextosHeader(
                            nombre: vendedor.name!,
                            cant: pedidos.length,
                            codigo: vendedor.usuario,
                            empresa: vendedor.bussines,
                          )
                        ],
                      ),
                    ),
                    //
                    Positioned(
                      top: 200,
                      child: Container(
                        width: size.width * 0.892,
                        height: size.height * 0.536,
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 40,
                              offset: Offset(0, 15),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: pedidos.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: double.infinity,
                                height: 101,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1.5,
                                      color: const Color(0xffB5B5B4)
                                          .withOpacity(0.3),
                                    ),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    //
                                    const Icon(
                                      FontAwesomeIcons.clipboard,
                                      size: 50,
                                      color: Color(0xffB5B5B4),
                                    ),
                                    //
                                    Container(
                                      height: 90,
                                      width: 230,
                                      padding: const EdgeInsets.only(
                                          left: 20, top: 13),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          //
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: const [
                                              //
                                              Text(
                                                'Cliente:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  color: Color(0xff00003D),
                                                ),
                                              ),
                                              //
                                              SizedBox(height: 5),
                                              //
                                              Text(
                                                'Fecha:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Color(0xffB5B5B4),
                                                ),
                                              ),
                                              //
                                              SizedBox(height: 5),
                                              //
                                              Text(
                                                'Total:',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Color(0xffB5B5B4),
                                                ),
                                              )
                                            ],
                                          ),
                                          //
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                pedidos.isNotEmpty
                                                    ? pedidos[index].cliente
                                                    : '',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              //
                                              const SizedBox(height: 5),
                                              //
                                              Text(
                                                pedidos.isNotEmpty
                                                    ? pedidos[index].fecha
                                                    : '',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Color(0xffB5B5B4),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              //
                                              const SizedBox(height: 5),
                                              //
                                              Text(
                                                pedidos.isNotEmpty
                                                    ? '\$${pedidos[index].total}'
                                                    : '',
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14,
                                                  color: Color(0xffB5B5B4),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              )
                                            ],
                                          ),
                                          //
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 50,
            width: size.width * 0.9,
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: MaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'home');
                },
                color: const Color(0xff00003D),
                child: const Text(
                  'Regresar al inicio',
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

  void cargarPedidos() async {
    final pedidosBase = await DBProvider.db.getOrdenes();
    pedidos.clear();

    for (int i = 0; i < pedidosBase.length; i++) {
      pedidos.add(pedidosBase[i]);
    }

    setState(() {});
  }
}

class _TextosHeader extends StatelessWidget {
  final String nombre;
  final String empresa;
  final String codigo;
  final int cant;

  _TextosHeader({
    required this.nombre,
    required this.empresa,
    required this.codigo,
    required this.cant,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                nombre,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //
              const SizedBox(height: 8),
              //
              Text(
                empresa,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
              ),
            ],
          ),
          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                codigo,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
              //
              const SizedBox(height: 8),
              //
              Text(
                '$cant',
                style: const TextStyle(
                  color: Color(0xffEFDA30),
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _HeaderPicoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final lapiz = Paint();

    // Propiedades
    lapiz.color = const Color(0xff00003D);
    lapiz.style = PaintingStyle.fill; // .fill .stroke
    lapiz.strokeWidth = 20;

    final path = Path();

    // Dibujar con el path y el lapiz
    path.lineTo(0, size.height * 0.25);
    path.lineTo(size.width * 0.5, size.height * 0.30);
    path.lineTo(size.width, size.height * 0.25);
    path.lineTo(size.width, 0);

    canvas.drawPath(path, lapiz);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
