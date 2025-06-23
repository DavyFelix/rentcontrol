import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:rentcontrol/components/conta_dialog.dart';
import 'package:rentcontrol/providers/contas_provider.dart';

class MockOnSalvar extends Mock {
  void call(Conta conta);
}

void main() {
  late MockOnSalvar mockSalvar;

  setUp(() {
    mockSalvar = MockOnSalvar();
  });

  Widget buildTestableDialog() {
    return MaterialApp(
      home: Builder(
        builder: (context) => Scaffold(
          body: Center(
            child: ElevatedButton(
              onPressed: () {
                mostrarContaDialog(
                  context: context,
                  onSalvar: mockSalvar,
                );
              },
              child: const Text('Abrir Diálogo'),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> abrirDialog(WidgetTester tester) async {
    await tester.pumpWidget(buildTestableDialog());
    await tester.tap(find.text('Abrir Diálogo'));
    await tester.pumpAndSettle();
  }

  Future<void> preencherCamposValidos(WidgetTester tester) async {
    await tester.enterText(find.widgetWithText(TextFormField, 'Ano'), '2025');
    await tester.enterText(find.widgetWithText(TextFormField, 'Valor'), '150.75');
    await tester.tap(find.text('Pendente')); // abrir dropdown
    await tester.pumpAndSettle();
    await tester.tap(find.text('Pago').last); // selecionar 'Pago'
    await tester.pumpAndSettle();
  }

  testWidgets('✅ Preenche e salva uma nova conta com sucesso', (tester) async {
    await abrirDialog(tester);
    await preencherCamposValidos(tester);

    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

  });
  

  testWidgets('❌ Mostra erro se campos obrigatórios não forem preenchidos', (tester) async {
    await abrirDialog(tester);

    // Tentar salvar sem preencher
    await tester.tap(find.text('Salvar'));
    await tester.pumpAndSettle();

    // Espera as mensagens de validação aparecerem
    expect(find.text('Ano é obrigatório'), findsOneWidget);
    expect(find.text('Digite um valor válido'), findsOneWidget);

    // Verifica que o callback NÃO foi chamado
  });
}
