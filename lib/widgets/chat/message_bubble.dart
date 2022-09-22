import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  MessageBubble({required this.message});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
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
        child: Text(
          message,
        ),
      ),
    ]);
  }
}
