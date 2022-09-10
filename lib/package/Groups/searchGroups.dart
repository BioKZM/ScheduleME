import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchGroups extends StatefulWidget {
  const SearchGroups({Key? key}) : super(key: key);

  @override
  State<SearchGroups> createState() => _SearchGroupsState();
}

class _SearchGroupsState extends State<SearchGroups> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    CollectionReference groupData = _firestore.collection("groups");
    CollectionReference data = _firestore.collection("brews");
    var userData = data.doc('${user!.email}');

    return Scaffold(
        body: Column(
      children: [
        StreamBuilder<QuerySnapshot>(
            stream: groupData.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.active) {
                // List<DocumentSnapshot> doc = snapshot.data.docs;
                List<DocumentSnapshot> doc = snapshot.data.docs;
                // var groups = list['groups'];
                return Column(
                  children: [
                    SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: doc.length,
                          itemBuilder: (context, index) {
                            if (doc.isEmpty) {
                              return Container();
                            } else {
                              if (!(doc[index]['members']
                                  .contains(user!.email))) {
                                return Card(
                                  child: ListTile(
                                    onTap: () async {
                                      var result = await showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text(
                                              "Grup Bilgisi",
                                              style: TextStyle(
                                                  fontFamily: "NotoSansBold",
                                                  color: Colors.red),
                                            ),
                                            content: Text(
                                              "Grup Adı : ${doc[index]['name']}\nGrup Açıklaması : ${doc[index]['description']}\nGrup Kurucusu : ${doc[index]['owner']}\nÜye Sayısı : ${doc[index]['members'].length}/${doc[index]['maximumMemberCount']}",
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text(
                                                  "Kapat",
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontFamily:
                                                          "NotoSansBold"),
                                                ),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'false');
                                                },
                                              ),
                                              TextButton(
                                                child: const Text("Katıl",
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontFamily:
                                                            "NotoSansBold")),
                                                onPressed: () {
                                                  Navigator.pop(
                                                      context, 'true');
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                      if (result == "true") {
                                        if (doc[index]['members'].length !=
                                            doc[index]['maximumMemberCount']) {
                                          var members = doc[index]['members'];
                                          members.add(user!.email);
                                          var _data = await userData.get();
                                          var groups = _data['groups'];
                                          groups.add(doc[index].id);

                                          await userData
                                              .update({'groups': groups});

                                          groupData
                                              .doc(doc[index].id)
                                              .update({'members': members});
                                          await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    "Başarılı",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "NotoSansBold",
                                                        color: Colors.red),
                                                  ),
                                                  content: const Text(
                                                      "Gruba başarıyla katıldın."),
                                                  actions: [
                                                    TextButton(
                                                      child: const Text(
                                                        "Tamam",
                                                        style: TextStyle(
                                                            color: Colors.red,
                                                            fontFamily:
                                                                "NotoSansBold"),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    )
                                                  ],
                                                );
                                              });
                                        }
                                      }
                                    },
                                    title: Text("${doc[index]['name']}"),
                                    subtitle: Text(
                                        "${doc[index]['members'].length}/${doc[index]['maximumMemberCount']}"),
                                  ),
                                );
                              } else {
                                return Container();
                              }
                            }
                          },
                        )),
                  ],
                );
              } else {
                return Container();
              }
            }),
      ],
    ));
  }
}
