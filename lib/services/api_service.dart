import 'package:http/http.dart';
import 'dart:convert';

class APIService {
  List storyData = [];
  List commentsData = [];

  Future<List> getStory() async {
    try {
      Response response = await get(
        'https://hiit.ria.rocks/videos_api/cdn/com.rstream.crafts?versionCode=40&lurl=Canvas%20painting%20ideas',
      );
      storyData = jsonDecode(response.body);
      //print(storyData);
      return storyData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<List> getComments() async {
    try {
      Response response = await get(
        'https://cookbookrecipes.in/test.php',
      );
      commentsData = jsonDecode(response.body);
      //print(commentsData);
      return commentsData;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
