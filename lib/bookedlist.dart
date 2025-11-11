// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class BookedList extends StatefulWidget {
  const BookedList({super.key});

  @override
  State<BookedList> createState() => _BookedListState();
}

class _BookedListState extends State<BookedList> {
  final List<String> booked = [
    'Booking 1',
    'Booking 2',
    'Booking 3',
    'Booking 4',
    'Booking 5',
  ];
  List dataList = [];
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
      'https://suryaz-backend.onrender.com/api/get_bookings',
    );

    try {
      final response = await http.get(url);
      print(response);
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          dataList = data;
        });
      } else {
        print('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          title: const Center(
              child: Text(
            'BookedList',
            style: TextStyle(fontSize: 30),
          )),
          automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.grey[900],
                    elevation: 5,
                    margin:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Text(
                            dataList[index]['phone_number'],
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          ),
                          Text(
                            dataList[index]['product_id']['description'],
                            style: const TextStyle(
                                fontSize: 18.0, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(
                    color: Colors.black,
                    thickness: 1.0,
                  );
                },
                itemCount: dataList.length,
              ),
      ),
    );
  }
}
