import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';

class NormalUserScreen extends StatefulWidget {
  const NormalUserScreen({super.key});
  static const String id = '/normal_user_screen';

  @override
  State<NormalUserScreen> createState() => _NormalUserScreenState();
}

class _NormalUserScreenState extends State<NormalUserScreen> {
  String email = '';
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _machines = [];
  final DatabaseReference _databaseMachineRef =
      FirebaseDatabase.instance.ref('machines');
  final DatabaseReference _databaseRef = FirebaseDatabase.instance.ref('users');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Obtém o e-mail passado via argumentos da rota.
    email = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    print('Email do usuário: $email');
  }

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
        });
      }
    });
  }

  void _showModal(BuildContext context, String title, Widget child) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: lightcolor,
          title: Center(
            child: Text(
              title,
              style: TextStyle(color: Color(0xFFE0E0E0)),
            ),
          ),
          content: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: SingleChildScrollView(child: child),
          ),
        );
      },
    );
  }

  Widget machineReport(String machineId) {
    final machine = _machines.firstWhere((m) => m['id'] == machineId,
        orElse: () => {'payments': {}});

    final payments = machine['payments'] as Map<dynamic, dynamic>? ?? {};
    final paymentsList = payments.values.toList();

    return DataTable(
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
      rows: paymentsList.map<DataRow>((payment) {
        final paymentData = payment as Map<dynamic, dynamic>;
        return DataRow(
          cells: [
            DataCell(
              Text(
                DateTime.fromMillisecondsSinceEpoch(paymentData['date'])
                    .toString(),
                style: styleText,
              ),
            ),
            DataCell(
              Text(
                paymentData['pay_type'],
                style: styleText,
              ),
            ),
            DataCell(
              Text(
                paymentData['value'],
                style: styleText,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkcolor,
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: lightcolor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: SingleChildScrollView(
            controller: ScrollController(),
            child: DataTable(
              columns: [
                DataColumn(
                  label: Text(
                    'Máquinas',
                    style: TextStyle(color: textcolor),
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Ações',
                    style: TextStyle(color: textcolor),
                  ),
                ),
              ],
              rows: _machines.map((machine) {
                return DataRow(
                  cells: [
                    DataCell(
                      Text(
                        machine['id'],
                        style: styleText,
                      ),
                    ),
                    DataCell(
                      ElevatedButton(
                        onPressed: () {
                          _showModal(
                            context,
                            'Informação de máquina',
                            machineReport(machine['id']),
                          );
                        },
                        child: Text(
                          'Relatório',
                          style: stylebutton,
                        ),
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
