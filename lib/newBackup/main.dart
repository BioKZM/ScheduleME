import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:scheduleme/loading.dart';
import '../login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Home());
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    // User? user = FirebaseAuth.instance.currentUser;
    // print(user);
    // dynamic homeRoute() {
    //   if (user == null) {
    //     return const Login();
    //   } else {
    //     return const Main();
    //   }
    // }
    // return StreamProvider<FUser?>.value(
    //     initialData: FUser(),
    //     value: AuthService().user,

    return MaterialApp(
      title: "ScheduleME",
      initialRoute: "/loading",
      routes: {
        "/loading": (context) => const Loading(),
        "/main": (context) => const Main(),
        "/login": (context) => const Login(),
      },
      home: const Loading(),
    );
    // return const Loading();
  }
  // final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // @override
  // Widget build(BuildContext context) {
  //   var data = _firestore.collection("brews");

  //   return Scaffold(
  //       body: Column(children: [
  //     StreamBuilder(
  //         stream: data.snapshots(),
  //         builder: (BuildContext context, AsyncSnapshot snapshot) {
  //           return Text('${snapshot.data.data()}');
  //         })
  //   ]));
  // }
}
// "Bak şimdi burada şu yapılıyor: Normal şartlarda biz çok meşakatli bir şekilde data getiriyorduk durumu bilmediğimiz için. Sadece internet üzerinden kopyala yapıştır ile çözmeye çalışıyorduk"
// "Benim öğrendiğim şey şu, biz yukarıda bi"

class Main extends StatefulWidget {
  const Main({Key? key}) : super(key: key);

  @override
  State<Main> createState() => _MainState();
}

class _MainState extends State<Main> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    var data =
        _firestore.collection("brews").doc('LqRIRowJ1HOyLherCDSQOWG7dTc2');
    // Collection -> Document

    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          ElevatedButton(
              child: Text("Tıkla"),
              onPressed: () async {
                var response = await data.get();
                print(response.data()!['plans']);
                await FirebaseAuth.instance.signOut();
              }),
        ],
      ),
    );
  }
}
