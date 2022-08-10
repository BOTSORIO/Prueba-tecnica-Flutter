import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

import 'package:provider/provider.dart';

import 'package:prueba_celuweb/src/providers/providers.dart';
import 'package:prueba_celuweb/src/services/services.dart';
import 'package:prueba_celuweb/src/share_preferences/preferences.dart';
import 'package:prueba_celuweb/src/ui/inputDecoration.dart';
import 'package:prueba_celuweb/src/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff00003D),
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 230),
              //
              Column(
                children: [
                  //
                  const SizedBox(height: 50),
                  //
                  ChangeNotifierProvider(
                    create: (_) => LoginFormProvider(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: _LoginForm(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context, listen: false);

    return Container(
      child: Form(
        key: loginForm.formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecorations.authInputDecoration(
                hintText: ' Ingrese su usuario',
                labelText: '  Usuario',
                prefixIcon: SvgPicture.asset(
                  'assets/Icono_usuario.svg',
                  height: 10,
                  width: 10,
                ),
              ),
              onChanged: (value) => loginForm.usuario = value,
              validator: (value) {
                return (value != null) ? null : 'El campo no puede estar vacio';
              },
            ),
            //
            const SizedBox(height: 30),
            //
            TextFormField(
              autocorrect: false,
              obscureText: true,
              //inputFormatters: [
              //  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?'))
              //],
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecorations.authInputDecoration(
                hintText: ' Ingrese su contraseña',
                labelText: '  Contraseña',
                prefixIcon: SvgPicture.asset(
                  'assets/Icono_contraseña.svg',
                  fit: BoxFit.contain,
                ),
              ),
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null &&
                        (value.length > 1 && value.length <= 4))
                    ? null
                    : 'El campo no puede estar vacio o el código no puede contener mas de 5 digitos';
              },
            ),
            //
            const SizedBox(height: 30),
            //
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecorations.authInputDecoration(
                hintText: ' Ingrese su empresa',
                labelText: '  Empresa',
                prefixIcon: SvgPicture.asset(
                  'assets/Icono_empresa.svg',
                  width: 5,
                  height: 5,
                  color: Colors.white,
                ),
              ),
              onChanged: (value) => loginForm.empresa = value,
              validator: (value) {
                return (value != null) ? null : 'El campo no puede estar vacio';
              },
            ),
            //
            const SizedBox(height: 10),
            //
            SizedBox(
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  alignment: Alignment.centerRight,
                  elevation: 0,
                  onSurface: Colors.transparent,
                ),
                onPressed: () {},
                child: const Text(
                  '¿Olvidaste tu contraseña?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            //
            const SizedBox(height: 30),
            //
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100)),
              disabledColor: Colors.grey,
              color: Colors.white,
              onPressed: loginForm.isLoading
                  ? null
                  : () async {
                      FocusScope.of(context).unfocus();
                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      final String? err = await authService.login(
                          loginForm.usuario,
                          loginForm.password,
                          loginForm.empresa);

                      if (err == null) {
                        Preferences.vendedorID = loginForm.usuario;
                        await Navigator.pushNamed(context, 'home');
                      } else {
                        NotificationsService.showSnackbar(err);
                        loginForm.isLoading = false;
                      }
                    },
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 75, vertical: 10),
                child: Text(
                  loginForm.isLoading ? 'Espere...' : 'Iniciar Sesión',
                  style: const TextStyle(
                      color: Color(0xff00003D),
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
