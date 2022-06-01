import 'package:flutter/material.dart';

import '../classes/api/functions_api.dart';
import '../models/chatUsersModel.dart';
import '../models/chatmodel.dart';
import '../widgets/conversationList.dart';
import '../widgets/sidenav.dart';
import 'chatDetailPage.dart';

class ChatRoom extends StatefulWidget {
  // final bool isMessageRead;

  const ChatRoom({Key? key}) : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  List<ChatUsers> chatUsers = [
    ChatUsers(
        name: "Jane Russel",
        messageText: "Awesome Setup",
        image: "assets/images/profile.png",
        time: "Now",
        text: 'Jane Russel',
        imageURL: 'assets/images/profile.png',
        secondaryText: ''),
    ChatUsers(
        name: "Glady's Murphy",
        messageText: "That's Great",
        image: "profile.png",
        time: "Yesterday",
        text: '',
        imageURL: 'assets/images/profile.png',
        secondaryText: ''),
    ChatUsers(
        name: "Jorge Henry",
        messageText: "Hey where are you?",
        image: "assets/images/profile.png",
        time: "31 Mar",
        text: '',
        imageURL: 'assets/images/profile.png',
        secondaryText: ''),
    ChatUsers(
        name: "Philip Fox",
        messageText: "Busy! Call me in 20 mins",
        image: "assets/images/profile.png",
        time: "28 Mar",
        text: '',
        imageURL: 'assets/images/profile.png',
        secondaryText: ''),
    ChatUsers(
        name: "Debra Hawkins",
        messageText: "Thankyou, It's awesome",
        image: "assets/images/profile.png",
        time: "23 Mar",
        text: '',
        imageURL: 'assets/images/profile.png',
        secondaryText: ''),
    ChatUsers(
        name: "Jacob Pena",
        messageText: "will update you in evening",
        image: "assets/images/profile.png",
        time: "17 Mar",
        text: '',
        imageURL: 'assets/images/profile.png',
        secondaryText: ''),
    ChatUsers(
        name: "Andrey Jones",
        messageText: "Can you please share the file?",
        image: "assets/images/profile.png",
        time: "24 Feb",
        text: '',
        imageURL: 'assets/images/profile.png',
        secondaryText: ''),
    ChatUsers(
        name: "John Wick",
        messageText: "How are you?",
        image: "assets/images/profile.png",
        time: "18 Feb",
        text: '',
        imageURL: 'assets/images/profile.png',
        secondaryText: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 28.0,
          onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          color: Colors.black,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ),
      key: _scaffoldKey,
      drawer: const SideNav(),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildSearch(),
          _buildChatMessages(),
        ],
      ),
    );
  }

  SliverToBoxAdapter _buildSearch() {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search.......",
            hintStyle: TextStyle(color: Colors.grey.shade600),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.grey.shade600,
              size: 20,
            ),
            filled: true,
            fillColor: Colors.grey.shade100,
            contentPadding: const EdgeInsets.all(8),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Colors.grey.shade100,
              ),
            ),
          ),
        ),
      ),
    );
  }

  SliverToBoxAdapter _buildChatMessages() {
    return SliverToBoxAdapter(
      child: FutureBuilder(
          // future: fetchUserData(),
          future: fetchMessage(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              // print(snapshot);
              return ListView.builder(
                // itemCount: 2,
                itemCount: snapshot.data.length,
                // itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(top: 16),
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  ChatSelect chatSelect = snapshot.data![index];
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
                    child: ConversationList(
                      fromUser: chatUsers[index].name,
                      messageText: chatUsers[index].messageText,
                      // imageUrl: chatUsers[index].imageURL,
                      sentTime: chatSelect.sentTime,
                      isMessageRead: (index == 0 || index == 3) ? true : false,
                      status: chatSelect.status,
                    ),
                    // child: Container(
                    //   padding:
                    //   const EdgeInsets.only(left: 16, right: 16, top: 10, bottom: 10),
                    //   child: Row(
                    //     children: <Widget>[
                    //       Expanded(
                    //         child: Row(
                    //           children: <Widget>[
                    //             const CircleAvatar(
                    //               backgroundImage: AssetImage("assets/images/default.png"),
                    //               maxRadius: 30,
                    //             ),
                    //             const SizedBox(
                    //               width: 16,
                    //             ),
                    //             Expanded(
                    //               child: Container(
                    //                 color: Colors.transparent,
                    //                 child: Column(
                    //                   crossAxisAlignment: CrossAxisAlignment.start,
                    //                   children: <Widget>[
                    //                     Text(
                    //                       chatSelect.fromUser,
                    //                       style: const TextStyle(
                    //                         fontSize: 16,
                    //                       ),
                    //                     ),
                    //                     const SizedBox(
                    //                       height: 6,
                    //                     ),
                    //                     Text(
                    //                       chatSelect.messageText,
                    //                       style: TextStyle(
                    //                         fontSize: 13,
                    //                         color: Colors.grey.shade600,
                    //                         fontWeight: FontWeight.normal
                    //                             // ? FontWeight.bold
                    //                             // : FontWeight.normal,
                    //                       ),
                    //                     ),
                    //                   ],
                    //                 ),
                    //               ),
                    //             ),
                    //           ],
                    //         ),
                    //       ),
                    //       Text(
                    //         chatSelect.sentTime.timeZoneName,
                    //         style: const TextStyle(
                    //             fontSize: 12,
                    //             fontWeight: FontWeight.normal
                    //                 // ? FontWeight.bold
                    //                 // : FontWeight.normal),
                    //         )
                    //       ),
                    //     ],
                    //   ),
                    // ),
                  );
                  // return ConversationList(
                  //   fromUser: chatUsers[index].name,
                  //   messageText: chatSelect.messageText,
                  //   // imageUrl: chatUsers[index].imageURL,
                  //   sentTime: chatSelect.sentTime,
                  //   isMessageRead: (index == 0 || index == 3) ? true : false,
                  //   status: chatSelect.status,
                  //
                  // );
                },
              );
            }
            return Text(snapshot.data.toString());
          }),
    );
  }
}
