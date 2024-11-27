import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/adm_user/adm_user_screen.dart';
import 'package:flutter_application_1/screens/login_screen.dart';
import 'package:flutter_application_1/screens/normal_user/normal_user_screen.dart';

Future<void> main() async {
  // Garante que os widgets Flutter sejam inicializados antes de qualquer operação assíncrona
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o Firebase com as configurações específicas para a plataforma
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,  // Usa as opções geradas no firebase_options.dart
  );
  runApp(WebPix());
}

class WebPix extends StatelessWidget {
  const WebPix({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        scrollbarTheme: ScrollbarThemeData(
          thumbColor: WidgetStateProperty.all(textcolor), 
        ),
      ),
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => LoginScreen(),
        AdmUserScreen.id: (context) => AdmUserScreen(),
        NormalUserScreen.id: (context) => NormalUserScreen(),
      },
    );
  }
}
