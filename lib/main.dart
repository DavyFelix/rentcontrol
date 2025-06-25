import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:auth_package/auth_package.dart';
import 'package:rentcontrol/pages/cadastro_page.dart';
import 'package:rentcontrol/pages/home_page.dart';
import 'package:rentcontrol/pages/login_page.dart';
import 'package:rentcontrol/pages/sobre_page.dart';
import 'package:rentcontrol/providers/casa_provider.dart';
import 'package:rentcontrol/providers/contas_provider.dart';
import 'package:rentcontrol/routers/routers.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<RentsAuth>(create: (_) => RentsAuth()),
        ChangeNotifierProvider(create: (_) => ContasProvider()),
        ChangeNotifierProvider(create: (_) => CasaProvider()),
      ],
      child: MaterialApp(
        title: 'Controle de Aluguel',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.brown,
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 155, 133, 155),
            brightness: Brightness.light,
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 155, 133, 155),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            prefixIconColor: const Color.fromARGB(255, 155, 133, 155),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.brown),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        routes: {
          Routes.LOGIN: (_) => LoginPage(),
          Routes.CADASTRO: (_) => CadastroPage(),
          Routes.HOME: (_) => HomePage(),
          Routes.SOBRE: (_) => SobrePage(),
        },
      ),
    );
  }
}
