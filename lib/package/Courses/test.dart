import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Test extends StatefulWidget {
  const Test({Key? key}) : super(key: key);

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final firebase = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    CollectionReference test = firebase.collection('brews');
    var data = test.doc('Test');
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("Test"),
          onPressed: () async {
            var response = await data.get();
            print(response.data());
          },
        ),
      ),
    );
  }
}
