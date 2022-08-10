import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class AuthBackground extends StatelessWidget {
  final Widget child;

  const AuthBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          _Logo(),
          //
          child,
        ],
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.only(top: 105),
        width: double.infinity,
        child: SvgPicture.asset('assets/Logo.svg'),
      ),
    );
  }
}
