import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';
import 'package:flutter_application_1/screens/adm_user/user_table.dart';

class User extends StatefulWidget {
  const User({super.key});

  @override
  State<User> createState() => _UserState();
}

class _UserState extends State<User> {
  Widget _gap = SizedBox(
    height: 30,
  );
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  final TextEditingController _textController = TextEditingController();
  String textEmail = '';
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('users');

  Future<void> save() async {
    Map<String, dynamic> userData = {
      'new': true,
      'password': '12345678',
      'type': 'normal',
    };
    try {
      if (textEmail.length >= 4) {
        await databaseRef.child(textEmail).set(userData);
      }
      _textController.clear();
    } catch (e) {
      print(e);
      _textController.clear();
    };
    _textController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Controle de user', style: TextStyle(color: textcolor, fontSize: 25, fontWeight: FontWeight.bold),),
        SizedBox(
          height: 10,
        ),
        TextField(
          controller: _textController,
          onChanged: (text) {
            setState(
              () {
                textEmail = text;
              },
            );
          },
          maxLines: 1,
          minLines: 1,
          scrollController: ScrollController(),
          style: TextStyle(
            color: Color(0xFFE0E0E0),
          ),
          cursorColor: Color(0xFFE0E0E0),
          decoration: InputDecoration(
            labelText: 'E-mail',
            labelStyle: TextStyle(
              color: Color.fromARGB(113, 224, 224, 224),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                  color: Color(0xFFE0E0E0),
                  width: 2), // Cor da linha quando em foco
            ),
          ),
        ),
        _gap,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                ElevatedButton(
              onPressed: () {
                _textController.clear();
              },
              child: Text(
                'cancelar',
                style: stylebutton,
              ),
            ),
            SizedBox(width: 5,),
            ElevatedButton(
              onPressed: () {
                save();
              },
              child: Text(
                'salvar',
                style: stylebutton,
              ),
            ),
              ],
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
      ],
    );
  }
}
