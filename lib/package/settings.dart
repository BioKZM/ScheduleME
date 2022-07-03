import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Row(
      children: <Widget>[
        const Text("Settings"),
        ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/login");
            },
            child: const Text("Çıkış Yap"))
      ],
    ));
  }
}
