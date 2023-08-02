import 'package:flutter/material.dart';
import 'package:herewego/model/post_model.dart';

import '../service/auth_service.dart';
import '../service/rtdb_service.dart';

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

  createPost() {
    var firstName = firstNameController.text.toString();
    var lastName = lastNameController.text.toString();
    var content = contentController.text.toString();
    var date = dateController.text.toString();
    if (firstName.isEmpty ||
        lastName.isEmpty ||
        content.isEmpty ||
        date.isEmpty) return;

    apiCreatePost(firstName, lastName, content, date);
  }

  apiCreatePost(
      String firstName, String lastName, String content, String date) {
    setState(() {
      isLoading = true;
    });

    var post = Post(
        firstName: firstName, lastName: lastName, content: content, date: date);
    RTDBService.addPost(post).then((value) => {
          resAddPost(),
        });
  }

  resAddPost() {
    setState(() {
      isLoading = false;
    });
    Navigator.of(context).pop({'data': 'done'});
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
