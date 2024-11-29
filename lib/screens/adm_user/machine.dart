import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';
import 'package:flutter_application_1/screens/adm_user/machine_table.dart';

class Machine extends StatefulWidget {
  const Machine({super.key});

  @override
  State<Machine> createState() => _MachineState();
}

class _MachineState extends State<Machine> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Controle de Máquina', style: TextStyle(color: textcolor, fontSize: 25, fontWeight: FontWeight.bold),),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 150,
          child: MachineTable(),
        ),
      ],
    );
  }
}
