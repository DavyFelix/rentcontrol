import 'package:auth_package/auth_package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcontrol/routers/routers.dart';

class CadastroPage extends StatelessWidget {
  final emailController = TextEditingController();
  final senhaController = TextEditingController();
  final resenhaController = TextEditingController();

  void registerUser(BuildContext context) {
    String email = emailController.text.trim();
    String senha = senhaController.text;
    String resenha = resenhaController.text;

    if (email.isEmpty || senha.isEmpty || resenha.isEmpty) {
      _showMessage(context, 'Preencha todos os campos');
      return;
    }

    if (senha != resenha) {
      _showMessage(context, 'As senhas não coincidem');
      return;
    }

    RentsAuth rentsAuth = Provider.of<RentsAuth>(context, listen: false);
    rentsAuth.signUp(email, senha).then((resposta) {
      if (resposta) {
        Navigator.pushReplacementNamed(context, Routes.HOME);
      } else {
        _showMessage(context, 'Erro ao cadastrar. Tente novamente.');
      }
    });
  }

  void _showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Cadastrar-se", style: TextStyle(fontSize: 24)),
              TextField(
                controller: emailController,
                decoration: const InputDecoration(hintText: 'E-mail'),
              ),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Senha'),
              ),
              TextField(
                controller: resenhaController,
                obscureText: true,
                decoration: const InputDecoration(hintText: 'Repetir a senha'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => registerUser(context),
                child: const Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
