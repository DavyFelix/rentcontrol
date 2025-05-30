import 'package:flutter/material.dart';
import 'package:rentcontrol/routers/routers.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/menuft.png'),
                fit: BoxFit.cover
              ),
            ),
            child: Center(
              child: Stack(
                children: [
                  // Contorno
                  Text(
                    'CHECKPOINTO',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      foreground: Paint()
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
                    'CHECKPOINTO',
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 234, 252, 76),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          /*ListTile(
            leading: Icon(Icons.star_outlined),
            title: Text("Favoritos"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pop(context);
            },
          ),*/
          ListTile(
            leading: Icon(Icons.info_outline_rounded),
            title: Text("Sobre"),
            trailing: Icon(Icons.arrow_right),
            onTap: () {
              Navigator.pushNamed(context, Routes.SOBRE);
          },
          ),
        ],
      ),
    );
  }
}
