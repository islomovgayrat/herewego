class Post {
  String? firstName;
  String? lastName;
  String? imgUrl;
  String? content;
  String? date;
  String? userId;

  Post({
    this.firstName,
    this.lastName,
    this.content,
    this.date,
    this.imgUrl,
    this.userId,
  });

  Post.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        imgUrl = json['imgUrl'],
        content = json['content'],
        date = json['date'],
        userId = json['userId'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'imgUrl': imgUrl,
        'content': content,
        'date': date,
        'userId': userId,
      };
}
