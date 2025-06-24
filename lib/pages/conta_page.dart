import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/contas_provider.dart';
import '../components/conta_card.dart';
import '../components/conta_dialog.dart';

class ContasPage extends StatefulWidget {
  final String casaId;

  const ContasPage({super.key, required this.casaId});

  @override
  State<ContasPage> createState() => _ContasPageState();
}

class _ContasPageState extends State<ContasPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ContasProvider>().setCasaId(widget.casaId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContasProvider>();
    final stream = provider.contasStream;

    if (stream == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Contas da Casa')),
      body: StreamBuilder<List<Conta>>(
        stream: stream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar contas'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final contas = snapshot.data ?? [];

          if (contas.isEmpty) {
            return const Center(child: Text('Nenhuma conta cadastrada'));
          }

          return ListView.builder(
            itemCount: contas.length,
            itemBuilder: (context, index) {
              final conta = contas[index];
              return ContaCard(
                conta: conta,
                onEditar: () {
                  mostrarContaDialog(
                    context: context,
                    contaExistente: conta,
                    onSalvar: (contaAtualizada) {
                      context.read<ContasProvider>().atualizarConta(
                        contaAtualizada,
                      );
                    },
                  );
                },
                onDeletar: () async {
                  await provider.deletarConta(
                    conta.id,
                  ); // certifique-se de ter esse método
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          mostrarContaDialog(
            context: context,
            onSalvar: (novaConta) {
              context.read<ContasProvider>().adicionarConta(novaConta);
            },
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Adicionar"),
      ),
    );
  }
}
