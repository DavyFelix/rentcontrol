import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentcontrol/components/casaItem.dart';
import 'package:rentcontrol/components/drawer.dart';
import 'package:rentcontrol/pages/conta_page.dart';
import 'package:rentcontrol/pages/cadastra_casa_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Controle de Aluguel',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: _buildCasaList(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddCasaPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildCasaList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('casa').snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Erro ao carregar dados'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final casas = snapshot.data?.docs ?? [];

        if (casas.isEmpty) {
          return const Center(child: Text('Nenhuma casa cadastrada'));
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: casas.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final doc = casas[index];
            final data = doc.data();

            if (data == null || data is! Map<String, dynamic>) {
              return const ListTile(
                title: Text('Erro nos dados'),
                subtitle: Text('Não foi possível ler este item.'),
              );
            }

            return CasaItem(
              data: data,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => ContasPage(casaId: doc.id)),
                );
              },
            );
          },
        );
      },
    );
  }
}
