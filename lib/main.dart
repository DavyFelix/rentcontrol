import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_package/auth_package.dart';
import 'package:rentcontrol/pages/cadastro_page.dart';
import 'package:rentcontrol/pages/home_page.dart';
import 'package:rentcontrol/pages/login_page.dart';
import 'package:rentcontrol/routers/routers.dart';

void main() {
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RentsAuth>(create: (_) => RentsAuth()),
      ],
      child: MaterialApp(
        title: 'Controle de Aluguel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.blue,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
            brightness: Brightness.light,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            prefixIconColor: Colors.blue,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        initialRoute: Routes.LOGIN,
        routes: {
          Routes.LOGIN: (_) => LoginPage(),
          Routes.CADASTRO: (_) => CadastroPage(),
          Routes.HOME: (_) => HomePage(),
        },
      ),
    );
  }
}
