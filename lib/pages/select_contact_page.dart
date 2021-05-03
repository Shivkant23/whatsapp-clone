import 'package:chat_app/core/models/contact_entity.dart';
import 'package:chat_app/utils/style.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SelectContactPage extends StatefulWidget {
  // final UserEntity userInfo;

  // const SelectContactPage({Key key, this.userInfo}) : super(key: key);

  @override
  _SelectContactPageState createState() => _SelectContactPageState();
}

class _SelectContactPageState extends State<SelectContactPage> {
  List<ContactEntity> contacts = [];

  @override
  void initState() {
    // BlocProvider.of<GetDeviceNumbersCubit>(context).getDeviceNumbers();
    getContacts();
    super.initState();
  }

  @override
  void dispose() { 
    contacts.clear();
    super.dispose();
  }

  Future<void> getContacts() async {
    //Make sure we already have permissions for contacts when we get to this
    //page, so we can just retrieve it
    final Iterable<Contact> _contacts = await ContactsService.getContacts();
    _contacts.forEach((element) {
      if(element.androidAccountTypeRaw.compareTo("com.whatsapp") == 0){
        contacts.add(ContactEntity(
        label: element.displayName,
        // phoneNumber: element.phones.first,
        // uid: element.uid,
        status: element.androidAccountTypeRaw,
      ));
      }
    });
    
    // contacts =_contacts;
    setState(() {
    //   contacts =_contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return (contacts != null && contacts.isNotEmpty) ? Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Select Contact"),
            Text(
              "${contacts.length} contacts",
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        actions: [
          Icon(Icons.search),
          Icon(Icons.more_vert),
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            _newGroupButtonWidget(),
            SizedBox(
              height: 10,
            ),
            _newContactButtonWidget(),
            SizedBox(
              height: 10,
            ),
            _listContact(contacts),
          ],
        ),
      ),
    ):
    Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // return BlocBuilder<GetDeviceNumbersCubit, GetDeviceNumbersState>(
    //   builder: (context, contactNumberState) {
    //     if (contactNumberState is GetDeviceNumbersLoaded) {
    //       return BlocBuilder<UserCubit, UserState>(
    //         builder: (context, userState) {
    //           if (contacts != null) {
    //             // final dbUsers = userState.users
    //             //     .where((user) => user.uid != widget.userInfo.uid)
    //             //     .toList();
    //             // contactNumberState.contacts.forEach((deviceUserNumber) {
    //             //   dbUsers.forEach(
    //             //     (dbUser) {
    //             //       if (dbUser.phoneNumber ==
    //             //           deviceUserNumber.phoneNumber.replaceAll(' ', '')) {
    //             //         contacts.add(ContactEntity(
    //             //           label: dbUser.name,
    //             //           phoneNumber: dbUser.phoneNumber,
    //             //           uid: dbUser.uid,
    //             //           status: dbUser.status,
    //             //         ));
    //             //       }
    //             //     },
    //             //   );
    //             // });
    //             return Scaffold(
    //               appBar: AppBar(
    //                 title: Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: [
    //                     Text("Select Contact"),
    //                     Text(
    //                       "${contacts.length} contacts",
    //                       style: TextStyle(fontSize: 14),
    //                     ),
    //                   ],
    //                 ),
    //                 actions: [
    //                   Icon(Icons.search),
    //                   Icon(Icons.more_vert),
    //                 ],
    //               ),
    //               body: Container(
    //                 margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
    //                 child: Column(
    //                   children: [
    //                     _newGroupButtonWidget(),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     _newContactButtonWidget(),
    //                     SizedBox(
    //                       height: 10,
    //                     ),
    //                     _listContact(contacts),
    //                   ],
    //                 ),
    //               ),
    //             );
    //           }
    //           return Scaffold(
    //             body: Center(
    //               child: CircularProgressIndicator(),
    //             ),
    //           );
    //         },
    //       );
    //     }
    //     return Container();
    //   },
    // );
  }

  Widget _newGroupButtonWidget() {
    return Container(
      child: Row(
        children: [
          Container(
            height: 45,
            width: 45,
            decoration: BoxDecoration(
                color: greenColor,
                borderRadius: BorderRadius.all(Radius.circular(40))),
            child: Icon(
              Icons.people,
              color: Colors.white,
            ),
          ),
          SizedBox(
            width: 15,
          ),
          Text(
            "New Group",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _newContactButtonWidget() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                height: 45,
                width: 45,
                decoration: BoxDecoration(
                    color: greenColor,
                    borderRadius: BorderRadius.all(Radius.circular(40))),
                child: Icon(
                  Icons.person_add,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                "New contact",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Icon(
            FontAwesomeIcons.qrcode,
            color: greenColor,
          )
        ],
      ),
    );
  }

  Widget _listContact(List<ContactEntity> contacts) {
    return Expanded(
      child: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (ctx, index) {
          return InkWell(
            onTap: () {
              // Navigator.push(context, MaterialPageRoute(
              //   builder: (_) => SingleCommunicationPage(
              //     recipientName: contacts[index].label,
              //     recipientPhoneNumber: contacts[index].phoneNumber,
              //     recipientUID: contacts[index].uid,
              //     senderName: widget.userInfo.name,
              //     senderUID: widget.userInfo.uid,
              //     senderPhoneNumber: widget.userInfo.phoneNumber,
              //   )
              // ));
              // BlocProvider.of<UserCubit>(context).createChatChannel(
              //     uid: widget.userInfo.uid, otherUid: contacts[index].uid);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Image.asset('assets/profile_default.png'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${contacts[index].label}",
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Hey there! I am Using WhatsApp Clone.",
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
