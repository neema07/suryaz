import 'package:flutter/material.dart';
import 'package:suryaz/adminlogin.dart';

import 'scanner.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              'assets/images/book.jpg',
              fit: BoxFit.cover,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all(Colors.white),
                        backgroundColor: WidgetStateProperty.all(
                            const Color.fromARGB(78, 206, 255, 101))),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AdminLogin(),
                          ));
                    },
                    child: Text('ADMIN'),
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          foregroundColor:  
                              WidgetStateProperty.all(Colors.white),
                          backgroundColor: WidgetStateProperty.all(
                              const Color.fromARGB(78, 206, 255, 101))),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => QRViewExample(),
                            ));
                      },
                      child: Text('USER'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
