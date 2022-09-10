import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowPlans extends StatefulWidget {
  const ShowPlans({Key? key}) : super(key: key);

  @override
  State<ShowPlans> createState() => _ShowPlansState();
}

class _ShowPlansState extends State<ShowPlans> {
  var dayList = [
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday",
    "Saturday",
    "Sunday"
  ];
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference data = _firestore.collection('brews');
    var userData = data.doc('${user!.email}');
    return Scaffold(
        body: Center(
      child: StreamBuilder<DocumentSnapshot>(
          stream: userData.snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData &&
                snapshot.connectionState == ConnectionState.active) {
              var list = snapshot.data.data();
              var plans = list['plans'];
              return Column(
                children: [
                  SizedBox(
                    height: 600,
                    child: ListView.builder(
                      itemCount: plans.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          onTap: () async {
                            Navigator.pushNamed(
                                context, "/days${dayList[index]}");
                          },
                          title: Text(plans[index]["dayName"]),
                          // subtitle: plans[index],
                        ));
                      },
                    ),
                  )
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          }),
    ));
  }
}
