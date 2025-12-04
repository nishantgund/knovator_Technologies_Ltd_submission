import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../Controller/postListController.dart';
import 'post_detail_screen.dart';
import 'dart:ui';

class PostListScreen extends StatelessWidget {
  final PostListController controller = Get.put(PostListController());
  final ScrollController scrollController = ScrollController();

  PostListScreen() {
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
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          flexibleSpace: ClipRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.withOpacity(0.1),
                      Colors.blue.withOpacity(0.1),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
            ),
          ),
          title: Text(
            'Knovator Posts',
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
          centerTitle: true,
        ),
      ),

      body: Obx(() {

        if (controller.posts.isEmpty) {
          return ListView.builder(
            itemCount: 6,
            padding: EdgeInsets.all(16),
            itemBuilder: (_, __) => ShimmerTile(),
          );
        }

        return SafeArea(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.withOpacity(0.15),
                  Colors.blue.withOpacity(0.1),
                  Colors.transparent,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView.builder(
              controller: scrollController,
              padding: EdgeInsets.all(12),
              itemCount: controller.posts.length + (controller.allLoaded ? 0 : 1),
              itemBuilder: (context, index) {
                if (index < controller.posts.length) {
                  final post = controller.posts[index];
                  final bool unread = !post.isRead;
          
                  return GestureDetector(
                    onTap: () {
                      controller.markAsRead(post.id);
                      Get.to(() => PostDetailScreen(postId: post.id));
                    },
                    child: Container(
                      margin: EdgeInsets.only(bottom: 12),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                          child: Container(
                            padding: EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.03),
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: unread
                                    ? Colors.yellowAccent.withOpacity(0.4)
                                    : Colors.blueAccent.withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              children: [
          
                                Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: unread
                                            ? Colors.yellowAccent.withOpacity(0.7)
                                            : Colors.blueAccent.withOpacity(0.3),
                                        blurRadius: unread ? 15 : 10,
                                        spreadRadius: 1,
                                      )
                                    ],
                                  ),
                                  child: CircleAvatar(
                                    radius: 26,
                                    backgroundColor: Colors.grey[800],
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                                  ),
                                ),
          
                                SizedBox(width: 15),
          
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
          
                                      ShaderMask(
                                        shaderCallback: (bounds) =>
                                            LinearGradient(
                                              colors: unread
                                                  ? [Colors.yellow, Colors.orangeAccent]
                                                  : [Colors.purpleAccent, Colors.blueAccent],
                                            ).createShader(bounds),
                                        child: Text(
                                          'Post ID: ${post.id}',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 17,
                                            fontWeight:
                                            unread ? FontWeight.bold : FontWeight.w500,
                                          ),
                                        ),
                                      ),
          
                                      SizedBox(height: 6),
          
                                      Text(
                                        post.title,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.9),
                                          fontSize: 15,
                                          fontWeight:
                                          unread ? FontWeight.bold : FontWeight.w300,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
          
                                Icon(Icons.arrow_forward_ios, color: Colors.white54, size: 16),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  // bottom loader while loading more
                  return Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    ),
                  );
                }
              },
            ),
          ),
        );
      }),
    );
  }
}

class ShimmerTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          height: 75,
          margin: EdgeInsets.only(bottom: 18),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              ShimmerBox(width: 50, height: 50, radius: 50),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ShimmerBox(width: 120, height: 16),
                    SizedBox(height: 10),
                    ShimmerBox(width: double.infinity, height: 14),
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

/// a reusable shimmer box
class ShimmerBox extends StatelessWidget {
  final double width, height, radius;

  ShimmerBox({required this.width, required this.height, this.radius = 10});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.white12,
      highlightColor: Colors.white30,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
