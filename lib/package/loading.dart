import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:scheduleme/package/register.dart';

import '../main.dart';
import '../services/user.dart';
import 'login.dart';

// class Loading extends StatelessWidget {
//   const Loading({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final user = Provider.of<FUser>(context);
//     if (user != null) {
//       print(user);
//       return Main();
//     } else {
//       print(user);
//       return Login();
//     }
//   }
// }
class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FUser>(context);
    return Login();
    // final user =
    //     Provider.of<FUser>(context) == null ? const Login() : const Main();
    // return user;
    // final user = Provider.of<FUser>(context);
    // // return Ma();
    // // return Login();
    // if (user == null) {
    //   return Login();
    // } else {
    //   print(user.userid);
    //   return Main();
    // }
    // }
    // return Login();
    // if (user == null) {
    //   return Login();
    // } else {
    //   return Main();
    // }

    // ignore: unnecessary_null_comparison
    // if (user != null) {
    //   print(user.userid);
    //   return const Main();
    // } else {
    //   // print(user!.userid);
    //   return const Login();
    // }
  }
}

    // Future.delayed(const Duration(seconds: 2), () {
    //   print(user);
    //   Navigator.pushNamed(context, "/login");
    // });

    // return const Scaffold(
    //     body: Center(child: SpinKitWave(color: Colors.red, size: 30)));
