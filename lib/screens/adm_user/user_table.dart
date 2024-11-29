import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';

class UserTable extends StatefulWidget {
  const UserTable({super.key});

  @override
  State<UserTable> createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('users');
  List<Map<String, dynamic>> _users = [];
  late StreamSubscription _userStream;

  @override
  void initState() {
    super.initState();
    // Inicialização do stream
    _userStream = _databaseRef.onValue.listen((event) {
      if (mounted) {
        setState(() {
          _fetchUsers(event);
        });
      }
    });
  }

  @override
  void dispose() {
    // Cancelando o stream no dispose para evitar chamadas após o widget ser removido
    _userStream.cancel();
    super.dispose();
  }

  void _fetchUsers(DatabaseEvent event) {
    final data = event.snapshot.value as Map<dynamic, dynamic>?;

    if (data != null) {
      setState(() {
        _users = data.entries.map((entry) {
          final key = entry.key as String;
          final value = Map<String, dynamic>.from(entry.value as Map);
          return {'id': key, ...value};
        }).toList();
      });
    }
  }

  void _showModal(String text, dynamic onPress) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (context, setState) {
              return AlertDialog(
                backgroundColor: lightcolor,
                title: Center(
                  child: Text(
                    'Redefinir senha',
                    style: TextStyle(color: textcolor),
                  ),
                ),
                content: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: 200,
                  ),
                  child: Container(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          text,
                          style: TextStyle(color: textcolor),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            ElevatedButton(
                              onPressed: onPress,
                              child: Text(
                                'Sim',
                                style: stylebutton,
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Não',
                                style: stylebutton,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }

  Future<void> ResetPassword(String email) async {
    try {
      await _databaseRef.child(email).update({
        'password': '12345678',
        'new': true
      });
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  Future<void> ResetType(String email, String userType) async {
    try {
      if (userType == 'adm') {
        await _databaseRef.child(email).update({
          'type': 'normal',
        });
      } else {
        await _databaseRef.child(email).update({
          'type': 'adm',
        });
      }
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  Future<void> Delete(String email) async {
    try {
      await _databaseRef.child(email).remove();
    } catch (e) {
      print(e);
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return DataTable(
      columns: const [
        DataColumn(
            label: Text(
          'Nome',
          style: styleText,
        )),
        DataColumn(
            label: Text(
          'Tipo',
          style: styleText,
        )),
        DataColumn(
            label: Text(
          'Redefinir tipo',
          style: styleText,
        )),
        DataColumn(
            label: Text(
          'Redefinir senha',
          style: styleText,
        )),
        DataColumn(
            label: Text(
          'Excluir',
          style: styleText,
        )),
      ],
      rows: _users.map(
        (user) {
          return DataRow(
            cells: [
              DataCell(Text(
                user['id'],
                style: styleText,
              )),
              DataCell(Text(
                user['type'],
                style: styleText,
              )),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    _showModal(
                        'Você gostaria de redefinir o tipo do usuário ${user['id']} para ${user['type'] == 'adm' ? 'normal' : 'adm'}',
                        () {
                      ResetType(user['id'], user['type']);
                    });
                  },
                  child: Text(
                    'Tipo',
                    style: TextStyle(color: darkcolor),
                  ),
                ),
              ),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    _showModal(
                        'Você gostaria de redefinir a senha do usuário ${user['id']}?',
                        () {
                      ResetPassword(user['id']);
                    });
                  },
                  child: Text(
                    'Senha',
                    style: TextStyle(color: darkcolor),
                  ),
                ),
              ),
              DataCell(
                ElevatedButton(
                  onPressed: () {
                    _showModal(
                      'Você gostaria de Excluir o usuário ${user['id']}?',
                      () {
                        Delete(user['id']);
                      },
                    );
                  },
                  child: Text(
                    'Excluir',
                    style: TextStyle(color: darkcolor),
                  ),
                ),
              ),
            ],
          );
        },
      ).toList(),
    );
  }
}
