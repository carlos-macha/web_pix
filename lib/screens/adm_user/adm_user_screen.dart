import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/const.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_1/screens/adm_user/machine.dart';
import 'package:flutter_application_1/screens/adm_user/user.dart';
import 'package:flutter_application_1/screens/login_screen.dart';

class AdmUserScreen extends StatefulWidget {
  const AdmUserScreen({super.key});
  static const String id = '/adm_user_screen';

  @override
  State<AdmUserScreen> createState() => _AdmUserScreenState();
}

class _AdmUserScreenState extends State<AdmUserScreen> {
  String inputText = '';
  bool auth = false;
  final ScrollController _horizontalController = ScrollController();
  final ScrollController _verticalController = ScrollController();
  final DatabaseReference databaseRef = FirebaseDatabase.instance.ref('users');
  late StreamSubscription _userStream;

  void didChangeDependencies() {
    super.didChangeDependencies();
    auth = ModalRoute.of(context)?.settings.arguments as bool? ?? false;
  }

   void Auth () {
    if (auth == false) {
      Navigator.pushNamed(context, LoginScreen.id);
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
    Auth();
  });
    super.initState();
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
      body: Padding(
        padding: EdgeInsets.all(40),
        child: Scrollbar(
        controller: _horizontalController,
        thumbVisibility: true,
        thickness: 8,
        radius: Radius.circular(10),
        child: SingleChildScrollView(
          controller: _verticalController,
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Box(User()),
              SizedBox(
                height: 30,
              ),
              Box(Machine()),
            ],
          ),
        ),
      ),),
    );
  }

  Widget Box(Widget children) {
    return Center(
      child: Container(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 800, maxHeight: 800),
          child: Container(
            padding: EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: lightcolor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: children,
          ),
        ),
      ),
    );
  }
}
