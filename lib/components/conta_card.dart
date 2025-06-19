import 'package:flutter/material.dart';
import '../providers/contas_provider.dart';

class ContaCard extends StatelessWidget {
  final Conta conta;
  final VoidCallback onEditar;

  const ContaCard({super.key, required this.conta, required this.onEditar});

  @override
  Widget build(BuildContext context) {
    // Definir a cor com base no status
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
      default: // Pendente ou qualquer outro
        statusColor = Colors.orange;
        statusIcon = Icons.pending;
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(conta.mes + ' ' + conta.ano.toString()),
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
        trailing: IconButton(icon: const Icon(Icons.edit), onPressed: onEditar),
      ),
    );
  }
}
