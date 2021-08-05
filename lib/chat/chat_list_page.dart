import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:spot_manager/chat/conversation_page.dart';
import 'package:spot_manager/models/models.dart';

class ChatList extends StatefulWidget {
  final Models model;

  ChatList(this.model);

  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Stream<QuerySnapshot> chatStream;

  @override
  void initState() {
    super.initState();
    widget.model.getChatRoom();
  }

  Widget listBuilder(int index, Models model) {
    model.getChatRoom();
    var _border = new Container(
      width: double.infinity,
      height: 1.0,
      color: Theme
          .of(context)
          .primaryColor,
    );
    return Column(children: [
      ListTile(
        leading: CircleAvatar(
          backgroundImage: model.chatUsers[index].profileImage != null
              ? NetworkImage(model.chatUsers[index].profileImage)
              : AssetImage('assets/profileAvatar.png'),
        ),
        title: Text(
          model.chatUsers[index].userName,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(model.chatUsers[index].email,
            style: TextStyle(fontWeight: FontWeight.w400)),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ContactUs(
                      chatRoomId: model.chatUsers[index].chatRoomId,
                      userName: model.chatUsers[index].userName,
                    ),
              ));
        },
      ),
      _border,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    widget.model.getChatRoom();
    return ScopedModelDescendant<Models>(
        builder: (context, child, Models model) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Messages'),
            ),
            body: Container(
              child: SingleChildScrollView(
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: model.chatUsers.length,
                  itemBuilder: (context, index) {
                    return model.chatUsers.length > 0
                        ? listBuilder(index, model)
                        : Container();
                  },
                ),
              ),
            ),
          );
        });
  }
}
