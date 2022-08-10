import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:prueba_celuweb/src/models/models.dart';
import 'package:prueba_celuweb/src/providers/providers.dart';
import 'package:prueba_celuweb/src/share_preferences/preferences.dart';
import 'package:prueba_celuweb/src/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ClienteModel> listaClientes = [];
  UserModel vendedor =
      UserModel(usuario: '', password: '', bussines: '', name: '');

  @override
  void initState() {
    super.initState();
    cargarClientes();
    obtenerVendedor();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //
          const SizedBox(height: 10),
          //
          _HeaderCard(
            size: size,
            cantidadClientes: listaClientes.length,
            nombreVendedor: vendedor.name!,
            empresa: vendedor.bussines,
            codigo: vendedor.usuario,
          ),
          //
          const SizedBox(height: 25),
          //
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: size.width * 0.25,
                margin: const EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: const Color(0xff00003D),
                  borderRadius: BorderRadius.circular(100),
                ),
                child: const Text(
                  'Clientes',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Color(0xffEFDA30)),
                ),
              ),
            ],
          ),
          //
          const SizedBox(height: 10),
          //
          Expanded(
            child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: listaClientes.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  padding: EdgeInsets.zero,
                  margin: const EdgeInsets.only(top: 12, left: 20, right: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: MaterialButton(
                      padding: EdgeInsets.zero,
                      minWidth: double.infinity,
                      onPressed: () {
                        Preferences.clienteID = listaClientes[index].codigo;
                        Navigator.pushNamed(context, 'catalogo');
                      },
                      color: Colors.white,
                      highlightColor: const Color(0xff00003D),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Stack(children: [
                          Positioned(
                            right: -30,
                            top: -10,
                            child: Transform.rotate(
                              angle: -0.5,
                              child: Icon(
                                Icons.person_pin,
                                size: 90,
                                color: const Color(0xffEFDA30).withOpacity(0.9),
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              _DatosCliente(
                                color1: const Color(0xff00003D),
                                color2: const Color(0xff757575),
                                titulo: listaClientes[index].nombre,
                                detal: listaClientes[index].codigo,
                                fontSize1: 15,
                                fontSize2: 16,
                                pLeft: 20,
                                pRigth: 60,
                                pTop: 15,
                                pBottom: 2,
                              ),
                              //
                              const SizedBox(height: 5),
                              //
                              _DatosCliente(
                                color1: const Color(0xff00003D),
                                color2: const Color(0xff757575),
                                titulo: 'Nit:',
                                detal: listaClientes[index].nit,
                                fontSize1: 13,
                                fontSize2: 12,
                                pLeft: 20,
                                pRigth: 60,
                                pTop: 1,
                                pBottom: 1,
                              ),
                              //
                              _DatosCliente(
                                color1: const Color(0xff00003D),
                                color2: const Color(0xff757575),
                                titulo: 'Razon social:',
                                detal: listaClientes[index].razonS,
                                fontSize1: 13,
                                fontSize2: 12,
                                pLeft: 20,
                                pRigth: 60,
                                pTop: 1,
                                pBottom: 1,
                              ),
                              //
                              _DatosCliente(
                                color1: const Color(0xff00003D),
                                color2: const Color(0xff757575),
                                titulo: 'Telefono:',
                                detal: listaClientes[index].telefono,
                                fontSize1: 13,
                                fontSize2: 12,
                                pLeft: 20,
                                pRigth: 60,
                                pTop: 1,
                                pBottom: 15,
                              ),
                            ],
                          ),
                        ]),
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    ));
  }

  void cargarClientes() async {
    final clientesBase = await DBProvider.db.getClientes();
    listaClientes.clear();
    //print(clientesBase.length);
    for (int i = 0; i < clientesBase.length; i++) {
      listaClientes.add(clientesBase[i]);
    }

    setState(() {});
  }

  void obtenerVendedor() async {
    final vendedorBase = await DBProvider.db.getVendedor();
    vendedor = vendedorBase!;

    setState(() {});
  }
}

class _DatosCliente extends StatelessWidget {
  Color? color1;
  Color? color2;
  String titulo;
  String detal;
  double? fontSize1;
  double? fontSize2;
  double pLeft;
  double pRigth;
  double pTop;
  double pBottom;

  _DatosCliente({
    this.color1,
    this.color2 = const Color(0xffB5B5B4),
    required this.titulo,
    required this.detal,
    this.fontSize1,
    this.fontSize2,
    required this.pLeft,
    required this.pRigth,
    required this.pTop,
    required this.pBottom,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          bottom: pBottom, right: pRigth, left: pLeft, top: pTop),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            titulo,
            style: TextStyle(
                fontSize: fontSize1,
                fontWeight: FontWeight.bold,
                color: color1),
          ),
          Text(
            detal,
            style: TextStyle(fontSize: fontSize2, color: color2),
          ),
        ],
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  int? cantidadClientes;
  String nombreVendedor;
  String empresa;
  String codigo;

  _HeaderCard({
    Key? key,
    required this.size,
    required this.nombreVendedor,
    required this.empresa,
    required this.codigo,
    this.cantidadClientes = 0,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return CardContainer(
      child: Column(
        children: [
          //
          _IconosSuperiores(size: size),
          //
          const SizedBox(height: 15),
          //
          _AvatarAndLoading(cantidadClientes!, nombreVendedor, size),
          //
          const SizedBox(height: 20),
          //
          const Divider(color: Color(0xff00003D), height: 4),
          //
          const SizedBox(height: 10),
          //
          const SizedBox(
            width: double.infinity,
            child: Text(
              'Información personal',
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Color(0xff00003D),
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ),
          //
          const SizedBox(height: 20),
          //
          _Informacion(
            empresa: empresa,
            codigo: codigo,
          ),
        ],
      ),
    );
  }
}

class _Informacion extends StatelessWidget {
  String empresa;
  String codigo;

  _Informacion({
    required this.empresa,
    required this.codigo,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          _DetalleInfo(
            widget1: _Detal(
              icon: Icons.numbers_rounded,
              titulo: 'Código',
              detal: codigo,
            ),
            //
            widget2: _Detal(
              icon: FontAwesomeIcons.building,
              titulo: 'Empresa',
              detal: empresa,
            ),
          ),
          //
          const SizedBox(height: 10),
          //
        ],
      ),
    );
  }
}

