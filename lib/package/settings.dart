import 'package:flutter/material.dart';

class Settings_ extends StatefulWidget {
  const Settings_({Key? key}) : super(key: key);

  @override
  State<Settings_> createState() => _Settings_State();
}

class _Settings_State extends State<Settings_> {
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
