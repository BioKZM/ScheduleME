import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:scheduleme/services/user.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

// import '../../services/database.dart';

import '../../services/auth.dart';
import '../loading.dart';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  // final AuthService _authService = AuthService();

  var DersAdi = TextEditingController();
  var DersKodu = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
    return const Scaffold(
        body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
    // // return Text("Deneme");
    // String error = "";
    // final user = Provider.of<FUser>(context);
    // return StreamBuilder<UserData>(
    //     stream: DatabaseService(userid: user.userid).userData,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         // print(snapshot.error.toString());
    //         UserData? userData = snapshot.data;

    //         return Scaffold(
    //           backgroundColor: Colors.white,
    //           body: Form(
    //             key: _formKey,
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: <Widget>[
    //                 IconButton(
    //                   onPressed: () => Navigator.pop(context),
    //                   icon: const Icon(Icons.arrow_back_rounded),
    //                 ),
    //                 SizedBox(
    //                   width: 320,
    //                   height: 200,
    //                   // color: Colors.red,
    //                   child: Column(
    //                     children: <Widget>[
    //                       Row(
    //                         children: const <Widget>[
    //                           SizedBox(
    //                             height: 40,
    //                           )
    //                         ],
    //                       ),
    //                       Row(
    //                         children: <Widget>[
    //                           Container(
    //                             margin: const EdgeInsets.only(left: 25),
    //                             child: const Text(
    //                               "Ders Ekle",
    //                               style: TextStyle(
    //                                   fontFamily: "NotoSansBold", fontSize: 40),
    //                             ),
    //                           ),
    //                         ],
    //                       ),
    //                       Row(
    //                         children: <Widget>[
    //                           Container(
    //                             margin: const EdgeInsets.only(left: 28),
    //                             width: 200,
    //                             height: 2,
    //                             color: Colors.black,
    //                           )
    //                         ],
    //                       )
    //                     ],
    //                   ),
    //                 ),
    //                 Container(
    //                   margin: const EdgeInsets.only(top: 20, left: 25),
    //                   width: 270,
    //                   height: 300,
    //                   // color: Colors.blue,
    //                   child: Column(
    //                     children: <Widget>[
    //                       const SizedBox(
    //                         width: 300,
    //                         height: 35,
    //                         child: Text(
    //                           "Ders Kodu",
    //                           style: TextStyle(
    //                               fontFamily: "NotoSansLight", fontSize: 18),
    //                           textAlign: TextAlign.left,
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         width: 300,
    //                         height: 60,
    //                         child: TextFormField(
    //                           validator: (val) => val!.isEmpty
    //                               ? "Ders kodu boş bırakılamaz."
    //                               : null,
    //                           controller: DersKodu,
    //                           decoration: const InputDecoration(
    //                             counterText: ' ',
    //                             border: OutlineInputBorder(
    //                               borderRadius:
    //                                   BorderRadius.all(Radius.circular(5)),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 20,
    //                       ),
    //                       const SizedBox(
    //                         width: 268,
    //                         height: 30,
    //                         child: Text(
    //                           "Ders Adı",
    //                           style: TextStyle(
    //                               fontFamily: "NotoSansLight", fontSize: 18),
    //                           textAlign: TextAlign.left,
    //                         ),
    //                       ),
    //                       SizedBox(
    //                         width: 300,
    //                         height: 40,
    //                         child: TextFormField(
    //                           validator: (val) => val!.isEmpty
    //                               ? 'Ders adı boş bırakılamaz!'
    //                               : null,
    //                           controller: DersAdi,
    //                           decoration: const InputDecoration(
    //                             counterText: '',
    //                             border: OutlineInputBorder(
    //                               borderRadius:
    //                                   BorderRadius.all(Radius.circular(5)),
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       const SizedBox(
    //                         height: 40,
    //                       ),
    //                       SizedBox(
    //                         width: 100,
    //                         height: 40,
    //                         child: OutlinedButton.icon(
    //                           style: OutlinedButton.styleFrom(
    //                             side: const BorderSide(
    //                                 width: 1, color: Colors.grey),
    //                           ),
    //                           onPressed: () async {
    //                             if (_formKey.currentState!.validate()) {
    //                               Map<String, dynamic>? courses =
    //                                   userData?.courses;
    //                               courses?[DersKodu.text] = DersAdi.text;

    //                               dynamic result =
    //                                   await DatabaseService(userid: user.userid)
    //                                       .addAndChangeCourse(
    //                                           userData?.name,
    //                                           userData?.surname,
    //                                           courses,
    //                                           userData?.groups,
    //                                           userData?.plans);
    //                               // print(user?.userid);
    //                               print(result);
    //                               if (result == null) {
    //                                 setState(() => error =
    //                                     "Ders eklenirken bir hata oluştu.");
    //                                 showAlertDialog(context);
    //                                 DersKodu.clear();
    //                                 DersAdi.clear();
    //                                 // ignore: use_build_context_synchronously
    //                                 Navigator.pushNamed(context, "/addCourse");
    //                               } else {
    //                                 showAlertDialog(context);
    //                                 DersKodu.clear();
    //                                 DersAdi.clear();
    //                                 // ignore: use_build_context_synchronously
    //                                 Navigator.pushNamed(context, "/addCourse");
    //                               }
    //                             }
    //                           },
    //                           icon: const Icon(
    //                             Icons.add,
    //                             color: Colors.red,
    //                           ),
    //                           label: const Text(
    //                             "Ekle",
    //                             style: TextStyle(
    //                               color: Colors.red,
    //                               fontSize: 18,
    //                             ),
    //                           ),
    //                         ),
    //                       ),
    //                       Text(
    //                         error,
    //                         style: const TextStyle(
    //                             color: Colors.red,
    //                             fontFamily: "NotoSansBold",
    //                             fontSize: 15),
    //                       )
    //                     ],
    //                   ),
    //                 )
    //               ],
    //             ),
    //           ),
    //         );
    //       }
    //       // print(userData);
    //       //return Text("Test");
    //       //return const AddCourse();
    //       return const Scaffold(
    //           body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
    //     });
  }
}
