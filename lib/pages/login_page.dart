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
    rentsAuth.signIn(email, senha).then((response) {
      if (response) {
        Navigator.pushNamed(context, Routes.HOME);
      } else {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text("Email ou senha inválidos")));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Bem-vindo ao Rents!",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color:const Color(0xFFc1a9b9),
                ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => autenticar(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 201, 169, 187),
                    padding: EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text(
                    "Acessar",
                    style: TextStyle(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 248, 247, 247),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
