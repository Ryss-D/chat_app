import 'package:chat_app/widgets/chat/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chat')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: ((ctx, AsyncSnapshot<QuerySnapshot> chatSnapshot) {
        if (chatSnapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        return ListView.builder(
          reverse: true,
          itemCount: chatSnapshot.requireData.docs.length,
          itemBuilder: (ctx, index) => MessageBubble(
            message: chatSnapshot.requireData.docs[index]['text'],
            isMe: chatSnapshot.requireData.docs[index]['userId'] ==
                FirebaseAuth.instance.currentUser?.uid,
            key: ValueKey(chatSnapshot.requireData.docs[index].id),
          ),
        );
      }),
    );
  }
}
