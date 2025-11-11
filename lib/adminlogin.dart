// ignore_for_file: camel_case_types, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:suryaz/adminhome.dart';
import 'package:suryaz/userhome.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _loginState();
}

class _loginState extends State<AdminLogin> {
  final logincodecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final adminlogincode = '6578';
  final adminpassword = '1234';
  // final userlogincode = '7895';
  // final userpassword = '3698';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Image.asset(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            'assets/images/book.jpg',
            fit: BoxFit.cover,
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 130.0),
              child: Center(
                child: Column(children: [
                  const Text(
                    'LOGIN',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: 190,
                    height: 50,
                    child: TextField(
                      controller: logincodecontroller,
                      decoration: InputDecoration(
                          labelText: "Login Code",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.white54,
                          filled: true),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    width: 190,
                    height: 50,
                    child: TextField(
                      controller: passwordcontroller,
                      decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          fillColor: Colors.white54,
                          filled: true),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  ElevatedButton(
                    onPressed: submit,
                    style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all(Colors.white),
                        backgroundColor: MaterialStateProperty.all(
                            const Color.fromARGB(78, 206, 255, 101))),
                    child: const Text("LOGIN"),
                  ),
                  Image.asset('assets/images/icon.png')
                ]),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  void submit() {
    String enterlogincode = logincodecontroller.text;
    String enterpassword = passwordcontroller.text;
    if (adminlogincode == enterlogincode && adminpassword == enterpassword) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const AdminHome()));
      // } else if (userlogincode == enterlogincode &&
      //     userpassword == enterpassword) {
      //   Navigator.push(
      //       context,
      //       MaterialPageRoute(
      //           builder: (context) => const ProductListPage(
      //                 shopArea: '',
      //               )));
    }
  }
}
