import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  final DersAdi = TextEditingController();
  final DersKodu = TextEditingController();

  showAlertDialog(BuildContext context) {
    AlertDialog alertDialog = AlertDialog(
      title: const Text(
        "İşlem Başarılı",
        style: TextStyle(fontFamily: "NotoSansBold"),
      ),
      content: const Text("Ders Başarıyla Eklendi!"),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            "Tamam",
            style: TextStyle(fontFamily: "NotoSansBold", color: Colors.red),
          ),
        )
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alertDialog;
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_rounded),
          ),
          SizedBox(
            width: 320,
            height: 200,
            // color: Colors.red,
            child: Column(
              children: <Widget>[
                Row(
                  children: const <Widget>[
                    SizedBox(
                      height: 40,
                    )
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 25),
                      child: const Text(
                        "Ders Ekle",
                        style:
                            TextStyle(fontFamily: "NotoSansBold", fontSize: 40),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(left: 28),
                      width: 200,
                      height: 2,
                      color: Colors.black,
                    )
                  ],
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20, left: 25),
            width: 270,
            height: 300,
            // color: Colors.blue,
            child: Column(
              children: <Widget>[
                const SizedBox(
                  width: 268,
                  height: 30,
                  child: Text(
                    "Ders Adı",
                    style: TextStyle(fontFamily: "NotoSansLight", fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextField(
                    controller: DersAdi,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const SizedBox(
                  width: 268,
                  height: 30,
                  child: Text(
                    "Ders Kodu",
                    style: TextStyle(fontFamily: "NotoSansLight", fontSize: 18),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(
                  width: 300,
                  height: 45,
                  child: TextField(
                    controller: DersKodu,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                ),
                // ElevatedButton.icon(
                //   onPressed: () => print("Test"),
                //   icon: Icon(Icons.add),
                //   label: Text("Ekle"),

                // ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  width: 100,
                  height: 40,
                  child: OutlinedButton.icon(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.grey),
                    ),
                    onPressed: () {
                      showAlertDialog(context);
                      DersKodu.clear();
                      DersAdi.clear();
                    },
                    icon: const Icon(
                      Icons.add,
                      color: Colors.red,
                    ),
                    label: const Text(
                      "Ekle",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
