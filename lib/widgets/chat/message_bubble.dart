import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final Key key;
  final String message;
  final String userId;
  final bool isMe;
  MessageBubble({
    required this.message,
    required this.userId,
    required this.isMe,
    required this.key,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
                bottomLeft: !isMe ? Radius.circular(0) : Radius.circular(12),
                bottomRight: isMe ? Radius.circular(0) : Radius.circular(12),
              ),
              color: isMe
                  ? Theme.of(context).backgroundColor
                  : Theme.of(context).colorScheme.secondary,
            ),
            width: 140,
            padding: EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 16,
            ),
            margin: EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Firestore automatically caches data locally
                FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                  future: FirebaseFirestore.instance
                      .collection('users')
                      .doc(userId)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text(
                        'Loading...',
                        style: TextStyle(
                          fontSize: 11,
                        ),
                      );
                    }
                    return Text(
                      snapshot.data!['username'],
                      style: TextStyle(
                        fontSize: 11,
                      ),
                    );
                  },
                ),
                Text(
                  message,
                ),
              ],
            ),
          ),
        ]);
  }
}
