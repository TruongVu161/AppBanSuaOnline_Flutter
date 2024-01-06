import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../model/post.dart';
import '../../../utils/image_path.dart';
import '../../../viewmodel/post_viewmodel.dart';
import '../../common_view/custom_button.dart';

class EditPostScreen extends StatefulWidget {
  Post post;

  EditPostScreen({required this.post});

  @override
  State<StatefulWidget> createState() => _EditPostScreen();
}

class _EditPostScreen extends State<EditPostScreen> {
  PostViewModel postViewModel = PostViewModel();
  TextEditingController titleController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  FocusNode titleFocusNode = FocusNode();
  FocusNode contentFocusNode = FocusNode();
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    loadPostData();
  }

  void loadPostData() {
    titleController.text = widget.post.title;
    contentController.text = widget.post.content;
  }

  void reloadView() {
    setState(() {});
  }

  File? _image;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    var pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            "Cập  bài viết",
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
        body: Padding(
          padding: EdgeInsets.only(left: 16, top: 8, right: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                      child: GestureDetector(
                          onTap: () async {
                            print("pick image");
                            getImage();
                          },
                          child: postImage())),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  TextFormField(
                    maxLines: null,
                    controller: titleController,
                    focusNode: titleFocusNode,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      labelText: "Tiêu đề",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 16)),
                  TextFormField(
                    maxLines: null,
                    controller: contentController,
                    focusNode: contentFocusNode,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      labelText: "Nội dung",
                      fillColor: Colors.white,
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blueAccent, width: 2.0),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.grey, width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 32)),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CustomButton(
                        onPressed: () async {
                          if (titleController.text.toString().trim().isNotEmpty &&
                              contentController.text.toString().trim().isNotEmpty) {
                            String title = titleController.text.toString().trim();
                            String content = contentController.text.toString().trim();

                            Post post = Post(
                              id: widget.post.id,
                              title: title,
                              image: widget.post.image,
                              authorName: widget.post.authorName,
                              authorEmail: widget.post.authorEmail,
                              content: content,
                              numberLike: widget.post.numberLike,
                              createDate: widget.post.createDate,
                              updateDate: DateTime.now().toString(),
                            );

                            await postViewModel.updatePost(post: post, imageFile: _image);
                            Navigator.of(context).pop();
                          } else {
                            Fluttertoast.showToast(
                                msg: "Vui lòng nhập đủ thông tin.",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.black45,
                                textColor: Colors.white,
                                fontSize: 12.0);
                          }
                        },
                        text: "Cập nhật",
                        textColor: Colors.white,
                        bgColor: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget postImage() {
    if (_image == null && widget.post.image.isEmpty) {
      return Image.asset(
        ImagePath.imgImageUpload,
        width: 64,
        height: 64,
      );
    } else {
      if (_image != null) {
        return Image.file(
          _image!,
          width: 64,
          height: 64,
        );
      } else {
        return Image.network(
          widget.post.image,
          width: 64,
          height: 64,
        );
      }
    }
  }
}
