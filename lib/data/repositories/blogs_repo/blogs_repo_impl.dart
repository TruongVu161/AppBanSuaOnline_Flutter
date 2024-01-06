import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../model/post.dart';
import '../../../utils/common_func.dart';
import 'blogs_repo.dart';

class BlogsRepoImpl with BlogsRepo {
  @override
  Future<List<Post>> getAllPost() async {
    List<Post> posts = [];
    try {
      await FirebaseFirestore.instance.collection("POSTS").get().then((querySnapshot) {
        for (var result in querySnapshot.docs) {
          posts.add(Post.fromJson(result.data()));
        }
        print("post length:${posts.length}");
      });
      return posts;
    } catch (error) {
      print("error:${error.toString()}");
    }
    return [];
  }

  @override
  Future<bool> addPost({required Post post, required File? imageFile}) async {
    //Add image storage
    if (imageFile != null) {
      // Create a storage reference from our app
      final storageRef = FirebaseStorage.instance.ref();

      try {
        var snapshot = await storageRef.child('post_images/${post.id}.jpg').putFile(imageFile);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        //Assign image path for post
        post.image = downloadUrl;

        //Add to firestore
        Map<String, dynamic> postMap = {
          "id": post.id,
          "title": post.title,
          "image": post.image,
          "author_name": post.authorName,
          "author_email": post.authorEmail,
          "content": post.content,
          "number_like": post.numberLike,
          "create_date": post.createDate,
          "update_date": post.updateDate,
        };

        FirebaseFirestore.instance.collection('POSTS').doc(post.id).set(postMap);

        return Future.value(true);
      } on FirebaseException catch (e) {
        CommonFunc.showToast("Đã có lỗi xảy ra.");
      } catch (e) {
        CommonFunc.showToast("Đã có lỗi xảy ra.");
      }
    } else {
      try {
        //Add post without image
        Map<String, dynamic> postMap = {
          "id": post.id,
          "title": post.title,
          "image": post.image,
          "author_name": post.authorName,
          "author_email": post.authorEmail,
          "content": post.content,
          "number_like": post.numberLike,
          "create_date": post.createDate,
          "update_date": post.updateDate,
        };

        FirebaseFirestore.instance.collection('POSTS').doc(post.id).set(postMap)
          ..then((value) {}).catchError((error) {
            CommonFunc.showToast("Lỗi thêm bài viết.");
            print("error:${error.toString()}");
            return Future.value(false);
          });
        return Future.value(true);
      } on FirebaseException catch (e) {
        CommonFunc.showToast("Đã có lỗi xảy ra.");
      } catch (e) {
        CommonFunc.showToast("Đã có lỗi xảy ra.");
      }
    }
    return Future.value(false);
  }

  @override
  Future<bool> updatePost({required Post post, required File? imageFile}) async {
    //Add image storage
    if (imageFile != null) {
      // Create a storage reference from our app
      final storageRef = FirebaseStorage.instance.ref();

      try {
        var snapshot = await storageRef.child('post_images/${post.id}.jpg').putFile(imageFile);
        var downloadUrl = await snapshot.ref.getDownloadURL();

        //Assign image path for product
        post.image = downloadUrl;

        //Add to firestore
        Map<String, dynamic> postMap = {
          "id": post.id,
          "title": post.title,
          "image": post.image,
          "author_name": post.authorName,
          "author_email": post.authorEmail,
          "content": post.content,
          "number_like": post.numberLike,
          "create_date": post.createDate,
          "update_date": post.updateDate,
        };

        FirebaseFirestore.instance.collection('POSTS').doc(post.id).update(postMap);

        return Future.value(true);
      } on FirebaseException catch (e) {
        CommonFunc.showToast("Đã có lỗi xảy ra.");
      } catch (e) {
        CommonFunc.showToast("Đã có lỗi xảy ra.");
      }
    } else {
      try {
        //Update post without image
        Map<String, dynamic> postMap = {
          "id": post.id,
          "title": post.title,
          "image": post.image,
          "author_name": post.authorName,
          "author_email": post.authorEmail,
          "content": post.content,
          "number_like": post.numberLike,
          "create_date": post.createDate,
          "update_date": post.updateDate,
        };

        FirebaseFirestore.instance.collection('POSTS').doc(post.id).update(postMap);
        return Future.value(true);
      } on FirebaseException catch (e) {
        CommonFunc.showToast("Đã có lỗi xảy ra.");
      } catch (e) {
        CommonFunc.showToast("Đã có lỗi xảy ra.");
      }
    }
    return Future.value(false);
  }

  @override
  Future<bool> deletePost({required String postId}) async {
    try {
      try {
        //delete image
        final storageRef = FirebaseStorage.instance.ref();
        await storageRef.child('post_images/${postId}.jpg').delete();
      } on FirebaseException catch (e) {
        print("code:${e.code},data:${e.message}");
        if (e.code == "object-not-found") {
          //delete product
          FirebaseFirestore.instance.collection('POSTS').doc(postId).delete();
          return Future.value(true);
        }
      }
      //delete product
      FirebaseFirestore.instance.collection('POSTS').doc(postId).delete();
      return Future.value(true);
    } on FirebaseException catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
      print("error:${e.toString()}");
    } catch (e) {
      CommonFunc.showToast("Đã có lỗi xảy ra.");
    }
    return Future.value(false);
  }
}
