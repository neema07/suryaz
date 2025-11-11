import 'package:flutter/material.dart';
import 'package:suryaz/bookedlist.dart';

import 'addproducts.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

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
          child: Padding(
            padding: const EdgeInsets.only(top: 250),
            child: Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black38)),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddProducts(),
                          ));
                    },
                    label: const Text(
                      'Add Products',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    icon: const Icon(
                      Icons.add_box_rounded,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: 200,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.book),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black38)),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BookedList(),
                        ),
                      );
                    },
                    label: const Text(
                      'Bookings',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    )));
  }
}
