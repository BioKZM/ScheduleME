import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ShowGroups extends StatefulWidget {
  const ShowGroups({Key? key}) : super(key: key);

  @override
  State<ShowGroups> createState() => _ShowGroupsState();
}

class _ShowGroupsState extends State<ShowGroups> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final groupNameInput = TextEditingController();
  final groupDescriptionInput = TextEditingController();
  final maxUserInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference groupData = _firestore.collection("groups");
    CollectionReference data = _firestore.collection("brews");
    var userData = data.doc('${user!.email}');

    return Scaffold(
        body: Column(
      children: [
        StreamBuilder<DocumentSnapshot>(
            stream: userData.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.active) {
                // List<DocumentSnapshot> doc = snapshot.data.docs;
                var list = snapshot.data.data();
                var groups = list['groups'];
                return Column(
                  children: [
                    SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: groups.length,
                          itemBuilder: (context, index) {
                            if (groups.length == 0) {
                              return Container();
                            } else {
                              return Column(
                                children: [
                                  StreamBuilder<QuerySnapshot>(
                                    stream: groupData.snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.connectionState ==
                                              ConnectionState.active) {
                                        List<DocumentSnapshot> doc =
                                            snapshot.data.docs;
                                        if (user!.email ==
                                            doc[index]['owner']) {
                                          return Card(
                                            child: ListTile(
                                              title:
                                                  Text("${doc[index]['name']}"),
                                              subtitle: Text(
                                                  "${doc[index]['members'].length}/${doc[index]['maximumMemberCount']}\n${doc[index]['description']}"),
                                              trailing: IconButton(
                                                  icon:
                                                      const Icon(Icons.delete),
                                                  onPressed: () async {
                                                    var result =
                                                        await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  "Uyarı",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "NotoSansBold"),
                                                                ),
                                                                content: const Text(
                                                                    "Grubu silmek istediğine emin misin?"),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            'false');
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Hayır",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "NotoSansBold",
                                                                            color:
                                                                                Colors.red),
                                                                      )),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          'true');
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Evet",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "NotoSansBold",
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                    if (result == 'true') {
                                                      var data = groups[index];
                                                      groups.remove(data);
                                                      await userData.update(
                                                          {'groups': groups});
                                                      groupData
                                                          .doc(data)
                                                          .delete();
                                                    }
                                                  }),
                                            ),
                                          );
                                        } else {
                                          return Card(
                                            child: ListTile(
                                                title: Text(
                                                    "${doc[index]['name']}"),
                                                subtitle: Text(
                                                    "${doc[index]['members'].length}/${doc[index]['maximumMemberCount']}\n${doc[index]['description']}"),
                                                trailing: IconButton(
                                                  icon: const Icon(Icons
                                                      .exit_to_app_rounded),
                                                  onPressed: () async {
                                                    var result =
                                                        await showDialog(
                                                            context: context,
                                                            builder:
                                                                (BuildContext
                                                                    context) {
                                                              return AlertDialog(
                                                                title:
                                                                    const Text(
                                                                  "Uyarı",
                                                                  style: TextStyle(
                                                                      fontFamily:
                                                                          "NotoSansBold"),
                                                                ),
                                                                content: const Text(
                                                                    "Gruptan ayrılmak istediğine emin misin?"),
                                                                actions: [
                                                                  TextButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.pop(
                                                                            context,
                                                                            'false');
                                                                      },
                                                                      child:
                                                                          const Text(
                                                                        "Hayır",
                                                                        style: TextStyle(
                                                                            fontFamily:
                                                                                "NotoSansBold",
                                                                            color:
                                                                                Colors.red),
                                                                      )),
                                                                  TextButton(
                                                                    onPressed:
                                                                        () {
                                                                      Navigator.pop(
                                                                          context,
                                                                          'true');
                                                                    },
                                                                    child:
                                                                        const Text(
                                                                      "Evet",
                                                                      style: TextStyle(
                                                                          fontFamily:
                                                                              "NotoSansBold",
                                                                          color:
                                                                              Colors.red),
                                                                    ),
                                                                  )
                                                                ],
                                                              );
                                                            });
                                                    if (result == 'true') {
                                                      var members =
                                                          doc[index]['members'];
                                                      var data = groups[index];
                                                      members
                                                          .remove(user!.email);
                                                      groups.remove(data);
                                                      await userData.update(
                                                          {'groups': groups});
                                                      groupData
                                                          .doc(data)
                                                          .update({
                                                        'members': members
                                                      });
                                                    }
                                                  },
                                                )),
                                          );
                                        }
                                      } else {
                                        return Container();
                                      }
                                    },
                                  ),
                                ],
                              );
                            }
                          },
                        )),
                    SizedBox(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 350, left: 300),
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          child: const Icon(Icons.add),
                          onPressed: () async {
                            var result = await showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                      "Grup Oluştur",
                                      style:
                                          TextStyle(fontFamily: "NotoSansBold"),
                                    ),
                                    actions: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 250,
                                            child: TextFormField(
                                              controller: groupNameInput,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Grup İsmi",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: TextFormField(
                                              controller: groupDescriptionInput,
                                              decoration: const InputDecoration(
                                                border: OutlineInputBorder(),
                                                hintText: "Grup Açıklaması",
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SizedBox(
                                            width: 250,
                                            child: TextFormField(
                                              controller: maxUserInput,
                                              decoration: const InputDecoration(
                                                  border: OutlineInputBorder(),
                                                  hintText:
                                                      "Maksimum kullanıcı sayısı"),
                                            ),
                                          ),
                                          TextButton(
                                              onPressed: () {
                                                groupNameInput.clear();
                                                groupDescriptionInput.clear();
                                                maxUserInput.clear();
                                                Navigator.pop(context, 'false');
                                              },
                                              child: const Text(
                                                "İptal",
                                                style: TextStyle(
                                                  fontFamily: "NotoSansBold",
                                                  color: Colors.red,
                                                ),
                                              )),
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'true');
                                              },
                                              child: const Text(
                                                "Oluştur",
                                                style: TextStyle(
                                                  fontFamily: "NotoSansBold",
                                                  color: Colors.red,
                                                ),
                                              )),
                                        ],
                                      ),
                                    ],
                                  );
                                });
                            if (result == "true") {
                              var members = [user!.email];
                              Map<String, dynamic> data = {
                                "name": groupNameInput.text,
                                "owner": "${user!.email}",
                                "members": members,
                                "maximumMemberCount":
                                    int.parse(maxUserInput.text),
                                "description": groupDescriptionInput.text
                              };
                              groupData.add(data).then(
                                (value) async {
                                  groups.add(value.id);
                                  await userData.update({"groups": groups});
                                },
                              );
                            }
                          },
                        ),
                      ),
                    )
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
