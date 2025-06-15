import 'package:flutter/material.dart';

class CasaItem extends StatelessWidget {
  final Map<String, dynamic> data;
  final VoidCallback onTap;

  const CasaItem({super.key, required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(data['Rua'] ?? 'Sem Rua'),
      subtitle: Text(data['Bairro '] ?? 'Sem endereço'),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
