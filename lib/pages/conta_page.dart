import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ContasPage extends StatelessWidget {
  final String casaId;

  const ContasPage({super.key, required this.casaId});

  @override
  Widget build(BuildContext context) {
    final contasRef = FirebaseFirestore.instance
        .collection('casa')
        .doc(casaId)
        .collection('contas');

    return Scaffold(
      appBar: AppBar(title: const Text('Contas da Casa')),
      body: StreamBuilder<QuerySnapshot>(
        stream: contasRef.orderBy('criadoEm', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Erro ao carregar contas'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final contas = snapshot.data?.docs ?? [];

          if (contas.isEmpty) {
            return const Center(child: Text('Nenhuma conta cadastrada'));
          }

          return ListView.builder(
            itemCount: contas.length,
            itemBuilder: (context, index) {
              final conta = contas[index].data() as Map<String, dynamic>;
              final status = conta['status'] ?? 'Pendente';
              final mes = conta['mes'] ?? '-';

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  title: Text(conta['mes'] ?? 'Sem descrição'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Valor: R\$ ${conta['valor']?.toStringAsFixed(2) ?? '0.00'}',
                      ),
                      Text(
                        'Status: $status',
                        style: TextStyle(
                          color: status == 'Pago' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  leading: Icon(
                    status == 'Pago' ? Icons.check_circle : Icons.pending,
                    color: status == 'Pago' ? Colors.green : Colors.orange,
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) => _novaContaDialog(ctx, contasRef),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Adicionar"),
      ),
    );
  }

  Widget _novaContaDialog(BuildContext context, CollectionReference contasRef) {
    final descricaoController = TextEditingController();
    final valorController = TextEditingController();

    String mesSelecionado = 'Janeiro';
    String statusSelecionado = 'Pendente';

    return StatefulBuilder(
      builder: (context, setState) {
        return AlertDialog(
          title: const Text('Nova Conta'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: mesSelecionado,
                  decoration: const InputDecoration(labelText: 'Mês'),
                  items: const [
                    DropdownMenuItem(value: 'Janeiro', child: Text('Janeiro')),
                    DropdownMenuItem(
                      value: 'Fevereiro',
                      child: Text('Fevereiro'),
                    ),
                    DropdownMenuItem(value: 'Março', child: Text('Março')),
                    DropdownMenuItem(value: 'Abril', child: Text('Abril')),
                    DropdownMenuItem(value: 'Maio', child: Text('Maio')),
                    DropdownMenuItem(value: 'Junho', child: Text('Junho')),
                    DropdownMenuItem(value: 'Julho', child: Text('Julho')),
                    DropdownMenuItem(value: 'Agosto', child: Text('Agosto')),
                    DropdownMenuItem(
                      value: 'Setembro',
                      child: Text('Setembro'),
                    ),
                    DropdownMenuItem(value: 'Outubro', child: Text('Outubro')),
                    DropdownMenuItem(
                      value: 'Novembro',
                      child: Text('Novembro'),
                    ),
                    DropdownMenuItem(
                      value: 'Dezembro',
                      child: Text('Dezembro'),
                    ),
                  ],
                  onChanged:
                      (value) => setState(() {
                        mesSelecionado = value!;
                      }),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: valorController,
                  decoration: const InputDecoration(labelText: 'Valor'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 10),
                DropdownButtonFormField<String>(
                  value: statusSelecionado,
                  decoration: const InputDecoration(labelText: 'Status'),
                  items: const [
                    DropdownMenuItem(
                      value: 'Pendente',
                      child: Text('Pendente'),
                    ),
                    DropdownMenuItem(value: 'Pago', child: Text('Pago')),
                  ],
                  onChanged:
                      (value) => setState(() {
                        statusSelecionado = value!;
                      }),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final valor = double.tryParse(valorController.text.trim());

                if (valor == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Preencha todos os campos corretamente'),
                    ),
                  );
                  return;
                }

                await contasRef.add({
                  'valor': valor,
                  'mes': mesSelecionado,
                  'status': statusSelecionado,
                  'criadoEm': Timestamp.now(),
                });

                Navigator.pop(context);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
