import 'dart:convert';

import 'package:chat_app/widgets/chat/messages.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    FirebaseMessaging.instance.requestPermission();
    //TODO review if config is needed
    //FirebaseMessaging.instance.confiture
    //Thigs to do with messages
    //print(FirebaseMessaging.onMessage);
    //print(FirebaseMessaging.onMessageOpenedApp);
    //print(FirebaseMessaging.onBackgroundMessage((message) => print('message')));
    //also exist toher methos, one of them "oh terminated"
    //with this every change of a specific colelction, in this case chat we ewill recive notfications for this
    FirebaseMessaging.instance.subscribeToTopic('chat');
    //we could request the token onspecific devicew
    //and pass it to de db and then scope specif devices for notifications
    //ieg for chat between two people
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FlutterChat'),
        actions: [
          DropdownButton(
            icon: Icon(Icons.more_vert),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(
                        width: 8,
                      ),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              )
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      // body: StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection('chats/2teY6yHBu5DjVrvBnImT/messages')
      //       .snapshots(),
      //   builder: ((ctx, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
      //     if (streamSnapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     final documents = streamSnapshot.requireData.docs;
      //     return ListView.builder(
      //       //itemCount: documents.documents.length,
      //       itemCount: documents.length,
      //       itemBuilder: (ctx, index) => Container(
      //         padding: EdgeInsets.all(8),
      //         child: Text(documents[index]['text']),
      //       ),
      //     );
      //   }),
      // ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   child: Icon(Icons.add),
      //   onPressed: () {
      //     FirebaseFirestore.instance
      //         .collection('chats/2teY6yHBu5DjVrvBnImT/messages')
      //         .add({'text': 'This was added by clicking the button'});
      //   },
      // ),
    );
  }
}
