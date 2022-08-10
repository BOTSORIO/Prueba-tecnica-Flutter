import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:prueba_celuweb/src/screens/screens.dart';
import 'package:prueba_celuweb/src/services/services.dart';
import 'package:prueba_celuweb/src/share_preferences/preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Preferences.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => ClienteService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Prueba Celuweb',
        initialRoute: 'login',
        routes: {
          'login': (_) => const LoginScreen(),
          'home': (_) => const HomeScreen(),
          'catalogo': (_) => const ClienteScreen(),
          'detalle': (_) => const DetalleProductoScreen(),
          'carrito': (_) => const CarritoComprasScreen(),
          'pedidos': (_) => const PedidosScreen(),
        },
        scaffoldMessengerKey: NotificationsService.messengerKey,
        theme: ThemeData.light().copyWith(
            scaffoldBackgroundColor: const Color(0xffE5E8E8).withOpacity(1.0)),
        //theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.white24),
      ),
    );
  }
}
