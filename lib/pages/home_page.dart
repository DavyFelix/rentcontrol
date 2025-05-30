import 'package:auth_package/auth_package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcontrol/routers/routers.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rentsAuth = Provider.of<RentsAuth>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Text('sei la'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await rentsAuth.signOut();
          Navigator.pushReplacementNamed(context, Routes.LOGIN);
        },
        child: Icon(Icons.logout),
        tooltip: 'Sair',
      ),
    );
  }
}

extension on RentsAuth {
  signOut() {}
}
