import 'dart:developer';
import 'package:flutter/material.dart';
import 'new_chat_option.dart';
import 'package:flutter_design/screens/chatscreen.dart';

class MessagingApp extends StatelessWidget {
  const MessagingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
        children: [
          buildStorySection(),
          const SizedBox(
            height: 50,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Chats',
                    style: TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.more_horiz_sharp,
                      size: 25,
                      color: Colors.black,
                    ),
                    onPressed: null,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: chats.length,
              itemBuilder: (context, index) {
                final chat = chats[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const ChatScreen()),
                    );
                  },
                  child: chatWidget(chat),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: buildBottomNavigationBar(context),
    );
  }

  PreferredSizeWidget buildAppBar() {
    return AppBar(
      toolbarHeight: 70,
      title: const Text(
        'Mengobrol',
        style: TextStyle(
            fontSize: 23, color: Colors.black, fontWeight: FontWeight.w500),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.search_sharp, size: 32, color: Colors.black),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget buildStorySection() {
    final List<Map<String, String?>> stories = [
      {
        'name': 'Add Story',
        'icon': Icons.add_outlined.codePoint.toString(),
      },
      {'name': 'Terry', 'imageUrl': 'assets/images/Terry.png'},
      {'name': 'Craig', 'imageUrl': 'assets/images/Craig.png'},
      {'name': 'Roger', 'imageUrl': 'assets/images/Roger.png'},
      {'name': 'Nolan', 'imageUrl': 'assets/images/Nolan.png'},
      {'name': 'Angel Curtis', 'imageUrl': 'assets/images/AngelCurtis.png'},
      {'name': 'Zaire Dorwart', 'imageUrl': 'assets/images/ZaireDorwart.png'},
      {'name': 'Kelas Malam', 'imageUrl': 'assets/images/KelasMalam.png'},
      {'name': 'Jocelyn Gouse', 'imageUrl': 'assets/images/JocelynGouse.png'},
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: stories.map((story) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                if (story['icon'] != null)
                  Container(
                    width: 65,
                    height: 65,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      IconData(
                        int.parse(story['icon']!),
                        fontFamily: 'MaterialIcons',
                      ),
                      size: 30,
                      color: Colors.black,
                    ),
                  )
                else if (story['imageUrl'] != null)
                  Container(
                    width: 65,
                    height: 65,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage(story['imageUrl']!),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                const SizedBox(
                  height: 8,
                ),
                SizedBox(
                    width: 60,
                    child: Text(
                      story['name'] ?? '',
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget buildBottomNavigationBar(BuildContext context) {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 1),
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon:
                const Icon(Icons.home_outlined, size: 30, color: Colors.black),
            onPressed: () {},
          ),
          GestureDetector(
            onTap: () => openFloatingPopup(context),
            child: Container(
              height: 44,
              width: 180,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(40),
              ),
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add, size: 18, color: Colors.white),
                  SizedBox(width: 6),
                  Text(
                    'New Chat',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.person_4_outlined,
              size: 30,
              color: Colors.grey,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  Widget storyWidget(String name, IconData? icon, {String? imageUrl}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 7.0),
      width: 65.0,
      child: Column(
        children: [
          Container(
            width: 12.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: imageUrl != null
                  ? DecorationImage(
                      image: AssetImage(imageUrl),
                      fit: BoxFit.cover,
                    )
                  : null,
              color: Colors.white,
            ),
            child: icon != null
                ? Icon(
                    icon,
                    size: 30.0,
                    color: Colors.black,
                  )
                : null,
          ),
          const SizedBox(height: 0.0, width: 1),
          Text(
            name,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget chatWidget(Chat chat) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 5, 0, 2),
      child: GestureDetector(
        onTap: () => (context, chat) {
          log('Chat with ${chat.name} tapped!', name: 'ChatWidget');
        },
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: AssetImage(chat.avatarUrl),
            radius: 30,
          ),
          title: Text(
            chat.name,
            style: const TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.w600,
            ),
          ),
          subtitle: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(width: 0),
              if (chat.seenedMessage.isNotEmpty)
                messageStatusIcon(Icons.done_all, Colors.amber),
              if (chat.sentMessage.isNotEmpty && chat.seenedMessage.isEmpty)
                messageStatusIcon(Icons.done_all, Colors.black),
              Expanded(
                child: Text(
                  chat.lastMessage.isNotEmpty
                      ? chat.lastMessage
                      : chat.sentMessage.isNotEmpty
                          ? chat.sentMessage
                          : chat.seenedMessage.isNotEmpty
                              ? chat.seenedMessage
                              : chat.groupMessage,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: chat.unreadMessages > 0
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                chat.time,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 7),
              if (chat.unreadMessages > 0)
                CircleAvatar(
                  radius: 11,
                  backgroundColor: Colors.orange[300],
                  child: Text(
                    chat.unreadMessages.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget messageStatusIcon(IconData icon, Color color) {
  return Icon(icon, size: 20, color: color);
}

class Chat {
  final String name;
  final String lastMessage;
  final String sentMessage;
  final String groupMessage;
  final String seenedMessage;
  final String time;
  final String avatarUrl;
  final int unreadMessages;

  Chat({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.avatarUrl,
    required this.sentMessage,
    required this.groupMessage,
    required this.seenedMessage,
    this.unreadMessages = 0,
  });
}

List<Chat> chats = [
  Chat(
    name: 'Angel Curtis',
    lastMessage: 'Please help me find a good monitor for...',
    sentMessage: "",
    groupMessage: '',
    seenedMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/AngelCurtis.png',
    unreadMessages: 2,
  ),
  Chat(
    name: 'Zaire Dorwart',
    lastMessage: '',
    sentMessage: ' Gacorr pisan kang',
    groupMessage: '',
    seenedMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/ZaireDorwart.png',
  ),
  Chat(
    name: 'Kelas Malam',
    lastMessage: 'Bima : No one can come today?',
    sentMessage: '',
    groupMessage: '',
    seenedMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/KelasMalam.png',
    unreadMessages: 2,
  ),
  Chat(
    name: 'Jocelyn Gouse',
    lastMessage: '',
    sentMessage: '',
    seenedMessage: '',
    groupMessage: "You're now an admin",
    time: '02:11',
    avatarUrl: 'assets/images/JocelynGouse.png',
  ),
  Chat(
    name: 'Jaylon Dias',
    lastMessage: '',
    seenedMessage: ' Buy back 10k gallons, top up credit, b...',
    sentMessage: '',
    groupMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/JaylonDias.png',
  ),
  Chat(
    name: 'Chance Rhiel Madsen',
    lastMessage: 'Thank you mate!',
    seenedMessage: '',
    sentMessage: '',
    groupMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/ChanceRhielMadsen.png',
    unreadMessages: 2,
  ),
  Chat(
    name: 'Roger',
    lastMessage: 'Please help me find a good monitor for...',
    seenedMessage: '',
    sentMessage: '',
    groupMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/Roger.png',
    unreadMessages: 2,
  ),
  Chat(
    name: 'Nolan',
    lastMessage: '',
    seenedMessage: ' Gacor pisan kang',
    sentMessage: '',
    groupMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/Nolan.png',
  ),
  Chat(
    name: 'Terry',
    lastMessage: '',
    seenedMessage: '',
    sentMessage: ' Please help me find a good monitor for...',
    groupMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/Terry.png',
    unreadMessages: 2,
  ),
  Chat(
    name: 'Craig',
    lastMessage: '',
    seenedMessage: '',
    sentMessage: ' Gacor pisan kang',
    groupMessage: '',
    time: '02:11',
    avatarUrl: 'assets/images/Craig.png',
  ),
];
