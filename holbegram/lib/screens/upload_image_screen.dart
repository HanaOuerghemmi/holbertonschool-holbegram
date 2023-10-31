import 'dart:io';
import 'dart:typed_data';
import 'package:cross_file_image/cross_file_image.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:holbegram/methods/auth_methods.dart';
import 'package:holbegram/screens/home.dart';
import 'package:image_picker/image_picker.dart';

class AddPicture extends StatefulWidget {
  final String email;
  final String password;
  final String username;

  AddPicture({
    Key? key,
    required this.email,
    required this.password,
    required this.username,
  }) : super(key: key);

  @override
  State<AddPicture> createState() => _AddPictureState();
}

class _AddPictureState extends State<AddPicture> {
  Uint8List? _image;

  void selectImageFromGallery() async {
    final XFile? image =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    final File imageFile = File(image!.path);
    final Uint8List bytes = await imageFile.readAsBytes();

    setState(() {
      _image = bytes;
    });
  }

  void selectImageFromCamera() async {
    final XFile? image =
    await ImagePicker().pickImage(source: ImageSource.camera);
    final File imageFile = File(image!.path);
    final Uint8List bytes = await imageFile.readAsBytes();

    setState(() {
      _image = bytes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 28,
              ),
              const Text(
                'Holbegram',
                style: TextStyle(fontFamily: 'Billabong', fontSize: 50),
              ),
              Image.asset(
                'assets/images/img.png',
                width: 80,
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 28,
                    ),
                    Text("Hello, ${widget.username}"),
                    const Text("choose imagee from gallery"),
                    const SizedBox(
                      height: 10,
                    ),
                    _image == null
                        ? Image.asset(
                            "assets/images/Sample_User_Icon.png",
                            height: 250,
                            width: 250,
                          )
                        : Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(_image!),
                              ),
                            )),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            icon: Icon(Icons.photo_outlined),
                            onPressed: (() => selectImageFromGallery())),
                        IconButton(
                            icon: Icon(Icons.camera_alt_outlined),
                            onPressed: (() => selectImageFromCamera())),
                      ],
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      height: 48,
                      //width: double.infinity,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(218, 226, 37, 24),
                          ),
                        ),
                        onPressed: () async {
                          String email = widget.email;
                          String username = widget.username;

                          String password = widget.password;

                          String resulat = await AuthMethods().signUpUser(
                            email: email,
                            password: password,
                            username: username,
                            file: _image!,
                          );

                          if (resulat == "success") {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Home(),
                                ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(resulat),
                            ));
                          }
                        },
                        child: Text(
                          'next',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
      ),
    );
  }
}
