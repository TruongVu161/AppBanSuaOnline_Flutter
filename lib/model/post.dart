class Post {
  String id = '';
  String title = '';
  String image = '';
  String authorName = '';
  String authorEmail = '';
  String content = '';
  int numberLike = 0;
  String createDate = '';
  String updateDate = '';

  Post(
      {required this.id,
      required this.title,
      required this.image,
      required this.authorName,
      required this.authorEmail,
      required this.content,
      required this.numberLike,
      required this.createDate,
      required this.updateDate});

  Post.fromJson(Map<String, dynamic> json){
    id = json['id'];
     title = json['title'];
     image = json['image'];
     authorName = json['author_name'];
     authorEmail = json['author_email'];
     content = json['content'];
     numberLike = json['number_like'];
     createDate = json['create_date'];
     updateDate = json['update_date'];
  }
}
