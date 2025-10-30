import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../Model/post_model.dart';

class PostDetailController extends GetxController {
  var post = Rxn<Post>();
  var isLoading = true.obs;

  Future<void> fetchPostDetail(int postId) async {
    try {
      isLoading(true);
      final url = Uri.parse('https://dummyjson.com/posts/$postId');
      final response = await http.get(url);

      if (response.statusCode == 200 &&
          (response.headers['content-type']?.contains('application/json') ?? false)) {
        final Map<String, dynamic> data = json.decode(response.body);
        post.value = Post.fromJson(data);
      } else {
        print('Error: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching post detail: $e');
    } finally {
      isLoading(false);
    }
  }
}
