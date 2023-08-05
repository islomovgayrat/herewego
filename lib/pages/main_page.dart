import 'package:flutter/material.dart';
import 'package:herewego/service/auth_service.dart';

import '../model/post_model.dart';
import '../service/rtdb_service.dart';
import 'create_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  static const String id = 'main_page';

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  bool isLoading = false;
  List items = [];

  apiPostList() async {
    setState(() {
      isLoading = true;
    });
    var list = await RTDBService.getPost();
    items.clear();
    setState(() {
      items = list;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    apiPostList();
  }

  Future callCreatePage() async {
    Map results = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const CreatePage(),
      ),
    );
    if (results != null || results.containsKey('data')) {
      print(results['data']);
      apiPostList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        title: const Text('All Posts'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              AuthService.signOutUser(context);
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Stack(
        children: [
          ListView.builder(
            itemCount: items.length,
            itemBuilder: (ctx, index) {
              return itemOfPost(items[index]);
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : const SizedBox.shrink(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          callCreatePage();
        },
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget? itemOfPost(Post post) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            width: double.infinity,
            child: post.imgUrl != null
                ? Image.network(post.imgUrl!, fit: BoxFit.cover)
                : Image.asset(
                    'assets/images/default.jpg',
                    fit: BoxFit.cover,
                  ),
          ),
          Row(
            children: [
              Text(
                post.firstName!,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 24,
                ),
              ),
              const SizedBox(width: 5),
              Text(
                post.lastName!,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 24,
                ),
              ),
            ],
          ),
          Text(
            post.date!,
            style: const TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 16,
            ),
          ),
          Text(
            post.content!,
            style: const TextStyle(
              color: Color(0xFF4A4A4A),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
