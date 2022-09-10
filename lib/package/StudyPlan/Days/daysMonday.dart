import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class daysMonday extends StatefulWidget {
  const daysMonday({Key? key}) : super(key: key);

  @override
  State<daysMonday> createState() => _daysMondayState();
}

class _daysMondayState extends State<daysMonday> {
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
                    var plans = list['plans'][0]['plans'];
                    return Column(
                      children: [
                        SizedBox(
                          height: 400,
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
                                                      width: 250,
                                                      child: TextFormField(
                                                          controller:
                                                              planNameInput,
                                                          decoration:
                                                              const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                "Plan İsmi",
                                                          )),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    SizedBox(
                                                      width: 250,
                                                      child: TextFormField(
                                                        controller:
                                                            planDescriptionInput,
                                                        decoration: const InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                            hintText:
                                                                "Plan Açıklaması"),
                                                      ),
                                                    ),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'false');
                                                        },
                                                        child: const Text(
                                                          "İptal",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "NotoSansBold",
                                                            color: Colors.red,
                                                          ),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context, 'true');
                                                        },
                                                        child: const Text(
                                                          "Kaydet",
                                                          style: TextStyle(
                                                            fontFamily:
                                                                "NotoSansBold",
                                                            color: Colors.red,
                                                          ),
                                                        )),
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
                                        list['plans'][0]['plans'] = plans;
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
                                            list['plans'][0]['plans'] = plans;
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
                                  const EdgeInsets.only(top: 300, left: 300),
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
                                                    width: 250,
                                                    child: TextFormField(
                                                      controller: planNameInput,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText: "Plan İsmi",
                                                      ),
                                                    )),
                                                SizedBox(
                                                    width: 250,
                                                    child: TextFormField(
                                                      controller:
                                                          planDescriptionInput,
                                                      decoration:
                                                          const InputDecoration(
                                                        border:
                                                            OutlineInputBorder(),
                                                        hintText:
                                                            "Plan Açıklaması",
                                                      ),
                                                    )),
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
                                                      ),
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
                                                      ),
                                                    ))
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
                                    list['plans'][0]['plans'] = plans;
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
