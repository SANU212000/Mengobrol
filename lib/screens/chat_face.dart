import 'package:flutter/material.dart';



class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

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
  bool isChatSelected = false; 
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat UI"),
      ),
      body: Column(
        children: [
       
          Expanded(
            child: ListView(
              children: const [
                ListTile(
                  title: Text("Zaire Dorwart: Hi Asal"),
                ),
                ListTile(
                  title: Text("Zaire Dorwart: How do you buy nice stuff?"),
                ),
                ListTile(
                  title: Text("Zaire Dorwart: Please help me find a good monitor for design"),
                ),
              ],
            ),
          ),
          isChatSelected ? chatInput() : defaultChatBar(),
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
            icon: const Icon(Icons.mic, color: Colors.black54),
            onPressed: () {
              print("Mic button pressed");
            },
          ),
          const Spacer(),
          IconButton(
            icon:const Icon(Icons.chat, color: Colors.black54),
            onPressed: () {
              setState(() {
                isChatSelected = true; // Activate the chat bar
              });
            },
          ),IconButton(
            icon: const Icon(Icons.attach_file, color: Colors.black54),
            onPressed: () {
              print("Attach button pressed");
            },
          ),
        ],
      ),
    );
  }

  // When chat is activated, show text input and send button
  Widget chatInput() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Type a message...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding:const EdgeInsets.symmetric(horizontal: 16.0),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.send, color: Colors.blue),
            onPressed: () {
              // ignore: avoid_print
              print("Message sent: ${controller.text}");
              controller.clear(); // Clear input after sending message
            },
          ),
        ],
      ),
    );
  }
}







//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.all(10.0),
//       child: Column(
//         crossAxisAlignment: isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
//         children: [
//           Text(
//             sender,
//             style: TextStyle(fontSize: 12, color: Colors.black54),
//           ),
//           Material(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(isMe ? 12 : 0),
//               topRight: Radius.circular(isMe ? 0 : 12),
//               bottomLeft: Radius.circular(12),
//               bottomRight: Radius.circular(12),
//             ),
//             elevation: 5.0,
//             color: isMe ? Colors.yellow[700] : Colors.white,
//             child: Padding(
//               padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
//               child: Text(
//                 text,
//                 style: TextStyle(
//                   color: isMe ? Colors.black : Colors.black87,
//                   fontSize: 15.0,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class MessageInputField extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(8.0),
//       child: Row(
//         children: [
//           Expanded(
//             child: TextField(
//               decoration: InputDecoration(
//                 hintText: 'Type a message...',
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(30.0),
//                 ),
//                 filled: true,
//                 fillColor: Colors.grey[200],
//               ),
//             ),
//           ),
//           IconButton(
//             icon: Icon(Icons.send),
//             onPressed: () {},
//             color: Colors.blue,
//           ),
//         ],
//       ),
//     );
//   }