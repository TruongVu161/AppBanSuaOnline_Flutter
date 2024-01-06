import 'package:contained_tab_bar_view/contained_tab_bar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:AppBanSuaOnline_Flutter/view/customer/blogs/post_item.dart';

import '../../../main.dart';
import '../../../model/status.dart';
import '../../../viewmodel/post_viewmodel.dart';
import 'add_post_screen.dart';

class BlogsScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _BlogsScreen();
}

class _BlogsScreen extends State<BlogsScreen> {
  PostViewModel postViewModel = PostViewModel();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      postViewModel.getAllPost();
      postViewModel.getBlossStream.listen((status) {
        if (status == Status.loading) {
        } else if (status == Status.completed) {
          if (mounted) {
            reloadView();
          }
        } else {}
      });
    });
  }

  static void goToAddPostScreen() {
    Navigator.push(
      navigationKey.currentContext!,
      MaterialPageRoute(builder: (context) => AddPostScreen()),
    );
  }

  void reloadView() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          padding: const EdgeInsets.only(top: 76),
          child: ContainedTabBarView(
            tabBarProperties: const TabBarProperties(
                height: 24,
                indicatorColor: Colors.blueAccent,
                labelStyle: TextStyle(color: Colors.black, fontSize: 12)),
            tabs: const [
              Text('Tất cả bài viết', style: TextStyle(color: Colors.black)),
              Text('Bài viết của tôi', style: TextStyle(color: Colors.black))
            ],
            views: [allPostTab(), myPostTab()],
            onChange: (index) => print(index),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: SizedBox(
            width: 36,
            height: 36,
            child: FloatingActionButton(
              child: const Icon(Icons.add),
              backgroundColor: Colors.green,
              onPressed: () {
                goToAddPostScreen();
              },
            ),
          ),
        ));
  }

  Widget allPostTab() {
    if(postViewModel.posts.isNotEmpty){
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: postViewModel.posts.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return PostItem(post: postViewModel.posts[index]);
              },
            ),
          ),
        ],
      );
    }else{
      return const Center(child: Text("Không có bài viết."));
    }
  }

  Widget myPostTab() {
    if (postViewModel.myPosts.isNotEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: postViewModel.myPosts.length,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return PostItem(post: postViewModel.myPosts[index]);
              },
            ),
          ),
        ],
      );
    } else {
      return const Center(child: Text("Không có bài viết."));
    }
  }
}
