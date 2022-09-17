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
        StreamBuilder(
            stream: groupData.snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.active) {
                List<DocumentSnapshot> doc = snapshot.data.docs;
                return Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.87,
                      child: ListView.builder(
                        itemCount: doc.length,
                        itemBuilder: (context, index) {
                          if (doc.isEmpty) {
                            return Container();
                          } else {
                            return Column(
                              children: [
                                StreamBuilder(
                                    stream: userData.snapshots(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot snapshot) {
                                      if (snapshot.hasData &&
                                          snapshot.connectionState ==
                                              ConnectionState.active) {
                                        var list = snapshot.data.data();
                                        var groups = list['groups'];
                                        if (doc[index]['members']
                                                .contains(user!.email) &&
                                            groups.contains(doc[index].id)) {
                                          if (doc[index]["owner"] ==
                                              user!.email) {
                                            return Card(
                                              child: ListTile(
                                                title: Text(
                                                    "${doc[index]['name']}"),
                                                subtitle: Text(
                                                    "${doc[index]['members'].length}/${doc[index]['maximumMemberCount']}\n${doc[index]['description']}"),
                                                trailing: IconButton(
                                                    icon: const Icon(
                                                        Icons.delete),
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
                                                                  content:
                                                                      const Text(
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
                                                                              fontFamily: "NotoSansBold",
                                                                              color: Colors.red),
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
                                                        var data =
                                                            groups[index];
                                                        var members = doc[index]
                                                            ['members'];
                                                        for (int x = 0;
                                                            x < members.length;
                                                            x++) {
                                                          var gdata =
                                                              (await _firestore
                                                                  .collection(
                                                                      "brews")
                                                                  .doc(members[
                                                                      x])
                                                                  .get())['groups'];
                                                          gdata.remove(data);
                                                          await _firestore
                                                              .collection(
                                                                  "brews")
                                                              .doc(members[x])
                                                              .update({
                                                            "groups": gdata
                                                          });
                                                        }
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
                                                                  content:
                                                                      const Text(
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
                                                                              fontFamily: "NotoSansBold",
                                                                              color: Colors.red),
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
                                                        var members = doc[index]
                                                            ['members'];
                                                        var data =
                                                            doc[index].id;
                                                        members.remove(
                                                            user!.email);
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
                                      } else {
                                        return Container();
                                      }
                                    })
                              ],
                            );
                          }
                        },
                      ),
                    ),
                    StreamBuilder(
                        stream: userData.snapshots(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (snapshot.hasData &&
                              snapshot.connectionState ==
                                  ConnectionState.active) {
                            var list = snapshot.data.data();
                            var groups = list['groups'];
                            return SizedBox(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 300),
                                child: FloatingActionButton(
                                  backgroundColor: Colors.red,
                                  child: const Icon(Icons.add),
                                  onPressed: () async {
                                    if (groups.length == 10) {
                                      await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Uyarı",
                                                style: TextStyle(
                                                    fontFamily: "NotoSansBold",
                                                    color: Colors.red),
                                              ),
                                              content: const Text(
                                                  "Maksimum 10 tane gruba sahip olabilirsin."),
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
                                    } else {
                                      var result = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Grup Oluştur",
                                                style: TextStyle(
                                                    fontFamily: "NotoSansBold"),
                                              ),
                                              actions: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: 50,
                                                      child: TextFormField(
                                                        controller:
                                                            groupNameInput,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText: "Grup Adı",
                                                          labelStyle: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                      child: TextFormField(
                                                        controller:
                                                            groupDescriptionInput,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              "Grup Açıklaması",
                                                          labelStyle: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      height: 50,
                                                      child: TextFormField(
                                                        controller:
                                                            maxUserInput,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              "Maksimum Kullanıcı Sayısı",
                                                          labelStyle: TextStyle(
                                                              color: Colors
                                                                  .black54),
                                                          border: OutlineInputBorder(
                                                              borderSide:
                                                                  BorderSide(
                                                                      color: Colors
                                                                          .red)),
                                                          focusedBorder:
                                                              OutlineInputBorder(
                                                            borderSide:
                                                                BorderSide(
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
                                                              groupNameInput
                                                                  .clear();
                                                              groupDescriptionInput
                                                                  .clear();
                                                              maxUserInput
                                                                  .clear();
                                                              Navigator.pop(
                                                                  context,
                                                                  'false');
                                                            },
                                                            child: const Text(
                                                              "İptal",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "NotoSansBold",
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            )),
                                                        TextButton(
                                                            onPressed: () {
                                                              Navigator.pop(
                                                                  context,
                                                                  'true');
                                                            },
                                                            child: const Text(
                                                              "Oluştur",
                                                              style: TextStyle(
                                                                fontFamily:
                                                                    "NotoSansBold",
                                                                color:
                                                                    Colors.red,
                                                              ),
                                                            )),
                                                      ],
                                                    ),
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
                                          "description":
                                              groupDescriptionInput.text
                                        };
                                        groupData.add(data).then(
                                          (value) async {
                                            groups.add(value.id);
                                            await userData
                                                .update({"groups": groups});
                                          },
                                        );
                                        groupNameInput.clear();
                                        groupDescriptionInput.clear();
                                        maxUserInput.clear();
                                      }
                                    }
                                  },
                                ),
                              ),
                            );
                          } else {
                            return Container();
                          }
                        })
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
