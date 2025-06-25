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
    final isWide = MediaQuery.of(context).size.width >= 600;
    final maxWidth = isWide ? 500.0 : double.infinity;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: maxWidth),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Criar Conta",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFc1a9b9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),

                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'E-mail',
                      prefixIcon: Icon(Icons.email_outlined),
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: senhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Senha',
                      prefixIcon: Icon(Icons.lock_outline),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 16),

                  TextField(
                    controller: resenhaController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'Repetir senha',
                      prefixIcon: Icon(Icons.lock_reset),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.person_add_alt_1),
                      label: const Text("Cadastrar"),
                      onPressed: () => registerUser(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFc1a9b9),
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
