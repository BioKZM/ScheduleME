// ignore_for_file: camel_case_types, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class daysFriday extends StatefulWidget {
  const daysFriday({Key? key}) : super(key: key);

  @override
  State<daysFriday> createState() => _daysFridayState();
}

class _daysFridayState extends State<daysFriday> {
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final planNameInput = TextEditingController();
  final planDescriptionInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference data = _firestore.collection('brews');
    var userData = data.doc('${user!.email}');
    return Scaffold(
        body: Column(
      children: [
        SizedBox(
            child: StreamBuilder<DocumentSnapshot>(
                stream: userData.snapshots(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.active) {
                    var list = snapshot.data.data();
                    var plans = list['plans'][4]['plans'];
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.87,
                          child: ListView.builder(
                            itemCount: plans.length,
                            itemBuilder: (context, index) {
                              if (plans.length == 0) {
                                return Container();
                              } else {
                                return Card(
                                  child: ListTile(
                                    onTap: () async {
                                      var result = await showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title: const Text(
                                                "Düzenle",
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
                                                            planNameInput,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              "Plan İsmi",
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
                                                            planDescriptionInput,
                                                        decoration:
                                                            const InputDecoration(
                                                          labelText:
                                                              "Plan Açıklaması",
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
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: [
                                                        TextButton(
                                                            onPressed: () {
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
                                                              "Kaydet",
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
                                                )
                                              ],
                                            );
                                          });
                                      if (result == "true") {
                                        plans[index]['name'] =
                                            planNameInput.text;
                                        plans[index]['description'] =
                                            planDescriptionInput.text;
                                        // plans.add(map);
                                        list['plans'][4]['plans'] = plans;
                                        planNameInput.clear();
                                        planDescriptionInput.clear();
                                        await userData
                                            .update({'plans': list['plans']});
                                      }
                                    },
                                    title: Text(plans[index]['name']),
                                    subtitle: Text(plans[index]['description']),
                                    trailing: IconButton(
                                        icon: const Icon(Icons.delete),
                                        onPressed: () async {
                                          var result = await showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text(
                                                    "Uyarı",
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "NotoSansBold"),
                                                  ),
                                                  content: const Text(
                                                      "Kaydı silmek istediğine emin misin?"),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'false');
                                                        },
                                                        child: const Text(
                                                          "Hayır",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "NotoSansBold",
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context, 'true');
                                                      },
                                                      child: const Text(
                                                        "Evet",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "NotoSansBold",
                                                            color: Colors.red),
                                                      ),
                                                    )
                                                  ],
                                                );
                                              });
                                          if (result == 'true') {
                                            plans.remove(plans[index]);
                                            list['plans'][4]['plans'] = plans;
                                            await userData.update(
                                                {'plans': list['plans']});
                                          }
                                        }),
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 20, left: 300),
                              child: FloatingActionButton(
                                onPressed: () async {
                                  var result = await showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: const Text(
                                            "Kayıt Ekle",
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
                                                      controller: planNameInput,
                                                      cursorColor: Colors.red,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: "Plan İsmi",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black54),
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
                                                    )),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                    height: 50,
                                                    child: TextFormField(
                                                      controller:
                                                          planDescriptionInput,
                                                      cursorColor: Colors.red,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            "Plan Açıklaması",
                                                        labelStyle: TextStyle(
                                                            color:
                                                                Colors.black54),
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
                                                    )),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    TextButton(
                                                        onPressed: () {
                                                          planNameInput.clear();
                                                          planDescriptionInput
                                                              .clear();
                                                          Navigator.pop(
                                                              context, "false");
                                                        },
                                                        child: const Text(
                                                          "İptal",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "NotoSansBold",
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, "true");
                                                        },
                                                        child: const Text(
                                                          "Ekle",
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  "NotoSansBold",
                                                              color:
                                                                  Colors.red),
                                                        )),
                                                  ],
                                                )
                                              ],
                                            )
                                          ],
                                        );
                                      });
                                  if (result == 'true') {
                                    Map<String, dynamic> map = {
                                      "name": planNameInput.text,
                                      "description": planDescriptionInput.text,
                                    };
                                    plans.add(map);
                                    list['plans'][4]['plans'] = plans;
                                    planNameInput.clear();
                                    planDescriptionInput.clear();
                                    await userData
                                        .update({'plans': list['plans']});
                                  }
                                },
                                backgroundColor: Colors.red,
                                child: const Icon(Icons.add),
                              )),
                        ),
                      ],
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                })),
      ],
    ));
  }
}
