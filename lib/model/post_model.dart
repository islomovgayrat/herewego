class Post {
  String? firstName;
  String? lastName;
  String? content;
  String? date;

  Post({
    this.firstName,
    this.lastName,
    this.content,
    this.date,
  });

  Post.fromJson(Map<String, dynamic> json)
      : firstName = json['firstName'],
        lastName = json['lastName'],
        content = json['content'],
        date = json['date'];

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'content': content,
        'date': date,
      };
}
