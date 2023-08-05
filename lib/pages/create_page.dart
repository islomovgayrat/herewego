import 'dart:io';

import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';
import 'package:image_picker/image_picker.dart';

import '../service/auth_service.dart';
import '../service/logger.dart';
import '../service/rtdb_service.dart';
import '../service/stor_service.dart';

class CreatePage extends StatefulWidget {
  const CreatePage({super.key});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  var isLoading = false;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var contentController = TextEditingController();
  var dateController = TextEditingController();

  File? image;
  final picker = ImagePicker();

  createPost() {
    var firstName = firstNameController.text.toString();
    var lastName = lastNameController.text.toString();
    var content = contentController.text.toString();
    var date = dateController.text.toString();
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        content.isEmpty ||
        date.isEmpty) return;

    if (image == null) return;

    apiUploadImage(firstName, lastName, content, date);
  }

  apiUploadImage(
      String firstName, String lastName, String content, String date) {
    setState(() {
      isLoading = true;
    });
    StoreService.uploadImage(image!).then((imgUrl) => {
          apiCreatePost(firstName, lastName, content, date, imgUrl),
        });
  }

  apiCreatePost(
    String firstName,
    String lastName,
    String content,
    String date,
    String imgUrl,
  ) {
    var post = Post(
      firstName: firstName,
      lastName: lastName,
      imgUrl: imgUrl,
      content: content,
      date: date,
      userId: AuthService.currentUserId(),
    );
    RTDBService.addPost(post).then((value) {
      resAddPost();
    });
  }

  resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
  }

  //getImage from device gallery
  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        image = File(pickedFile.path);
      } else {
        LogService.e("No image selected");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text("Add Post"),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: getImage,
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: image != null
                        ? Image.file(image!, fit: BoxFit.cover)
                        : Image.asset("assets/images/instagram.jpg"),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: firstNameController,
                  decoration: const InputDecoration(
                    hintText: "FirstName",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: lastNameController,
                  decoration: const InputDecoration(
                    hintText: "Lastname",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    hintText: "Content",
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    hintText: "Date",
                  ),
                ),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    createPost();
                    print('print');
                  },
                  child: Container(
                    height: 50,
                    color: Colors.red,
                    child: const Center(
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            isLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
