import 'package:flutter/material.dart';
import 'package:smartfoodinsight_app/common/utils/utis.dart';
import 'package:smartfoodinsight_app/common/widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#fed8c3"),
      body: SafeArea(
        child: Column(
          children: [
            // Fondo de la imagen
            const Expanded(
              child: Image(
                image: AssetImage('assets/images/plants.png'),
                fit: BoxFit.cover,
              ),
            ),
            // Contenedor de inicio de sesión
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    // Campos de usuario y contraseña
                    const NormalTextFormField(
                        label: 'Correo', icon: Icon(Icons.email)),
                    const PasswordTextFormField(label: 'Contraseña'),
                    // Botón de inicio de sesión
                    ElevatedButton(
                      onPressed: () {
                        // Lógica de inicio de sesión
                      },
                      child: const Text('Iniciar Sesión'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
