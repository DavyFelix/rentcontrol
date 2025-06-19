import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Conta {
  final String id;
  final String mes;
  final int ano;
  final double valor;
  final String status;
  final Timestamp criadoEm;

  Conta({
    required this.id,
    required this.mes,
    required this.ano,
    required this.valor,
    required this.status,
    required this.criadoEm,
  });

  factory Conta.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Conta(
      id: doc.id,
      mes: data['mes'] ?? '-',
      ano:
          (data['ano'] is int)
              ? data['ano']
              : int.tryParse(data['ano'].toString()) ?? 2025,
      valor: (data['valor'] ?? 0).toDouble(),
      status: data['status'] ?? 'Pendente',
      criadoEm: data['criadoEm'] ?? Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'mes': mes,
      'ano': ano,
      'valor': valor,
      'status': status,
      'criadoEm': criadoEm,
    };
  }
}

class ContasProvider with ChangeNotifier {
  String? _casaId;

  void setCasaId(String id) {
    _casaId = id;
    notifyListeners();
  }

  CollectionReference? get _ref {
    if (_casaId == null) return null;
    return FirebaseFirestore.instance
        .collection('casa')
        .doc(_casaId)
        .collection('contas');
  }

  Stream<List<Conta>>? get contasStream {
    if (_ref == null) return null;
    return _ref!
        .orderBy('criadoEm', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Conta.fromDocument(doc)).toList(),
        );
  }

  Future<void> adicionarConta(Conta conta) async {
    if (_ref != null) {
      await _ref!.add(conta.toMap());
    }
  }

  Future<void> atualizarConta(Conta conta) async {
    if (_casaId == null) return;

    final docRef = FirebaseFirestore.instance
        .collection('casa')
        .doc(_casaId)
        .collection('contas')
        .doc(conta.id);

    await docRef.update(conta.toMap());
  }
}
