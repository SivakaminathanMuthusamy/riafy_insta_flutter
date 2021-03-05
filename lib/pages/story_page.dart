import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riafy_coding_challenge_flutter/pages/comments_page.dart';
import 'package:riafy_coding_challenge_flutter/services/api_service.dart';
import 'package:riafy_coding_challenge_flutter/services/bookmark_service.dart';
import 'dart:math';

class StoryPage extends StatefulWidget {
  @override
  _StoryPageState createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  List storyData = [];
  List<String> bookmarkData = <String>[];
  bool hasData = false;
  bool isBookmarked = false;

  void getStoryData() async {
    storyData = await APIService().getStory();
    bookmarkData = UserSimplePreferences.getUserIDs() ?? [];
    setState(() {
      hasData = true;
    });
  }

  @override
  void initState() {
    super.initState();
    getStoryData();
  }

  @override
  Widget build(BuildContext context) {
    return hasData
        ? Container(
            padding: EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 10.0,
            ),
            child: ListView.builder(
              itemCount: storyData.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5.0,
                    horizontal: 0.0,
                  ),
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20.0,
                              backgroundColor: Colors.black,
                              backgroundImage: NetworkImage(
                                storyData[index]['high thumbnail'],
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              storyData[index]['channelname'],
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                                fontSize: 16.0,
                              ),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                Icons.more_vert,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5.0,
                            horizontal: 0.0,
                          ),
                          child: Image.network(
                            storyData[index]['high thumbnail'],
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              FontAwesomeIcons.heart,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Icon(
                              FontAwesomeIcons.comment,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Icon(
                              FontAwesomeIcons.paperPlane,
                              color: Colors.white,
                              size: 25.0,
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(
                                FontAwesomeIcons.bookmark,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                bookmarkData
                                    .add((storyData[index]['id']).toString());
                                await UserSimplePreferences.setUserIDs(
                                  bookmarkData,
                                );
                                print(bookmarkData);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Post Bookmarked'),
                                    action: SnackBarAction(
                                      label: 'OK',
                                      onPressed: () {},
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Text(
                          'Liked by Instagram and ${Random().nextInt(100)} others',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5.0,
                        ),
                        RichText(
                          softWrap: true,
                          text: TextSpan(
                            text: storyData[index]['channelname'],
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
                                text: storyData[index]['title'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13.0,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentsPage(
                                  imagePath: storyData[index]['high thumbnail'],
                                  channel: storyData[index]['channelname'],
                                  title: storyData[index]['title'],
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Show Comments',
                            style: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )
        : CircularProgressIndicator(
            backgroundColor: Colors.white,
          );
  }
}
