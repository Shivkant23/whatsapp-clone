import 'package:camera/camera.dart';
import 'package:chat_app/pages/call_screen.dart';
import 'package:chat_app/pages/chat_screen.dart';
import 'package:chat_app/pages/select_contact_page.dart';
import 'package:chat_app/pages/status_screen.dart';
import 'package:chat_app/screens/camera_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class WhatsAppHome extends StatefulWidget {
  final List<CameraDescription> cameras;
  WhatsAppHome({this.cameras});

  @override
  _WhatsAppHomeState createState() => _WhatsAppHomeState();
}

class _WhatsAppHomeState extends State<WhatsAppHome>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool showFab = true;

  @override
  void initState() {
    super.initState();

    _tabController = TabController(vsync: this, initialIndex: 1, length: 4);
    _tabController.addListener(() {
      if (_tabController.index == 1) {
        showFab = true;
      } else {
        showFab = false;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double yourWidth = width  / 5;
    return Scaffold(
      appBar: AppBar(
        title: Text("WhatsApp"),
        elevation: 0.7,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          isScrollable: true,
          tabs: <Widget>[
            Container(
                width: 30,
                // height: 30,
                alignment: Alignment.center,
                child: Icon(
                  Icons.camera_alt,
                ),
              ),
              Container(
                width: yourWidth,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("CHATS")),
              Container(
                  width: yourWidth,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("STATUS")),
              Container(
                  width: yourWidth,
                  height: 50,
                  alignment: Alignment.center,
                  child: Text("CALL")),
            // Tab(icon: Icon(Icons.camera_alt)),
            // Tab(text: "CHATS"),
            // Tab(
            //   text: "STATUS",
            // ),
            // Tab(
            //   text: "CALLS",
            // ),
          ],
        ),
        actions: <Widget>[
          Icon(Icons.search),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
          ),
          Icon(Icons.more_vert)
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          CameraPage(),
          ChatScreen(),
          StatusScreen(),
          CallsScreen(),
        ],
      ),
      floatingActionButton: showFab
          ? FloatingActionButton(
              backgroundColor: Theme.of(context).accentColor,
              child: Icon(
                Icons.message,
                color: Colors.white,
              ),
              onPressed: () async{
                // Navigator.push(
                //   context, MaterialPageRoute(
                //     builder: (_) => SelectContactPage(
                //       // userInfo: widget.userInfo,
                //     )
                //   )
                // );
                        final PermissionStatus permissionStatus = await _getPermission();
                if (permissionStatus == PermissionStatus.granted) {
                  Navigator.push(
                      context, MaterialPageRoute(builder: (context) => SelectContactPage()));
                } else {
                  //If permissions have been denied show standard cupertino alert dialog
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => CupertinoAlertDialog(
                      title: Text('Permissions error'),
                      content: Text('Please enable contacts access '
                          'permission in system settings'),
                      actions: <Widget>[
                        CupertinoDialogAction(
                          child: Text('OK'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    )
                  );
                }
              },
            )
          : null,
    );
  }

  Future<PermissionStatus> _getPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted) {
      final Map<Permission, PermissionStatus> permissionStatus =
          await [Permission.contacts].request();
      return permissionStatus[Permission.contacts] ??
          PermissionStatus.granted;
    } else {
      return permission;
    }
  }
}
