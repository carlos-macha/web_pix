import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';

class MachineTable extends StatefulWidget {
  const MachineTable({super.key});

  @override
  State<MachineTable> createState() => _MachineTableState();
}

class _MachineTableState extends State<MachineTable> {
  final DatabaseReference _databaseMachineRef =
      FirebaseDatabase.instance.ref('machines');
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  List<Map<String, dynamic>> _machines = [];
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('users');
  List<Map<String, dynamic>> _users = [];

  @override
  void initState() {
    _fetchMachines();
    _fetchUsers();
    super.initState();
  }

  void _fetchUsers() {
    _databaseRef.onValue.listen((event) {
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
    });
  }

  void _fetchMachines() {
    _databaseMachineRef.onValue.listen((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>?;

      if (data != null) {
        setState(() {
          _machines = data.entries.map((entry) {
            final key = entry.key as String;
            final value = Map<String, dynamic>.from(entry.value as Map);
            return {'id': key, ...value};
          }).toList();
          print(_machines);
        });
      }
    });
  }

  Widget selectUsers(String machineId) {
    return Scrollbar(
      controller: _horizontalController,
      thumbVisibility: true,
      thickness: 8,
      radius: Radius.circular(10),
      child: SingleChildScrollView(
        controller: _verticalController,
        scrollDirection: Axis.vertical,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'Usuários',
                style: TextStyle(color: textcolor),
              ),
            ),
            DataColumn(
              label: Text(
                'Vinculação',
                style: TextStyle(color: textcolor),
              ),
            ),
          ],
          rows: _users.map<DataRow>(
            (users) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      users['id'],
                      style: styleText,
                    ),
                  ),
                  DataCell(
                    ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Gerar',
                        style: stylebutton,
                      ),
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  Widget machineReport(String machineId) {
    final machine = _machines.firstWhere(
      (m) => m['id'] == machineId,
    );

    final payments = machine['payments'];
    final paymentsList = (payments as Map).values.toList();

    return Scrollbar(
      controller: _horizontalController,
      thumbVisibility: true,
      thickness: 8,
      radius: Radius.circular(10),
      child: SingleChildScrollView(
        controller: _verticalController,
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text(
                'Data',
                style: TextStyle(color: textcolor),
              ),
            ),
            DataColumn(
              label: Text(
                'Tipo de pagamento',
                style: TextStyle(color: textcolor),
              ),
            ),
            DataColumn(
              label: Text(
                'Valor',
                style: TextStyle(color: textcolor),
              ),
            ),
          ],
          rows: paymentsList.map<DataRow>(
            (payment) {
              return DataRow(
                cells: [
                  DataCell(
                    Text(
                      DateTime.fromMillisecondsSinceEpoch(payment['date'])
                          .toString(),
                      style: styleText,
                    ),
                  ),
                  DataCell(
                    Text(
                      payment['pay_type'],
                      style: styleText,
                    ),
                  ),
                  DataCell(
                    Text(
                      payment['value'],
                      style: styleText,
                    ),
                  ),
                ],
              );
            },
          ).toList(),
        ),
      ),
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

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
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
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Maquina',
                    style: TextStyle(color: textcolor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'última atualização',
                    style: TextStyle(color: textcolor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Gerar',
                    style: TextStyle(color: textcolor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Usuários',
                    style: TextStyle(color: textcolor),
                  ),
                ),
              ],
              rows: _machines.map(
                (machine) {
                  return DataRow(
                    cells: [
                      DataCell(
                        Text(
                          machine['id'],
                          style: styleText,
                        ),
                      ),
                      DataCell(
                        Text(
                          DateTime.fromMillisecondsSinceEpoch(
                                  machine['lastUpdate'])
                              .toString(),
                          style: styleText,
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            _showModal(
                              context,
                              'Informação de máquina',
                              machineReport(
                                machine['id'],
                              ),
                            );
                          },
                          child: Text(
                            'Gerar',
                            style: stylebutton,
                          ),
                        ),
                      ),
                      DataCell(
                        ElevatedButton(
                          onPressed: () {
                            _showModal(
                              context,
                              'Vincular Usuário',
                              selectUsers(
                                machine['id'],
                              ),
                            );
                          },
                          child: Text(
                            'Usuários',
                            style: stylebutton,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
