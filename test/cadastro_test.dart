import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:auth_package/auth_package.dart';
import 'package:rentcontrol/pages/cadastro_page.dart';
import 'package:rentcontrol/routers/routers.dart';

// Mock para o RentsAuth
class MockRentsAuth extends Mock implements RentsAuth {}

void main() {
  late MockRentsAuth mockAuth;

  setUp(() {
    mockAuth = MockRentsAuth();
  });

  Widget createTestWidget() {
    return MaterialApp(
      routes: {
        Routes.HOME: (context) => const Scaffold(body: Text("Página Inicial")),
      },
      home: ChangeNotifierProvider<RentsAuth>.value(
        value: mockAuth,
        child: CadastroPage(),
      ),
    );
  }

  testWidgets('❌ Mostra erro se campos estiverem vazios', (tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.tap(find.text('Cadastrar'));
    await tester.pump();

    expect(find.text('Preencha todos os campos'), findsOneWidget);
  });

  testWidgets('❌ Mostra erro se senhas não coincidem', (tester) async {
    await tester.pumpWidget(createTestWidget());

    await tester.enterText(find.byType(TextField).at(0), 'teste@teste.com');
    await tester.enterText(find.byType(TextField).at(1), 'senha123');
    await tester.enterText(find.byType(TextField).at(2), 'outrasenha');

    await tester.tap(find.text('Cadastrar'));
    await tester.pump();

    expect(find.text('As senhas não coincidem'), findsOneWidget);
  });
}