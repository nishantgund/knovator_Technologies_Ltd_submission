// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../Controller/postController.dart';
//
// class PostDetailScreen extends StatelessWidget {
//   final int postId;
//   final PostController controller = Get.find();
//
//   PostDetailScreen({required this.postId});
//
//   @override
//   Widget build(BuildContext context) {
//     final post = controller.posts.firstWhere((p) => p.id == postId);
//     return Scaffold(
//       appBar: AppBar(title: Text(post.title)),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Text(post.body),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/postDetail_controller.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  final PostDetailController controller = Get.put(PostDetailController());

  @override
  Widget build(BuildContext context) {
    // Fetch post detail on screen load
    controller.fetchPostDetail(postId);

    return Scaffold(
      backgroundColor: Colors.grey[900], // Set dark background
      appBar: AppBar(
        title: Text(
          'Post Detail',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.grey[800],
        centerTitle: false,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.white));
        }

        if (controller.post.value == null) {
          return Center(
            child: Text(
              'Failed to load post',
              style: TextStyle(color: Colors.white),
            ),
          );
        }

        final post = controller.post.value!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Title in center, bold, white
              Text(
                post.title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 12),
              Divider(color: Colors.white54),
              SizedBox(height: 8),
              // Body text
              Text(
                post.body,
                style: TextStyle(fontSize: 16, color: Colors.white70),
              ),
            ],
          ),
        );
      }),
    );
  }
}
