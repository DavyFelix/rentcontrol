import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CasaProvider with ChangeNotifier {
  final _casaCollection = FirebaseFirestore.instance.collection('casa');

  Stream<QuerySnapshot> get casasStream => _casaCollection.snapshots();

  Future<void> adicionarCasa(Map<String, dynamic> novaCasa) async {
    await _casaCollection.add(novaCasa);
    notifyListeners();
  }
}
