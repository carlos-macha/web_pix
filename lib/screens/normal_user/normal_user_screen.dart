import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';

class NormalUserScreen extends StatefulWidget {
  const NormalUserScreen({super.key});
  static const String id = '/normal_user_screen';

  @override
  State<NormalUserScreen> createState() => _NormalUserScreenState();
}

class _NormalUserScreenState extends State<NormalUserScreen> {
  @override
  Widget build(BuildContext context) {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Maquinas', style: TextStyle(color: textcolor),),
                      SizedBox(width: 30,),
                      ElevatedButton(onPressed: () {}, child: Text('acessar', style: TextStyle(color: darkcolor),),),
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
}
