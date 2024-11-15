import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/text_field.dart';
import 'package:flutter_application_1/const.dart';

class AdmUserScreen extends StatefulWidget {
  const AdmUserScreen({super.key});
  static const String id = '/adm_user_screen';

  @override
  State<AdmUserScreen> createState() => _AdmUserScreenState();
}

class _AdmUserScreenState extends State<AdmUserScreen> {
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
                        'Controle de Usuario',
                        style: TextStyle(color: textcolor),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showModal(context, 'Controle de Usuario',
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
                        'Controle de Maquina',
                        style: TextStyle(color: textcolor),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          _showModal(context, 'Controle de Maquina',
                              _modalMachine());
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

  Widget _modalUser(
    String textFieldText,
  ) {
    Widget _gap = SizedBox(height: 30,);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFields(
          text: textFieldText,
        ),
        _gap,
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ElevatedButton(onPressed: () {}, child: Text('salvar', style: stylebutton,),),
            SizedBox(width: 10,),
            ElevatedButton(onPressed: () {}, child: Text('cancelar', style: stylebutton,),),
          ],
        ),
        _gap,
        Divider(),
        _gap,
        
      ],
    );
  }

  Widget _modalMachine(
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
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
                  maxWidth: 400,
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
