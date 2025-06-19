import 'package:flutter/material.dart';

class SobrePage extends StatelessWidget {
  const SobrePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Image.asset(
            'assets/images/predios.jpg',
            fit: BoxFit.cover,
            // ignore: deprecated_member_use
            color: Colors.black.withOpacity(0.3),
            colorBlendMode: BlendMode.darken,
          ),
        ),
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.6),
                  // ignore: deprecated_member_use
                  Colors.black.withOpacity(0.3),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Sobre o App'),
            // ignore: deprecated_member_use
            backgroundColor: const Color.fromARGB(
              255,
              183,
              153,
              184,
            ).withOpacity(0.95),
            elevation: 3,
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Controle de Aluguel',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          offset: Offset(1.5, 1.5),
                          blurRadius: 4,
                          color: Colors.black45,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24),
                  Text(
                    'O Controle de Aluguel é um aplicativo simples e prático para organizar os pagamentos de aluguel de imóveis.Com ele, é possível cadastrar casas, registrar mensalmente os valores de aluguel, acompanhar o status de pagamento (Pendente, Pago ou Cancelado) e manter um histórico por mês e ano.Ideal para proprietários ou responsáveis pela gestão de um ou mais imóveis.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                      height: 1.4,
                      shadows: [
                        Shadow(
                          offset: Offset(0.5, 0.5),
                          blurRadius: 3,
                          color: Colors.black38,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Versão: 1.0.0',
                    style: TextStyle(
                      fontSize: 15,
                      fontStyle: FontStyle.italic,
                      color: Colors.white60,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Desenvolvido por Davy de Souza',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
