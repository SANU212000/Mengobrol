import 'package:flutter/material.dart';
import 'package:flutter_design/screens/homescreen.dart';

class ChatApps extends StatelessWidget {
  const ChatApps({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: ChatScreen(),
    );
  }
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  ChatScreenState createState() => ChatScreenState();
}

class ChatScreenState extends State<ChatScreen> {
  bool isChatBarExpanded = false;
  String? replyText;
  final TextEditingController controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {'text': 'Hi, Asal', 'isMe': false, 'date': 'Today'},
    {'text': 'How do you buy "nice" stuff?', 'isMe': false, 'date': 'Today'},
    {
      'text': 'Please help me find a good monitor for design',
      'isMe': false,
      'date': 'Today'
    },
    {'text': 'Hi, Asal', 'isMe': true, 'date': 'Today',
    'repliedTo':{
      'sender':'Zaire Dorwart',
      'text':'How do you buy "nice" stuff?',
    } 
    },
    {
      'text':
          'I usually buy directly to the shop to reduce the risk Of damaged travel, and prevent any damage',
      'isMe': true,
      'date': 'Today',
      'repliedTo': {
        'sender':'Zaire Dorwart',
        'text':'Please help me find a good monitor for design'
      }, 
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage('assets/images/ZaireDorwart.png'),
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Zaire Dorwart',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                Text(
                  'Online',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam_outlined, color: Colors.black),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call_outlined, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final currentMessage = messages[index];
                final previousMessage = index > 0 ? messages[index - 1] : null;
                bool showDateHeader = previousMessage == null ||
                    previousMessage['date'] != currentMessage['date'];

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (showDateHeader)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Center(
                          child: Text(
                            currentMessage['date'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                    GestureDetector(
                      onHorizontalDragEnd: (details) {
                        if (details.primaryVelocity! > 0) {
                          setState(() {
                            replyText =
                                currentMessage['text']; 
                          });
                        }
                      },
                      child: MessageBubble(
                        text: currentMessage['text'],
                        isMe: currentMessage['isMe'],
                        repliedText: currentMessage['repliedTo']?['text'],
                        repliedTo: currentMessage['repliedTo']?['sender'],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          isChatBarExpanded ? expandedChatBar() : defaultChatBar(),
        ],
      ),
    );
  }

  Widget defaultChatBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black, size: 30),
            onPressed: () {
              print("Attach button pressed");
            },
          ),
          const SizedBox(width: 8),
          Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  isChatBarExpanded = true;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  enabled: false,
                  decoration: InputDecoration(
                    hintText: 'New Chat',
                    hintStyle: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.mic_none, color: Colors.black, size: 30),
            onPressed: () {
              print("Mic button pressed");
            },
          ),
        ],
      ),
    );
  }

  Widget expandedChatBar() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: InputBorder.none,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              print("Message sent: ${controller.text}");
              controller.clear();
            },
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final bool isMe;
  final String? repliedText;
  final String ? repliedTo;

  const MessageBubble({
    super.key,
    required this.text,
    required this.isMe,
    this.repliedText,
    this.repliedTo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.bottomLeft,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.70,
          ),
          child: Material(
            borderRadius: BorderRadius.circular(20.0),
            elevation: 0,
            color: isMe ? Colors.amber : Colors.grey.shade200,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 10, 30, 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (repliedText != null && repliedTo !=  null)
                    Container(
                      margin:  const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: const BoxDecoration(
                          border: Border(
                              left: BorderSide(
                              color: Colors.black,
                              width: 2,
                      ))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('$repliedTo',
                          style: const TextStyle(
                              fontSize: 13,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                        repliedText!,
                        style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontWeight: FontWeight.w300
                            ),
                            overflow: TextOverflow.ellipsis,
                       ),
                        ],
                      ),
                    ),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: 15.0,
                      color: isMe ? Colors.black : Colors.black,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
