import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_field.dart';
import 'package:flutter_application_1/const.dart';
import 'package:flutter_application_1/screens/adm_user/adm_user_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const String id = '/';

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
                      color: Color(0xFFE0E0E0),
                      fontSize: 20,
                    ),
                  ),
                  _gap,
                  TextFields(
                    text: 'E-mail',
                  ),
                  _gap,
                  TextFields(
                    text: 'Password',
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
                            Navigator.pushNamed(context, AdmUserScreen.id);
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
