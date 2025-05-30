import 'package:auth_package/auth_package.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rentcontrol/pages/cadastro_page.dart';
import 'package:rentcontrol/pages/home_page.dart';
import 'package:rentcontrol/pages/login_page.dart';
import 'package:rentcontrol/routers/routers.dart';

void main() async {
  runApp(const App());
}
class App extends StatelessWidget {
  const App({super.key});

    @override
  Widget build(BuildContext context) {

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RentsAuth>(create: (context) => RentsAuth()),
      ],
      child: MaterialApp(
        title: 'Controle de Aluguel',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        // home: LoginPage(),
        routes: {
          Routes.LOGIN: (context) => LoginPage(),
          Routes.CADASTRO: (context) => CadastroPage(),
          Routes.HOME: (context) => HomePage()
        },
      ),
    );
  }

}
