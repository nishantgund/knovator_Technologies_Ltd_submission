import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../Controller/postDetail_controller.dart';

class PostDetailScreen extends StatelessWidget {
  final int postId;

  PostDetailScreen({required this.postId});

  final PostDetailController controller = Get.put(PostDetailController());

  @override
  Widget build(BuildContext context) {
    controller.fetchPostDetail(postId);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60),
        child: AppBar(
          automaticallyImplyLeading: true,
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

          centerTitle: true,
          title: Text(
            "Post Details",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.deepPurple.withOpacity(0.15),
                      Colors.blue.withOpacity(0.15),
                      Colors.transparent,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),

              SingleChildScrollView(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                        child: Container(
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.06),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.2),
                            ),
                          ),
                          child: Column(
                            children: [


                              Shimmer.fromColors(
                                baseColor: Colors.white24,
                                highlightColor: Colors.white54,
                                child: Container(
                                  height: 70,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: Colors.white24,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),

                              SizedBox(height: 20),

                              Shimmer.fromColors(
                                baseColor: Colors.purple.withOpacity(0.3),
                                highlightColor: Colors.blueAccent.withOpacity(0.6),
                                child: Container(
                                  height: 3,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    color: Colors.white30,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),

                              SizedBox(height: 25),

                              ...List.generate(6, (index) {
                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 8),
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.white12,
                                    highlightColor: Colors.white38,
                                    child: Container(
                                      height: 30,
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.white12,
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
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

        return Stack(
          children: [

            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.deepPurple.withOpacity(0.15),
                    Colors.blue.withOpacity(0.15),
                    Colors.transparent,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),


            SingleChildScrollView(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.06),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          children: [
                            Shimmer.fromColors(
                              baseColor: Colors.purpleAccent,
                              highlightColor: Colors.blueAccent,
                              child: Text(
                                post.title,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 28,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.3,
                                ),
                              ),
                            ),

                            SizedBox(height: 15),


                            Container(
                              height: 1.5,
                              width: 350,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [Colors.purpleAccent, Colors.blueAccent],
                                ),
                                borderRadius: BorderRadius.circular(999),
                              ),
                            ),

                            SizedBox(height: 20),


                            ShaderMask(
                              shaderCallback: (bounds) => LinearGradient(
                                colors: [
                                  Colors.white70,
                                  Colors.blueAccent.withOpacity(0.7),
                                ],
                              ).createShader(bounds),
                              child: Text(
                                post.body,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 18,
                                  height: 1.6,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.3,
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

