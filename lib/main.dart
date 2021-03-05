import 'package:flutter/material.dart';
import 'package:riafy_coding_challenge_flutter/pages/home_page.dart';
import 'package:riafy_coding_challenge_flutter/services/bookmark_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UserSimplePreferences.init();
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Home Page',
      home: HomePage(),
    ),
  );
}
