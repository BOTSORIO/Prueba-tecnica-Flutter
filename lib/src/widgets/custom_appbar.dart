import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class CustomAppbar extends StatelessWidget {
  final String nombre;
  final Function() onTap;
  final Function() onpressed;

  CustomAppbar({
    required this.nombre,
    required this.onTap,
    required this.onpressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(left: 8, right: 15, top: 20, bottom: 25),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 40, offset: Offset(0, -10))
        ],
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Row(
        children: [
          const SizedBox(height: 10),
          //
          IconButton(
            onPressed: onpressed,
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: const Color(0xff00003D).withOpacity(0.6),
              size: 28,
            ),
          ),

          //
          _CircleAvatar(),
          //
          const SizedBox(width: 15),
          //
          _Textos(nombre),
          //
          const SizedBox(width: 60),
          //
          GestureDetector(
            onTap: onTap,
            child: Expanded(
              child: SvgPicture.asset(
                'assets/Icono_carrito_compras.svg',
                width: 30,
                height: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Textos extends StatelessWidget {
  String nombre;

  _Textos(this.nombre);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nombre,
          style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xff00003D)),
        ),
        //
        const SizedBox(height: 5),
        //
        const Text(
          'Bienvenido',
          style: TextStyle(
            color: Color(0xff757575),
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

class _CircleAvatar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 3),
      width: 70,
      height: 70,
      child: CircleAvatar(
        backgroundColor: const Color(0xffB5B5B4).withOpacity(0.3),
        child: SvgPicture.asset('assets/Logo_azul.svg'),
      ),
    );
  }
}
