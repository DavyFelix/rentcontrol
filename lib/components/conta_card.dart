import 'package:flutter/material.dart';
import '../providers/contas_provider.dart';

class ContaCard extends StatelessWidget {
  final Conta conta;
  final VoidCallback onEditar;
  final VoidCallback onDeletar;

  const ContaCard({
    super.key,
    required this.conta,
    required this.onEditar,
    required this.onDeletar,
  });

  void _confirmarExclusao(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (ctx) => AlertDialog(
            title: const Text('Confirmar exclusão'),
            content: const Text('Deseja realmente excluir esta conta?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(), // Cancelar
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop(); // Fecha o diálogo
                  onDeletar(); // Executa a função de deletar
                },
                child: const Text(
                  'Excluir',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    IconData statusIcon;

    switch (conta.status) {
      case 'Pago':
        statusColor = Colors.green;
        statusIcon = Icons.check_circle;
        break;
      case 'Cancelado':
        statusColor = Colors.grey;
        statusIcon = Icons.cancel;
        break;
      default:
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text('${conta.mes} ${conta.ano}'),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Valor: R\$ ${conta.valor.toStringAsFixed(2)}'),
            Text(
              'Status: ${conta.status}',
              style: TextStyle(color: statusColor, fontWeight: FontWeight.w500),
            ),
          ],
        ),
        leading: Icon(statusIcon, color: statusColor),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(icon: const Icon(Icons.edit), onPressed: onEditar),
            IconButton(
              icon: const Icon(Icons.delete),
              color: Colors.red,
              onPressed: () => _confirmarExclusao(context),
            ),
          ],
        ),
      ),
    );
  }
}
