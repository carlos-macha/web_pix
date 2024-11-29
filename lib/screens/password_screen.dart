import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_field.dart';
import 'package:flutter_application_1/const.dart';
import 'package:flutter_application_1/screens/login_screen.dart';

class PasswordScreen extends StatefulWidget {
  const PasswordScreen({super.key});
  static const String id = 'reset_password';

  @override
  State<PasswordScreen> createState() => _PasswordScreenState();
}

class _PasswordScreenState extends State<PasswordScreen> {

  String password1 = '';
  String password2 = '';
  String email = '';
  bool auth = false;
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('users');

@override
void didChangeDependencies() {
  super.didChangeDependencies();
  // Verifique se o argumento é um Map
  final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
  if (arguments != null) {
    email = arguments['email'] as String? ?? '';
    auth = arguments['auth'] as bool? ?? false;
  }
  print('Email do usuário: $email');
}

  void Auth () {
    if (auth == false) {
      Navigator.pushNamed(context, LoginScreen.id);
    }
  }
  
  @override
  void initState() {
     WidgetsBinding.instance.addPostFrameCallback((_) {
    Auth();
  });
    super.initState();
  }

  void handlePassword1Changed(String text) {
    setState(() {
      password1 = text;
    });
  }

  void handlePassword2Changed(String text) {
    setState(() {
      password2 = text;
    });
  }

  Future<void> ResetPassword () async {
    if (password1 == password2 && password2.length >= 4) {
      try {
      await _databaseRef.child(email).update({
        'password': password2,
        'new': false
      });
    } catch (e) {
      print(e);
    }
    Navigator.pushNamed(context, LoginScreen.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget _gap = SizedBox(
      height: 30,
    );
    return Scaffold(
      backgroundColor: darkcolor,
      body: Center(
        child: Container(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 400),
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: lightcolor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Resetar Senha',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 20,
                    ),
                  ),
                  _gap,
                  TextFields(
                    text: 'Password',
                    onChanged: handlePassword1Changed,
                  ),
                  _gap,
                  TextFields(
                    text: 'Password',
                    onChanged: handlePassword2Changed,
                  ),
                  _gap,
                  Container(
                    width: double.infinity,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: 50,
                      ),
                      child: SizedBox(
                        child: ElevatedButton(
                          onPressed: () {
                            ResetPassword();
                          },
                          child: Text(
                            'Login',
                            style: stylebutton,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
