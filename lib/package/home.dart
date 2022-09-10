import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:scheduleme/main.dart';

import '../services/auth.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}

// getData() async {
//   User? user = await FirebaseAuth.instance.currentUser;
//   return user!.email;
// }

class _HomeState extends State<Home> {
  final _firestore = FirebaseFirestore.instance;
  final AuthService _auth = AuthService();
  User? user = FirebaseAuth.instance.currentUser;
  @override
  void initState() {
    getUser();
    super.initState();
  }

  void getUser() async {
    user = FirebaseAuth.instance.currentUser;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    CollectionReference data = _firestore.collection('brews');
    CollectionReference groupData = _firestore.collection('groups');
    double screenWidth = MediaQuery.of(context).size.width;
    var userData = data.doc("${user!.email}");
    return StreamBuilder<DocumentSnapshot>(
      stream: userData.snapshots(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData &&
            snapshot.connectionState == ConnectionState.active) {
          var list = snapshot.data.data();
          var courses = list['courses'];
          List<Widget> greenWidget = <Widget>[];
          List<Widget> yellowWidget = <Widget>[];
          List<Widget> redWidget = <Widget>[];

          for (int x = 0; x < courses.length; x++) {
            if (int.parse(courses[x]['abs']) < int.parse(courses[x]['max'])) {
              greenWidget.add(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("${courses[x]['courseCode']}")]));
            } else if (int.parse(courses[x]['abs']) ==
                int.parse(courses[x]['max'])) {
              yellowWidget.add(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("${courses[x]['courseCode']}")]));
            } else {
              redWidget.add(Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("${courses[x]['courseCode']}")]));
            }
          }
          // print(courses);
          var name = list['name'];
          var class_ = list['class'];
          return Scaffold(
            backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        _auth.signOut();
                        Navigator.pushNamed(
                          context,
                          "/login",
                        );
                      },
                      icon: const Icon(Icons.exit_to_app_rounded),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        Row(
                          children: const <Widget>[
                            CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/placeholder.jpg"),
                              radius: 40,
                            )
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Row(
                                  children: const [
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      name,
                                      style: const TextStyle(
                                        fontFamily: "ArabatoMedium",
                                        fontSize: 22.0,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Text(
                                      class_,
                                      style: const TextStyle(
                                        fontFamily: "ArabatoNormal",
                                        fontSize: 16.0,
                                      ),
                                    )
                                  ],
                                ),
                                Row(
                                  children: const [
                                    SizedBox(
                                      height: 15,
                                    )
                                  ],
                                ),
                                Container(
                                  width: screenWidth,
                                  height: 10,
                                  color: Colors.grey.withOpacity(0.1),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                const Text(
                                  "Devamsızlıklar",
                                  style: TextStyle(
                                    fontFamily: "ArabatoMedium",
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                        height: 200,
                                        width: 100,
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(4),
                                                )),
                                            color: Colors.red.withOpacity(0.1),
                                            elevation: 0,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: const [
                                                    SizedBox(
                                                      height: 6,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const <Widget>[
                                                    Icon(
                                                      Icons
                                                          .indeterminate_check_box_rounded,
                                                      color: Colors.red,
                                                    )
                                                  ],
                                                ),
                                                Column(children: redWidget),
                                              ],
                                            ))),
                                    SizedBox(
                                        height: 200,
                                        width: 100,
                                        child: Card(
                                            color:
                                                Colors.amber.withOpacity(0.1),
                                            elevation: 0,
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(4))),
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: const [
                                                    SizedBox(
                                                      height: 6,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.warning_rounded,
                                                      color: Colors.amber[700],
                                                    )
                                                  ],
                                                ),
                                                Column(children: yellowWidget),
                                              ],
                                            ))),
                                    SizedBox(
                                        height: 200,
                                        width: 100,
                                        child: Card(
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                  color: Colors.grey
                                                      .withOpacity(0.4),
                                                ),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                  Radius.circular(4),
                                                )),
                                            color:
                                                Colors.green.withOpacity(0.1),
                                            elevation: 0,
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                  children: const [
                                                    SizedBox(
                                                      height: 6,
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const <Widget>[
                                                    Icon(
                                                      Icons.add_box_rounded,
                                                      color: Colors.green,
                                                    )
                                                  ],
                                                ),
                                                Column(children: greenWidget),
                                              ],
                                            )))
                                  ],
                                ),
                                const SizedBox(
                                  width: 0,
                                  height: 15,
                                ),
                                Container(
                                  color: Colors.grey.withOpacity(0.1),
                                  width: screenWidth,
                                  height: 10,
                                ),
                                const Text(
                                  "Gruplar",
                                  style: TextStyle(
                                    fontFamily: "ArabatoMedium",
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: <Widget>[
                                    SizedBox(
                                      width: 200,
                                      height: 150,
                                      child: Card(
                                        color: Colors.blue.withOpacity(0.15),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                        ),
                                        elevation: 0,
                                        child: Column(
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const <Widget>[
                                                Text("Aktif Gruplar"),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 7,
                                            ),
                                            Row(
                                              children: [
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                StreamBuilder<QuerySnapshot>(
                                                  stream: groupData.snapshots(),
                                                  builder: (BuildContext
                                                          context,
                                                      AsyncSnapshot snapshot) {
                                                    if (snapshot.hasData &&
                                                        snapshot.connectionState ==
                                                            ConnectionState
                                                                .active) {
                                                      List<DocumentSnapshot>
                                                          doc =
                                                          snapshot.data.docs;

                                                      var textWidget =
                                                          <Widget>[];
                                                      for (int i = 0;
                                                          i < doc.length;
                                                          i++) {
                                                        if (doc[i]['members']
                                                            .contains(
                                                                user!.email)) {
                                                          textWidget.add(Text(
                                                            doc[i]['name'],
                                                            style:
                                                                const TextStyle(
                                                                    fontSize:
                                                                        12),
                                                          ));
                                                        }
                                                      }
                                                      return Column(
                                                        children: textWidget,
                                                      );
                                                    } else {
                                                      return Container();
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      height: 150,
                                      child: Card(
                                        color: Colors.purple.withOpacity(0.1),
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Colors.grey.withOpacity(0.4),
                                          ),
                                          borderRadius: const BorderRadius.all(
                                            Radius.circular(4),
                                          ),
                                        ),
                                        elevation: 0,
                                        child: Column(
                                          children: <Widget>[
                                            const SizedBox(
                                              height: 5,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: const <Widget>[
                                                Text("Aktif Dersler"),
                                              ],
                                            ),
                                            Row(
                                              children: <Widget>[
                                                const SizedBox(
                                                  width: 15,
                                                ),
                                                Text("${courses.length}"),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          );
        } else {
          return Center(
              child: SpinKitWave(
            color: Colors.red,
          ));
        }
      },
    );
  }
}
