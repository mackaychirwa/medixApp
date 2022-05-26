import 'package:flutter/material.dart';

import '../screens/chatDetailPage.dart';

class ConversationList extends StatefulWidget {
  // String name;
  // String messageText;
  // String imageUrl;
  // String time;
  bool isMessageRead;

  // String id;
  String fromUser;
  // String toUser;
  DateTime sentTime;
  String messageText;
  String status;
  ConversationList(
      {
        required this.fromUser,
        required this.sentTime,
        required this.messageText,
        required this.status,
        required this.isMessageRead

      //   required this.name,
      // required this.messageText,
      // required this.imageUrl,
      // required this.time,
      // required this.isMessageRead

      });
  @override
  _ConversationListState createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return ChatDetailPage();
            },
          ),
        );
      },
      child: Container(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Row(
                children: <Widget>[
                  const CircleAvatar(
                    backgroundImage: AssetImage("assets/images/default.png"),
                    maxRadius: 30,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  Expanded(
                    child: Container(
                      color: Colors.transparent,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            widget.fromUser,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            widget.messageText,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              fontWeight: widget.isMessageRead
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Text(
              widget.sentTime.timeZoneName,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: widget.isMessageRead
                      ? FontWeight.bold
                      : FontWeight.normal),
            ),
          ],
        ),
      ),
    );
  }
}
