import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import '../providers/contas_provider.dart';

Future<void> mostrarContaDialog({
  required BuildContext context,
  Conta? contaExistente,
  required void Function(Conta novaConta) onSalvar,
}) async {
  final valorController = TextEditingController(
    text: contaExistente?.valor.toString() ?? '',
  );

  final anoController = TextEditingController(
    text: contaExistente?.ano.toString() ?? DateTime.now().year.toString(),
  );

  String mesSelecionado = contaExistente?.mes ?? 'Janeiro';
  String statusSelecionado = contaExistente?.status ?? 'Pendente';

  final meses = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro',
  ];

  final formKey = GlobalKey<FormState>();

  await showDialog(
    context: context,
    builder: (context) {
      return StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            title: Text(contaExistente == null ? 'Nova Conta' : 'Editar Conta'),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            content: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      value: mesSelecionado,
                      decoration: const InputDecoration(labelText: 'Mês'),
                      items:
                          meses
                              .map(
                                (m) =>
                                    DropdownMenuItem(value: m, child: Text(m)),
                              )
                              .toList(),
                      onChanged:
                          (value) => setState(() => mesSelecionado = value!),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: anoController,
                      decoration: const InputDecoration(labelText: 'Ano'),
                      keyboardType: TextInputType.number,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4),
                      ],
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Ano é obrigatório';
                        }
                        if (value.length != 4) {
                          return 'Ano deve ter 4 dígitos';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Digite um ano válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: valorController,
                      decoration: const InputDecoration(labelText: 'Valor'),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      validator: (value) {
                        final parsed = double.tryParse(value ?? '');
                        if (parsed == null) {
                          return 'Digite um valor válido';
                        }
                        return null;
                      },
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
                        DropdownMenuItem(
                          value: 'Cancelado',
                          child: Text('Cancelado'),
                        ),
                      ],
                      onChanged:
                          (value) => setState(() => statusSelecionado = value!),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (!formKey.currentState!.validate()) return;

                  final valor = double.parse(valorController.text.trim());
                  final ano = int.parse(anoController.text.trim());

                  final novaConta = Conta(
                    id: contaExistente?.id ?? '',
                    mes: mesSelecionado,
                    ano: ano,
                    valor: valor,
                    status: statusSelecionado,
                    criadoEm: contaExistente?.criadoEm ?? Timestamp.now(),
                  );

                  onSalvar(novaConta);
                  Navigator.pop(context);
                },
                child: const Text('Salvar'),
              ),
            ],
          );
        },
      );
    },
  );
}
