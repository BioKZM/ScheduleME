import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Settings_ extends StatefulWidget {
  const Settings_({Key? key}) : super(key: key);

  @override
  State<Settings_> createState() => _Settings_State();
}

class _Settings_State extends State<Settings_> {
  final nameInput = TextEditingController();
  final classInput = TextEditingController();
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var nameVariable = "";
  bool nameSwap = false;
  bool classSwap = false;

  @override
  Widget build(BuildContext context) {
    DocumentReference<Object?> userData;
    CollectionReference data = _firestore.collection('brews');
    userData = data.doc('${user!.email}');

    Widget nameBox = Container();
    Widget nameEditIcon = Container();
    Widget classBox = Container();
    Widget classEditIcon = Container();

    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: userData.snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.active) {
            var list = snapshot.data.data();
            var name = list['name'];
            var class_ = list['class'];

            if (nameSwap == true) {
              nameBox = Column(
                children: [
                  SizedBox(
                      width: 250,
                      height: 40,
                      child: TextFormField(
                        controller: nameInput,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: nameVariable,
                        ),
                      )),
                ],
              );
              classBox = Column(
                children: [
                  Container(
                    height: 40,
                    width: 250,
                    color: Colors.grey,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        class_,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );

              nameEditIcon = Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          userData.update({'name': nameInput.text});
                          nameSwap = !nameSwap;
                        },
                      );
                    },
                    icon: Icon(Icons.check),
                  ),
                ],
              );
            } else if (classSwap == true) {
              nameBox = Column(
                children: [
                  Container(
                    height: 40,
                    width: 250,
                    color: Colors.grey,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
              classBox = Column(
                children: [
                  SizedBox(
                      width: 250,
                      height: 40,
                      child: TextFormField(
                        controller: classInput,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: nameVariable,
                        ),
                      )),
                ],
              );
              classEditIcon = Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          userData.update({'class': classInput.text});
                          classSwap = !classSwap;
                        },
                      );
                    },
                    icon: Icon(Icons.check),
                  ),
                ],
              );
            } else {
              nameBox = Column(
                children: [
                  Container(
                    height: 40,
                    width: 250,
                    color: Colors.grey,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        name,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              );
              classBox = Column(
                children: [
                  Container(
                    height: 40,
                    width: 250,
                    color: Colors.grey,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        class_,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              );
              nameEditIcon = Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          nameSwap = !nameSwap;
                        },
                      );
                    },
                    icon: Icon(Icons.mode_edit_outlined),
                  ),
                ],
              );
              classEditIcon = Column(
                children: [
                  IconButton(
                    onPressed: () {
                      setState(
                        () {
                          classSwap = !classSwap;
                        },
                      );
                    },
                    icon: Icon(Icons.mode_edit_outlined),
                  ),
                ],
              );
            }

            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 100),
                    ),
                    Row(
                      children: [
                        Stack(
                          children: [
                            const CircleAvatar(
                              backgroundImage:
                                  AssetImage("assets/placeholder.jpg"),
                              radius: 40,
                            ),
                            Positioned(
                              left: 40,
                              bottom: 45,
                              child: IconButton(
                                onPressed: () {},
                                icon: const Icon(Icons.camera_alt, size: 23),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          height: 40,
                          width: 250,
                        ),
                      ],
                    ),
                    Row(
                      children: [nameBox, nameEditIcon],
                    ),
                    Row(
                      children: [classBox, classEditIcon],
                    ),
                    Row(
                      children: const [
                        SizedBox(
                          height: 10,
                          width: 250,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
