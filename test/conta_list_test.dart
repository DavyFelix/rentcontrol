import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:rentcontrol/pages/conta_page.dart';
import 'package:rentcontrol/providers/contas_provider.dart';

class MockContasProvider extends Mock implements ContasProvider {}
void main() {
  late MockContasProvider mockProvider;

  setUp(() {
    mockProvider = MockContasProvider();
  });

  Widget criarTela() {
    return MaterialApp(
      home: ChangeNotifierProvider<ContasProvider>.value(
        value: mockProvider,
        child: ContasPage(casaId: 'casa123'),
      ),
    );
  }

  testWidgets('Exibe loading enquanto stream é nula', (tester) async {
    when(mockProvider.contasStream).thenReturn(null);

    await tester.pumpWidget(criarTela());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Exibe mensagem se nenhuma conta for encontrada', (tester) async {
    when(mockProvider.contasStream).thenAnswer((_) => Stream.value([]));

    await tester.pumpWidget(criarTela());
    await tester.pump(); // avança o stream

    expect(find.text('Nenhuma conta cadastrada'), findsOneWidget);
  });

  testWidgets('Exibe erro se snapshot tiver erro', (tester) async {
    when(mockProvider.contasStream)
        .thenAnswer((_) => Stream.error("Erro"));

    await tester.pumpWidget(criarTela());
    await tester.pump();

    expect(find.text('Erro ao carregar contas'), findsOneWidget);
  });

testWidgets('Renderiza lista de contas', (tester) async {
  final contas = [
    Conta(
      valor: 120.0,
      id: '1',
      mes: 'Janeiro',
      ano: 2025,
      status: 'Pendente',
      criadoEm: Timestamp.fromDate(DateTime(2025, 1, 15)),
    ),
    Conta(
      valor: 80.0,
      id: '2',
      mes: 'Janeiro',
      ano: 2025,
      status: 'Pendente',
      criadoEm: Timestamp.fromDate(DateTime(2025, 1, 15)),
    ),
  ];

  when(mockProvider.contasStream).thenAnswer((_) => Stream.value(contas));

  await tester.pumpWidget(criarTela());
  await tester.pump();

});


  testWidgets('Botão Adicionar aciona o diálogo', (tester) async {
    when(mockProvider.contasStream).thenAnswer((_) => Stream.value([]));

    await tester.pumpWidget(criarTela());
    await tester.pump();

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();

    expect(find.textContaining('Salvar'), findsOneWidget); // se houver no dialog
  });
}
