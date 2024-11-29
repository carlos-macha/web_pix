import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_field.dart';
import 'package:flutter_application_1/const.dart';
import 'package:flutter_application_1/screens/adm_user/adm_user_screen.dart';
import 'package:flutter_application_1/screens/normal_user/normal_user_screen.dart';
import 'package:flutter_application_1/screens/password_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  String email = '';
  bool auth = true;
  String password = '';
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  Map<String, dynamic>? userFound;


  Future<void> fetchUserByEmail() async {
    try {
      final snapshot = await _database.child("users").child(email).get();
      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map); // Dados do usuário
        if (data["password"] == password && data["new"] == false) {
          print('ok');
          data["type"] == "adm"
           ? Navigator.pushNamed(context, AdmUserScreen.id, arguments: auth)
           : Navigator.pushNamed(context, NormalUserScreen.id, arguments: {'email': email, 'auth': auth});
          } else if (data["password"] == password && data["new"] == true) {
            Navigator.pushNamed(context, PasswordScreen.id, arguments: {'email': email, 'auth': auth});
          } else {

          };
      }
    } catch (e) {
      print("Erro ao buscar usuário: $e");
    }
  }


void handleEmailChanged(String text) {
    setState(() {
      email = text;
    });
  }

  void handlePasswordChanged(String text) {
    setState(() {
      password = text;
    });
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
                    'Acesse o Sistema',
                    style: TextStyle(
                      color: textcolor,
                      fontSize: 20,
                    ),
                  ),
                  _gap,
                  TextFields(
                    text: 'E-mail',
                    onChanged: handleEmailChanged,
                  ),
                  _gap,
                  TextFields(
                    text: 'Password',
                    onChanged: handlePasswordChanged,
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
                            fetchUserByEmail();
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
