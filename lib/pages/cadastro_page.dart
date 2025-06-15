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
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Criar Conta', style: TextStyle(color: Colors.black)),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Criar Conta",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[700],
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: senhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: resenhaController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Repetir senha',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => registerUser(context),
                  child: const Text("Cadastrar"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
