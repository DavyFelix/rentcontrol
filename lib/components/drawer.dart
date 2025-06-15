import 'package:flutter/material.dart';
import 'package:rentcontrol/routers/routers.dart';
import 'package:provider/provider.dart';
import 'package:auth_package/auth_package.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final rentsAuth = Provider.of<RentsAuth>(context, listen: false);
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/predios.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  // Contorno
                  Text(
                    'Controle de Aluguel',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground:
                          Paint()
                            ..style = PaintingStyle.stroke
                            ..strokeWidth = 2
                            ..color = const Color.fromARGB(255, 22, 22, 22),
                      shadows: [
                        Shadow(
                          blurRadius: 8,
                          color: Colors.black45,
                          offset: Offset(6, 6),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  // Preenchimento
                  Text(
                    'Controle de Aluguel',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text("Sobre"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, Routes.SOBRE);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            title: Text("Sair"),
            trailing: Icon(Icons.arrow_right),
            onTap: () async {
              await rentsAuth.signOut();
              Navigator.pushReplacementNamed(context, Routes.LOGIN);
            },
          ),
        ],
      ),
    );
  }
}

extension on RentsAuth {
  signOut() {}
}
