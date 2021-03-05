import 'dart:math';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riafy_coding_challenge_flutter/services/api_service.dart';

class CommentsPage extends StatefulWidget {
  CommentsPage({this.imagePath, this.channel, this.title});
  final String imagePath;
  final String channel;
  final String title;
  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  List commentsData = [];
  bool hasData = false;

  void getCommentsData() async {
    commentsData = await APIService().getComments();
    setState(() {
      hasData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getCommentsData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Comments'),
        actions: [
          IconButton(
            icon: Icon(FontAwesomeIcons.paperPlane),
            onPressed: () {},
          ),
        ],
      ),
      body: hasData
          ? ListView.builder(
              itemCount: commentsData.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey[700],
                    backgroundImage: AssetImage('assets/pokeball.png'),
                  ),
                  title: RichText(
                    softWrap: true,
                    text: TextSpan(
                      text: commentsData[index]['username'],
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: '  ',
                        ),
                        TextSpan(
                          text: commentsData[index]['comments'],
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 13.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        '${Random().nextInt(24)}h',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        'Reply',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      )
                    ],
                  ),
                  trailing: Icon(
                    FontAwesomeIcons.heart,
                    color: Colors.white,
                    size: 12.0,
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            ),
    );
  }
}
