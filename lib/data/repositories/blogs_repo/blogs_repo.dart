
import 'dart:io';

import '../../../model/post.dart';

abstract class BlogsRepo {
  Future<List<Post>> getAllPost();
  Future<bool> addPost({required Post post, required File? imageFile});
  Future<bool> updatePost({required Post post, required File? imageFile});
  Future<bool> deletePost({required String postId});
}