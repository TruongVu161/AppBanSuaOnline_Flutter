import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AppBanSuaOnline_Flutter/view/customer/blogs/post_details_screen.dart';

import '../../../main.dart';
import '../../../model/post.dart';
import '../../../model/roles_type.dart';
import '../../../utils/common_func.dart';
import '../../../utils/image_path.dart';
import '../../../viewmodel/auth_viewmodel.dart';
import '../../../viewmodel/post_viewmodel.dart';
import 'edit_post_screen.dart';

class PostItem extends StatefulWidget {
  Post post;

  PostItem({required this.post});

  @override
  State<StatefulWidget> createState() => _PostItem();
}

class _PostItem extends State<PostItem> {
  PostViewModel postViewModel = PostViewModel();

  User? currentUser;

  @override
  void initState() {
    super.initState();
    currentUser= FirebaseAuth.instance.currentUser;
  }

  void goToPostDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PostDetailsScreen(post: widget.post)),
    );
  }

  void reloadView() {
    setState(() {});
  }

  void goToEditPostScreen() {
    Navigator.push(
      navigationKey.currentContext!,
      MaterialPageRoute(
          builder: (context) => EditPostScreen(
                post: widget.post,
              )),
    );
  }

  showDialogConfirmDeletePost() {
    Widget noButton = TextButton(
      child: Text("Không"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = TextButton(
      child: Text("Có"),
      onPressed: () {
        postViewModel.deletePost(postId: widget.post.id);
        Navigator.of(context).pop();
      },
    );

    AlertDialog alert = AlertDialog(
      content: Text("Bạn có chắc muốn xóa bài viết này?", textAlign: TextAlign.center),
      actions: [
        noButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        goToPostDetailsScreen();
      },
      child: Card(
        margin: const EdgeInsets.only(top: 8),
        color: Colors.white,
        elevation: 16,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0x0D000000), width: 1),
          borderRadius: BorderRadius.circular(0),
        ),
        shadowColor: const Color(0x33333333),
        child: Container(
          width: 120,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white10,
                spreadRadius: 0,
                blurRadius: 12.0,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 8),
                    child: CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        backgroundImage: AssetImage(ImagePath.imgLogo),
                        radius: 12,
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 8.0, top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.post.authorName,
                            style: TextStyle(color: Colors.black, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.post.createDate,
                            style: TextStyle(color: Colors.grey, fontSize: 10),
                          ),
                        ],
                      )),
                  const Spacer(),
                  postViewModel.currentUser?.email == widget.post.authorEmail
                      ? SizedBox(
                          width: 48,
                          child: TextButton(
                              onPressed: () {
                                goToEditPostScreen();
                              },
                              child: const Text(
                                "Sửa",
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
                              )),
                        )
                      : const SizedBox(),
                  ((currentUser?.email == widget.post.authorEmail) || (AuthViewModel().rolesType == RolesType.admin))
                      ? SizedBox(
                          width: 48,
                          child: TextButton(
                              onPressed: () {
                                showDialogConfirmDeletePost();
                              },
                              child: const Text(
                                "Xóa",
                                style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.normal),
                              )),
                        )
                      : const SizedBox()
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  widget.post.content,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              widget.post.image.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Image.network(
                        widget.post.image,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                      ),
                    )
                  : const SizedBox(),
              Container(
                color: Colors.white,
                child: Row(
                  children: [
                    TextButton(
                        onPressed: () {
                          CommonFunc.showToast("Tính năng sắp ra mắt.");
                        },
                        child: Image.asset(
                          ImagePath.imgHeartUnselect,
                          width: 18,
                          height: 18,
                        )),
                    const Text("0")
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
