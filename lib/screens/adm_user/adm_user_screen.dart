import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_field.dart';
import 'package:flutter_application_1/const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/screens/adm_user/machine_table.dart';
import 'package:flutter_application_1/screens/adm_user/user_table.dart';

class AdmUserScreen extends StatefulWidget {
  const AdmUserScreen({super.key});
  static const String id = '/adm_user_screen';

  @override
  State<AdmUserScreen> createState() => _AdmUserScreenState();
}

class _AdmUserScreenState extends State<AdmUserScreen> {
  String inputText = '';
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('users');
  late StreamSubscription _userStream;

  void handleTextChanged(String text) {
    setState(() {
      inputText = text;
    });
  }

  @override
  void dispose() {
    // Cancelando o stream no dispose para evitar chamadas após o widget ser removido
    _userStream.cancel();
    _horizontalController.dispose();
    _verticalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkcolor,
      body: Center(
        child: Container(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 400, maxHeight: 200),
            child: Container(
              padding: EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: lightcolor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Controle de Usuário',
                        style: TextStyle(color: textcolor),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showModal(context, 'Controle de Usuário',
                              _modalUser('E-mail'));
                        },
                        child: Text(
                          'acessar',
                          style: TextStyle(color: darkcolor),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Controle de Máquina',
                        style: TextStyle(color: textcolor),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showModal(
                              context, 'Controle de Máquina', _modalMachine());
                        },
                        child: Text(
                          'acessar',
                          style: TextStyle(color: darkcolor),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> save() async {
    Map<String, dynamic> userData = {
      'new': true,
      'password': '12345678',
      'type': 'normal',
    };
    try {
      await databaseRef.child(inputText).set(userData);
    } catch (e) {
      print(e);
    };
  }

  Widget _modalUser(
    String textFieldText,
  ) {
    Widget _gap = SizedBox(
      height: 30,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFields(
          text: textFieldText,
          onChanged: handleTextChanged,
        ),
        _gap,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                save();
              },
              child: Text(
                'salvar',
                style: stylebutton,
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        _gap,
        Divider(),
        Container(
          height: 150,
          child: Scrollbar(
            controller: _horizontalController,
            thumbVisibility: true,
            thickness: 8,
            radius: Radius.circular(10),
            child: SingleChildScrollView(
              controller: _horizontalController,
              scrollDirection: Axis.horizontal,
              child: Scrollbar(
                controller: _verticalController,
                thumbVisibility: true,
                thickness: 8,
                radius: Radius.circular(10),
                child: SingleChildScrollView(
                  controller: _verticalController,
                  scrollDirection: Axis.vertical,
                  child: UserTable(),
                ),
              ),
            ),
          ),
        ),
        Divider(),
        _gap,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Fechar',
                style: stylebutton,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _modalMachine() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 150,
          child: MachineTable(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Fechar',
                style: stylebutton,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _showModal(BuildContext context, String title, Widget childs) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, setState) {
            return AlertDialog(
              backgroundColor: lightcolor,
              title: Center(
                child: Text(
                  title,
                  style: TextStyle(color: Color(0xFFE0E0E0)),
                ),
              ),
              content: ConstrainedBox(
                constraints: BoxConstraints(
                  maxWidth: 900,
                ),
                child: SingleChildScrollView(
                  child: Container(
                    child: childs,
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
