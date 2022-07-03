import 'package:flutter/material.dart';

class Absenteeism extends StatefulWidget {
  const Absenteeism({Key? key}) : super(key: key);

  @override
  State<Absenteeism> createState() => _AbsenteeismState();
}

class _AbsenteeismState extends State<Absenteeism> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: <Widget>[
        const Text("Absenteeism"),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            child: const Text("Çıkış Yap"))
      ],
    ));
  }
}
