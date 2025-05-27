import 'package:auth_package/auth_package.dart';
import 'package:flutter/material.dart';
import 'package:rentcontrol/routers/routers.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {


  final emailController = TextEditingController();
  final senhaController = TextEditingController();

  void autenticar(BuildContext context) {
    String email = emailController.text;
    String senha = senhaController.text;
    RentsAuth rentsAuth = Provider.of<RentsAuth>(context, listen: false);
    rentsAuth
      .signIn(email, senha)
      .then((response) {
        if (response) {
          Navigator.pushNamed(context, Routes.HOME);
        } else {
          // Informar falha
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'email',
              ),
            ),
            TextField(
              controller: senhaController,
              decoration: InputDecoration(
                hintText: 'senha',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                autenticar(context);
              },
              child: Text("Acessar"),
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.CADASTRO);
                },
                child: Text("Cadastrar-se")
            )
          ],
        ),
      ),
    );
  }

}