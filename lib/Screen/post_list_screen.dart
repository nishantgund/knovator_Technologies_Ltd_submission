import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Controller/postListController.dart';
import 'post_detail_screen.dart';

class PostListScreen extends StatelessWidget {
  final PostListController controller = Get.put(PostListController());
  final ScrollController scrollController = ScrollController();

  PostListScreen() {
    // Detect when user scrolls to bottom
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 100 &&
          !controller.isLoadingMore &&
          !controller.allLoaded) {
        controller.fetchPosts(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Knovator Posts',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
        backgroundColor: Colors.black,
      ),
      body: Obx(() {
        if (controller.posts.isEmpty) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          controller: scrollController,
          itemCount: controller.posts.length + (controller.allLoaded ? 0 : 1),
          itemBuilder: (context, index) {
            if (index < controller.posts.length) {
              final post = controller.posts[index];
              final isRead = post.isRead;

              return Container(
                color: Colors.black,
                child: ListTile(
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  leading: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isRead ? Colors.transparent : Colors.yellow,
                        width: 3,
                      ),
                    ),
                    child: CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey[700],
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                  ),
                  title: Text(
                    'Hotel ID: ${post.id}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: isRead ? FontWeight.normal : FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  subtitle: Text(
                    post.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: isRead ? FontWeight.w200 : FontWeight.bold),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.grey,
                  ),
                  onTap: () {
                    controller.markAsRead(post.id);
                    Get.to(() => PostDetailScreen(postId: post.id));
                  },
                ),
              );
            } else {
              // Show loading indicator at the bottom
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        );
      }),
    );
  }
}
