import 'package:flutter/material.dart';

class CasaItem extends StatelessWidget {
  final Map<String, dynamic> data;

  const CasaItem(this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    final bairro = data['Bairro '] ?? 'Sem bairro';
    final rua = data['Rua'] ?? 'Sem rua';
    final id = data['id'] ?? 'Sem ID';

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        title: Text('ID: $id'),
        subtitle: Text('Bairro: $bairro\nRua: $rua'),
      ),
    );
  }
}
