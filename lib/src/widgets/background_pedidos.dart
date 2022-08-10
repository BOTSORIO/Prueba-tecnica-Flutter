import 'package:flutter/material.dart';
import 'package:prueba_celuweb/src/widgets/header.dart';

class BackgroundPedidos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              HeaderPico(),
            ],
          ),
        ],
      ),
    );
  }
}
