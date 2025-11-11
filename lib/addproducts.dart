// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({super.key});

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  File? _selectedImage;
  Future<void> _submitDetails(BuildContext context) async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Select an Image')),
      );
      return;
    }
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('https://suryaz-backend.onrender.com/api/add_products'),
      );
      request.fields['description'] = descriptionController.text;
      request.fields['price'] = priceController.text;
      var stream = http.ByteStream(_selectedImage!.openRead());
      var length = await _selectedImage!.length();
      var multipartFile = http.MultipartFile(
        'file',
        stream,
        length,
        filename: basename(_selectedImage!.path),
      );
      request.files.add(multipartFile);

      var response = await request.send();

      if (response.statusCode == 200) {
        descriptionController.clear();
        priceController.clear();
        setState(() {
          _selectedImage = null;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Added successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to Add ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          automaticallyImplyLeading: false,
          title: const Center(
            child: Text(
              'ADD PRODUCTS',
            ),
          ),
        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: imageSelectGallery,
                    icon: const Icon(Icons.photo),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: imageSelectCamera,
                    icon: const Icon(Icons.camera_alt_rounded),
                    iconSize: 30,
                    color: Colors.white,
                  ),
                ],
              ),
              _selectedImage != null
                  ? Image.file(
                      _selectedImage!,
                      height: 250,
                    )
                  : const Text(
                      'Please Select An Image',
                      style: TextStyle(color: Colors.white),
                    ),
              const SizedBox(
                height: 25,
              ),
              SizedBox(
                width: 320,
                child: TextFormField(
                  controller: descriptionController,
                  style: const TextStyle(color: Colors.white),
                  minLines: 5,
                  maxLines: 10,
                  decoration: InputDecoration(
                      hintText: 'Add Description',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 320,
                child: TextField(
                  controller: priceController,
                  style: const TextStyle(color: Colors.white),
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: 'price',
                      hintStyle: const TextStyle(color: Colors.white),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22))),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  _submitDetails(context);
                },
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          ),
        ));
  }

  Future imageSelectGallery() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (resultImage == null) return;
    setState(() {
      _selectedImage = File(resultImage.path);
    });
  }

  Future imageSelectCamera() async {
    final resultImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (resultImage == null) return;
    setState(() {
      _selectedImage = File(resultImage.path);
    });
  }
}