class _DetalleInfo extends StatelessWidget {
  Widget widget1;
  Widget widget2;

  _DetalleInfo({required this.widget1, required this.widget2});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        widget1,
        widget2,
      ],
    );
  }
}

class _Detal extends StatelessWidget {
  IconData icon;
  String titulo;
  String? detal;

  _Detal({
    required this.icon,
    this.detal = 'Defect',
    required this.titulo,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 25,
          color: const Color(0xff00003D),
        ),
        const SizedBox(height: 3),
        Text(
          titulo,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Color(0xff00003D),
          ),
        ),
        const SizedBox(height: 1),
        Text(
          detal!,
          style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
              color: Color(0xff757575)),
        ),
      ],
    );
  }
}

class _AvatarAndLoading extends StatelessWidget {
  int cantidadClientes;
  String nombre;
  final Size size;

  _AvatarAndLoading(this.cantidadClientes, this.nombre, this.size);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        //
        _AvatarContainer(nombre, size),
        //
        const SizedBox(width: 20),
        //
        _ProgressContainer(cantidadClientes, size),
      ],
    );
  }
}

class _ProgressContainer extends StatelessWidget {
  int cantidadClientes;
  final Size size;

  _ProgressContainer(this.cantidadClientes, this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //
          const SizedBox(height: 15),
          //
          _BarraProgreso(size),
          //
          const SizedBox(height: 15),
          //
          _Icons('\$5000', '\$4,500', '$cantidadClientes')
        ],
      ),
    );
  }
}

class _Icons extends StatelessWidget {
  String p1;
  String p2;
  String p3;

  _Icons(this.p1, this.p2, this.p3);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      padding: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconText(
            svg: 'assets/Icono_perfil1.svg',
            titulo: 'Lorem',
            precio: p1,
          ),
          //
          const SizedBox(width: 20),
          //
          IconText(
            svg: 'assets/Icono_perfil2.svg',
            titulo: 'Lorem',
            precio: p2,
          ),
          //
          const SizedBox(width: 20),
          //
          IconText(
            svg: 'assets/Icono_perfil3.svg',
            titulo: 'Lorem',
            precio: p3,
          ),
        ],
      ),
    );
  }
}

class IconText extends StatelessWidget {
  String svg;
  String titulo;
  String precio;

  // ignore: use_key_in_widget_constructors
  IconText({
    required this.svg,
    required this.titulo,
    required this.precio,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(svg),
        //
        const SizedBox(height: 2),
        //
        Text(
          titulo,
          style: TextStyle(
            fontSize: 10,
            color: const Color(0xffB5B5B4).withOpacity(0.9),
          ),
        ),
        //
        const SizedBox(height: 8),
        //
        Text(
          precio,
          style: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _BarraProgreso extends StatelessWidget {
  final Size size;

  _BarraProgreso(this.size);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 5),
      child: Row(
        children: [
          Stack(
            children: [
              Container(
                height: size.height * 0.014,
                width: size.width * 0.4,
                decoration: BoxDecoration(
                  color: const Color(0xffB5B5B4).withOpacity(0.5),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Container(
                height: size.height * 0.014,
                width: size.width * 0.25,
                decoration: BoxDecoration(
                  color: const Color(0xff00003D),
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class _AvatarContainer extends StatelessWidget {
  String nombre;
  final Size size;

  _AvatarContainer(this.nombre, this.size);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CircleAvatar(size: size),
        //
        const SizedBox(height: 10),
        //
        Container(
          child: Text(
            nombre,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Color(0xff00003D)),
          ),
        ),
        //
        const SizedBox(height: 5),
        //
        Container(
          margin: const EdgeInsets.only(left: 10),
          child: Text(
            'Bienvenido',
            style: TextStyle(
              color: const Color(0xffB5B5B4).withOpacity(0.9),
              fontSize: 12,
            ),
          ),
        ),
      ],
    );
  }
}

class _CircleAvatar extends StatelessWidget {
  final Size size;

  _CircleAvatar({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10),
      width: size.width * 0.2,
      height: size.height * 0.1,
      child: CircleAvatar(
        backgroundColor: const Color(0xffB5B5B4).withOpacity(0.3),
        child: SvgPicture.asset('assets/Logo_azul.svg'),
      ),
    );
  }
}

class _IconosSuperiores extends StatelessWidget {
  final Size size;

  const _IconosSuperiores({required this.size});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, 'login');
            Preferences.vendedorID = '';
          },
          child: Expanded(
              child: SvgPicture.asset('assets/Icono_cerrar_sesion.svg')),
        ),
        //
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, 'pedidos');
          },
          child: Expanded(
            child: SvgPicture.asset(
              'assets/pedidos.svg',
              width: size.width * 0.26,
              height: size.height * 0.026,
              color: const Color(0xff00003D),
            ),
          ),
        ),
      ],
    );
  }
}
