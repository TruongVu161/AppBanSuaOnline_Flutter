import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../model/post.dart';
import '../../../viewmodel/auth_viewmodel.dart';

class PostDetailsScreen extends StatefulWidget {
  Post post;

  PostDetailsScreen({required this.post});

  @override
  State<StatefulWidget> createState() => _BlogsDetailsScreen();
}

class _BlogsDetailsScreen extends State<PostDetailsScreen> {
  AuthViewModel authViewModel = AuthViewModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text(
          "Chi tiết bài viết",
          style: TextStyle(color: Colors.black),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.grey,
              size: 20,
            )),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    widget.post.title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
              ),
            ),
            widget.post.image.isNotEmpty ? Image.network(
              widget.post.image,
            ):const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.post.content,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    "Đăng bởi:${widget.post.authorName}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,),
                  ),
                  const Spacer(),
                  Text(
                    "Ngày đăng:${widget.post.createDate}",
                    style: TextStyle(
                      color: Colors.black54,
                      fontSize: 10,),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
