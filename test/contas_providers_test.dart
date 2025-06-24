import 'package:flutter_test/flutter_test.dart';
import 'package:rentcontrol/providers/contas_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

void main() {
  group('ContasProvider (sem mock)', () {
    late FakeFirebaseFirestore fakeFirestore;
    late ContasProvider provider;

    setUp(() {
      fakeFirestore = FakeFirebaseFirestore();
      provider = ContasProvider(firestore: fakeFirestore);
      provider.setCasaId('casa123');
    });

    test('adicionarConta adiciona no Firestore', () async {
      final conta = Conta(
        id: '',
        mes: 'Junho',
        ano: 2025,
        valor: 150.0,
        status: 'Pendente',
        criadoEm: Timestamp.now(),
      );

      await provider.adicionarConta(conta);

      final snapshot =
          await fakeFirestore
              .collection('casa')
              .doc('casa123')
              .collection('contas')
              .get();

      expect(snapshot.docs.length, 1);
      expect(snapshot.docs.first['mes'], 'Junho');
      expect(snapshot.docs.first['valor'], 150.0);
    });

    test('atualizarConta atualiza o documento no Firestore', () async {
      final docRef = await fakeFirestore
          .collection('casa')
          .doc('casa123')
          .collection('contas')
          .add({
            'mes': 'Maio',
            'ano': 2025,
            'valor': 100.0,
            'status': 'Pendente',
            'criadoEm': Timestamp.now(),
          });

      final contaAtualizada = Conta(
        id: docRef.id,
        mes: 'Maio',
        ano: 2025,
        valor: 300.0,
        status: 'Pago',
        criadoEm: Timestamp.now(),
      );

      await provider.atualizarConta(contaAtualizada);

      final updatedDoc = await docRef.get();
      expect(updatedDoc['valor'], 300.0);
      expect(updatedDoc['status'], 'Pago');
    });

    test('contasStream emite lista de contas corretamente', () async {
      await fakeFirestore
          .collection('casa')
          .doc('casa123')
          .collection('contas')
          .add({
            'mes': 'Abril',
            'ano': 2025,
            'valor': 99.99,
            'status': 'Pendente',
            'criadoEm': Timestamp.now(),
          });

      final stream = provider.contasStream!;
      final contas = await stream.first;

      expect(contas.length, 1);
      expect(contas.first.mes, 'Abril');
    });
  });
}
