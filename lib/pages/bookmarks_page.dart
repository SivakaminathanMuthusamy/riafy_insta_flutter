import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:riafy_coding_challenge_flutter/pages/comments_page.dart';
import 'package:riafy_coding_challenge_flutter/services/api_service.dart';
import 'package:riafy_coding_challenge_flutter/services/bookmark_service.dart';

class BookmarksPage extends StatefulWidget {
  @override
  _BookmarksPageState createState() => _BookmarksPageState();
}

class _BookmarksPageState extends State<BookmarksPage> {
  List storyData = [];
  List bookmarkData = [];
  List finalData = [];
  bool hasData = false;

  void getStoryData() async {
    bookmarkData = UserSimplePreferences.getUserIDs() ?? [];
    storyData = await APIService().getStory();
    for (int i = 0; i < bookmarkData.length; i++) {
      for (int j = 0; j < storyData.length; j++) {
        if (storyData[j]['id'] == bookmarkData[i]) {
          finalData.add(storyData[j]);
        }
      }
    }
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
              itemCount: finalData.length,
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
                                finalData[index]['high thumbnail'],
                              ),
                            ),
                            SizedBox(
                              width: 15.0,
                            ),
                            Text(
                              finalData[index]['channelname'],
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
                            finalData[index]['high thumbnail'],
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
                                FontAwesomeIcons.solidBookmark,
                                color: Colors.white,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        RichText(
                          softWrap: true,
                          text: TextSpan(
                            text: finalData[index]['channelname'],
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
                                text: finalData[index]['title'],
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
                                  builder: (context) => CommentsPage()),
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
