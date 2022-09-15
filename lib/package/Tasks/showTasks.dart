import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

class ShowTasks extends StatefulWidget {
  const ShowTasks({Key? key}) : super(key: key);

  @override
  State<ShowTasks> createState() => _ShowTasksState();
}

class _ShowTasksState extends State<ShowTasks> {
  String getDateTime() {
    return DateFormat.yMMMMd('tr').add_Hm().format(dateTime);
  }

  Future<DateTime> _selectDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      locale: const Locale("tr", "TR"),
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final selected = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (selected != null && selected != selectedTime) {
      setState(() {
        selectedTime = selected;
      });
    }
    return selectedTime;
  }

  Future _selectDateTime(BuildContext context) async {
    final date = await _selectDate(context);
    if (date == null) return;

    final time = await _selectTime(context);

    if (time == null) return;
    setState(() {
      dateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  TimeOfDay selectedTime = TimeOfDay.now();
  DateTime dateTime = DateTime.now();
  DateTime selectedDate = DateTime.now();
  final _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  final taskNameInput = TextEditingController();
  final taskDescriptionInput = TextEditingController();
  final taskDateInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CollectionReference data = _firestore.collection('brews');
    var userData = data.doc('${user!.email}');
    return Scaffold(
      body: Column(
        children: [
          StreamBuilder<DocumentSnapshot>(
              stream: userData.snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.active) {
                  var list = snapshot.data.data();
                  var tasks = list['tasks'];
                  return Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.87,
                        child: ListView.builder(
                          itemCount: tasks.length,
                          itemBuilder: (context, index) {
                            if (tasks.length == 0) {
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
                                                      validator: (val) => val!
                                                              .isEmpty
                                                          ? "Görev adı boş bırakılamaz"
                                                          : null,
                                                      cursorColor: Colors.red,
                                                      controller:
                                                          taskDescriptionInput,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText: "Görev Adı",
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
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    height: 50,
                                                    child: TextFormField(
                                                      validator: (val) => val!
                                                              .isEmpty
                                                          ? "Görev açıklaması boş bırakılamaz"
                                                          : null,
                                                      cursorColor: Colors.red,
                                                      controller:
                                                          taskDescriptionInput,
                                                      decoration:
                                                          const InputDecoration(
                                                        labelText:
                                                            "Görev Açıklaması",
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
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    child: Row(
                                                      children: [
                                                        TextButton(
                                                          onPressed: () async {
                                                            setState(() {
                                                              _selectDateTime(
                                                                  context);
                                                            });
                                                          },
                                                          child: const Text(
                                                            "Tarih",
                                                            style: TextStyle(
                                                                color:
                                                                    Colors.red,
                                                                fontFamily:
                                                                    "NotoSansBold"),
                                                          ),
                                                        ),
                                                      ],
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
                                                              color: Colors.red,
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
                                                              color: Colors.red,
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
                                      tasks[index]['taskName'] =
                                          taskNameInput.text;
                                      tasks[index]['taskDescription'] =
                                          taskDescriptionInput.text;
                                      tasks[index]['taskDate'] = getDateTime();
                                      taskNameInput.clear();
                                      taskDescriptionInput.clear();
                                      taskDateInput.clear();
                                      await userData.update({'tasks': tasks});
                                    }
                                  },
                                  title: Text(tasks[index]['taskName']),
                                  subtitle: Text(
                                      "${tasks[index]['taskDescription']}\n${tasks[index]['taskDate']}"),
                                  trailing: IconButton(
                                      icon: const Icon(Icons.check),
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
                                                    "Bu görevi tamamlamak istediğine emin misin?"),
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
                                                            color: Colors.red),
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
                                          tasks.remove(tasks[index]);
                                          await userData
                                              .update({'tasks': tasks});
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
                            padding: const EdgeInsets.only(top: 20, left: 300),
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
                                                    validator: (val) => val!
                                                            .isEmpty
                                                        ? "Görev adı boş bırakılamaz"
                                                        : null,
                                                    controller: taskNameInput,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText: "Görev Adı",
                                                    ),
                                                  )),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              SizedBox(
                                                  height: 50,
                                                  child: TextFormField(
                                                    validator: (val) => val!
                                                            .isEmpty
                                                        ? "Görev açıklaması boş bırakılamaz"
                                                        : null,
                                                    controller:
                                                        taskDescriptionInput,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      hintText:
                                                          "Görev Açıklaması",
                                                    ),
                                                  )),
                                              SizedBox(
                                                width: 250,
                                                child: Row(
                                                  children: [
                                                    TextButton(
                                                      onPressed: () async {
                                                        setState(() {
                                                          _selectDateTime(
                                                              context);
                                                        });
                                                      },
                                                      child: const Text(
                                                        "Tarih",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "NotoSansBold",
                                                            color: Colors.red),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  TextButton(
                                                      onPressed: () {
                                                        taskNameInput.clear();
                                                        taskDescriptionInput
                                                            .clear();
                                                        Navigator.pop(
                                                            context, "false");
                                                      },
                                                      child: const Text(
                                                        "İptal",
                                                        style: TextStyle(
                                                            fontFamily:
                                                                "NotoSansBold",
                                                            color: Colors.red),
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
                                                            color: Colors.red),
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
                                    "taskName": taskNameInput.text,
                                    "taskDescription":
                                        taskDescriptionInput.text,
                                    "taskDate": getDateTime(),
                                  };
                                  tasks.add(map);
                                  taskNameInput.clear();
                                  taskDescriptionInput.clear();
                                  taskDateInput.clear();
                                  await userData.update({'tasks': tasks});
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
              })
        ],
      ),
    );
  }
}
