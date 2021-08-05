import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:spot_manager/chat/chat_image.dart';
import 'package:spot_manager/chat/view_image.dart';
import 'package:spot_manager/models/models.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class MessageArguments {
  /// The RemoteMessage
  final RemoteMessage message;

  /// Whether this message caused the application to open.
  final bool openedApplication;

  // ignore: public_member_api_docs
  MessageArguments(this.message, this.openedApplication)
      : assert(message != null);
}

class ContactUs extends StatefulWidget {
  final String chatRoomId;
  final String userName;

  ContactUs({
    this.chatRoomId,
    this.userName,
  });

  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  Stream<QuerySnapshot> chatStream;
  TextEditingController controller;
  Models model = Models();
  File _image;
  bool _connection = false;

  @override
  void initState() {
    controller = TextEditingController();
    model.getConversations(widget.chatRoomId).then((value) {
      setState(() {
        chatStream = value;
      });
    });
    super.initState();
  }

  void _setChatImage(File image) {
    setState(() {
      _image = image;
    });
  }

  sendMessage(Models model, String chatRoomId, String senderId) {
    if (controller.text.isNotEmpty || _image != null) {
      model.addConversations(widget.chatRoomId, controller.text, chatRoomId, senderId);
      setState(() {
        controller.text = '';
      });
    }
  }

  Widget chatMessageBuilder(Models model) {
    return StreamBuilder<QuerySnapshot>(
        stream: chatStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapShot) {
          return snapShot.hasData
              ? ListView.builder(
            controller: ScrollController(keepScrollOffset: true),
            addAutomaticKeepAlives: true,
            addRepaintBoundaries: true,
            addSemanticIndexes: true,
            reverse: true,
            shrinkWrap: true,
            itemCount: snapShot.data.docs.length,
            itemBuilder: (context, index) {
              int time = snapShot.data.docs[index]['time'];
              DateTime _time = DateTime.fromMillisecondsSinceEpoch(time);
              String messageTime = '${_time.hour}:${_time.minute}';
              if (snapShot.connectionState == ConnectionState.waiting) {
                setState(() {
                  _connection = true;
                });
              }
              return MessageTile(
                time: messageTime,
                isImage:
                snapShot.data.docs[index]['chatImageUrl'] != null,
                image: snapShot.data.docs[index]['chatImageUrl'],
                message: snapShot.data.docs[index]['message'],
                sentByMe: snapShot.data.docs[index]['sender'] ==
                    model.authentication.id,
                connectionState: _connection,
              );
            },
          )
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {

    // final MessageArguments args = ModalRoute.of(context).settings.arguments;
    // RemoteMessage message = args.message;
    // RemoteNotification notification = message.notification;

    double _height = MediaQuery.of(context).size.height / 25;
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
          return Scaffold(
            appBar: AppBar(
                title: Container(
                  child: GestureDetector(
                    onTap: () {},
                    child: Text(widget.userName),
                    // child: Container(
                    //   padding: EdgeInsets.all(5),
                    //   margin: EdgeInsets.all(2),
                    //   child: CircleAvatar(
                    //     backgroundImage: widget.profileImage != null
                    //         ? NetworkImage(widget.profileImage)
                    //         : AssetImage('assets/profileAvatar.png'),
                    //   ),
                    // ),
                  )
                )
              // title: Text(widget.userName),
              // backgroundColor: Theme.of(context).primaryColor,
            ),
            body: Container(
              color: Colors.black12,
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        bottom: MediaQuery.of(context).size.width / 5.5),
                    child: chatMessageBuilder(model),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Row(
                        children: [
                          Container(
                            height: _height,
                            child: ChatImage(_setChatImage, widget.chatRoomId),
                          ),
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Theme.of(context).primaryColor,
                              ),
                              height: MediaQuery.of(context).size.height / 15,
                              padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 5),
                              child: TextField(
                                textCapitalization: TextCapitalization.sentences,
                                autocorrect: true,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                maxLines: 3,
                                autofocus: false,
                                cursorColor: Colors.white,
                                controller: controller,
                                style: TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 3),
                                  fillColor: Colors.blue,
                                  hintText: 'Message...',
                                  hintStyle: TextStyle(
                                    color: Colors.white54,
                                    textBaseline: TextBaseline.ideographic,
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(12),
                            margin: EdgeInsets.only(left: 5),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              shape: BoxShape.circle,
                            ),
                            child: GestureDetector(
                              child: Icon(
                                Icons.send_rounded,
                                color: Colors.white,
                              ),
                              onTap: () => sendMessage(model, widget.chatRoomId, 'ovSpotManager'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class MessageTile extends StatelessWidget {
  final String time;
  final bool isImage;
  final String image;
  final String message;
  final bool sentByMe;
  final bool connectionState;

  MessageTile({
    this.time,
    this.isImage,
    this.image,
    this.message,
    this.sentByMe,
    this.connectionState,
  });

  final model = Models();

  @override
  Widget build(BuildContext context) {
    // File fileImage = image != null ? File(image) : null;
    return Container(
      alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sentByMe ? 100 : 0,
          right: sentByMe ? 0 : 100),
      padding:
      EdgeInsets.only(left: sentByMe ? 0 : 12, right: sentByMe ? 12 : 0),
      child: Column(
        crossAxisAlignment:
        sentByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: sentByMe ? Theme.of(context).primaryColor : Colors.white,
              border: Border.all(
                  color: Theme.of(context).primaryColor,
                  width: 0.5,
                  style: BorderStyle.solid),
              borderRadius: sentByMe
                  ? BorderRadius.only(
                bottomLeft: Radius.circular(23),
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
              )
                  : BorderRadius.only(
                bottomRight: Radius.circular(23),
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
              ),
            ),
            padding: EdgeInsets.all(8),
            child: isImage == true
                ? connectionState
                ? Text('Connect To Internet')
                : GestureDetector(
              onDoubleTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewPicture(image),
                    ));
              },
              child: Image(
                image: NetworkImage(
                  image,
                ),
                filterQuality: FilterQuality.high,
                errorBuilder: (context, error, stackTrace) {
                  return Text('Connect To Internet');
                },
              ),
            )
                : Text(
              message,
              style: TextStyle(
                  color: sentByMe
                      ? Colors.white
                      : Theme.of(context).primaryColor,
                  fontSize: 16),
            ),
          ),
          Container(
            alignment: sentByMe ? Alignment.centerRight : Alignment.centerLeft,
            padding: EdgeInsets.only(top: 2),
            child: Text(
              '$time',
              style: TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w500,
                  color:
                  sentByMe ? Colors.black : Theme.of(context).primaryColor),
            ),
          ),
        ],
      ),
    );
  }
}
