import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';

import '../model/post_model.dart';

class RTDBService {
  static final database = FirebaseDatabase.instance.ref();

  static Future<Stream<DatabaseEvent>> addPost(Post post) async {
    database.child("posts").push().set(post.toJson());
    return database.onChildAdded;
  }

  static Future<List<Post>> getPost() async {
    List<Post> items = [];
    Query query = database.ref.child("posts");
    DatabaseEvent event = await query.once();
    var snapshot = event.snapshot;
    for (var child in snapshot.children) {
      var jsonPost = jsonEncode(child.value);
      Map<String, dynamic> map = jsonDecode(jsonPost);
      var post = Post(
        firstName: map['firstName'],
        lastName: map['lastName'],
        content: map['content'],
        date: map['date'],
      );
      items.add(post);
    }
    return items;
  }
}
