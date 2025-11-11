// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BuyProduct extends StatefulWidget {
  final String productId;
  const BuyProduct({
    super.key,
    required this.productId,
  });

  @override
  State<BuyProduct> createState() => _BuyProductState();
}

class _BuyProductState extends State<BuyProduct> {
  final phoneController = TextEditingController();
  Future<void> placeOrder(BuildContext context) async {
    final url =
        Uri.parse('https://suryaz-backend.onrender.com/api/add_booking');
    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode({
          'product_id': widget.productId,
          'phone_number': phoneController.text,
        }),
      );

      if (response.statusCode == 200) {
        phoneController.clear();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Order Placed')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text(
                  'Failed to Book ${response.statusCode} ${response.body}')),
        );
      }
    } catch (e) {
      if (phoneController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Add Phone number!')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Enter your Phone number here'),
              SizedBox(
                width: 320,
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                      hintText: 'Phone Number',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton.icon(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.green.shade200)),
                onPressed: () {
                  placeOrder(context);
                },
                label: const Text('BUY NOW'),
                icon: const Icon(Icons.book),
              )
            ],
          ),
        ),
      ),
    );
  }
}
