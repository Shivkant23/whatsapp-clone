import 'package:flutter/material.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final String name;
  final String imageurl;

  const ProfileHeaderWidget({
    @required this.name,
    this.imageurl,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  SizedBox(
                    child: BackButton(color: Colors.white),
                    width: 30,
                  ),
                  CircleAvatar(
                    radius: 20.0,
                    backgroundImage: NetworkImage(imageurl),
                    backgroundColor: Colors.transparent,
                  ),
                ],),
                
                
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    buildIcon(Icons.videocam),
                    SizedBox(width: 12),
                    buildIcon(Icons.call),
                    SizedBox(width: 12),
                    buildIcon(Icons.more_vert),
                  ],
                ),
                SizedBox(width: 4),
              ],
            )
          ],
        ),
      );

  Widget buildIcon(IconData icon) => Container(
        padding: EdgeInsets.all(5),
        // decoration: BoxDecoration(
        //   color: Colors.white54,
        // ),
        child: Icon(icon, color: Colors.white),
      );
}
