import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../Model/post_model.dart';

class PostListController extends GetxController {
  var posts = <Post>[].obs;
  late Box<Post> postBox;

  int limit = 30;  // Number of posts per fetch
  int skip = 0;    // How many posts already loaded
  bool isLoadingMore = false;
  bool allLoaded = false;

  @override
  void onInit() {
    super.onInit();
    postBox = Hive.box<Post>('postsBox');
    loadFromHive();
    fetchPosts(); // Initial fetch
  }

  // Load posts from Hive
  void loadFromHive() {
    posts.assignAll(postBox.values.toList());
    skip = posts.length;
  }

  // Fetch posts from API with pagination
  Future<void> fetchPosts({bool loadMore = false}) async {
    if (allLoaded || isLoadingMore) return;

    if (loadMore) isLoadingMore = true;

    try {
      final url = Uri.parse('https://dummyjson.com/posts?limit=$limit&skip=$skip');
      final response = await http.get(url);

      if (response.statusCode == 200 &&
          (response.headers['content-type']?.contains('application/json') ?? false)) {
        final Map<String, dynamic> jsonBody = json.decode(response.body);
        final List<dynamic> data = jsonBody['posts'];
        final apiPosts = data.map((e) => Post.fromJson(e)).toList();

        if (apiPosts.isEmpty) {
          allLoaded = true; // No more posts to load
        } else {
          skip += apiPosts.length;

          // Save/update Hive
          for (var p in apiPosts) {
            postBox.put(p.id, p);
          }

          // Add new posts to UI
          posts.addAll(apiPosts);
        }
      } else {
        print('Server returned non-JSON or error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      if (loadMore) isLoadingMore = false;
    }
  }

  // Mark post as read
  void markAsRead(int postId) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index != -1) {
      posts[index].isRead = true;
      posts.refresh();
      postBox.put(posts[index].id, posts[index]);
    }
  }
}
