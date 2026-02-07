// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:folder/models/message.dart';
// import 'package:folder/widget/chat_bubble.dart';
// import 'package:folder/widget/constant.dart';
// class ChatPage extends StatelessWidget {
//    static String id = 'ChatPage';

//   CollectionReference messages =
//       FirebaseFirestore.instance.collection(kMessageCollection);

//   TextEditingController controller = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: messages.orderBy('createdAt', descending: true).snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           List<Message> messagesList = snapshot.data!.docs
//               .map((doc) => Message.fromJson(doc))
//               .toList();

//           return Scaffold(
//             appBar: AppBar(
//               automaticallyImplyLeading: false,
//               backgroundColor: kPrimaryColor,
//               title: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset(kLogo, height: 50),
//                   const SizedBox(width: 8),
//                   const Text('Chat'),
//                 ],
//               ),
//             ),
//             body: Column(
//               children: [
//                 Expanded(
//                   child: ListView.builder(
//                     reverse: true,
//                     itemCount: messagesList.length,
//                     itemBuilder: (context, index) {
//                       return ChatBubble(message: messagesList[index]);
//                     },
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: TextField(
//                     controller: controller,
//                     onSubmitted: sendMessage,
//                     decoration: InputDecoration(
//                       suffixIcon:
//                           Icon(Icons.send, color: kPrimaryColor),
//                       hintText: 'Type your message here...',
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(32),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         } else {
//           return const Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }

//   void sendMessage(String data) {
//     messages.add({
//       'message': data,
//       'createdAt': Timestamp.now(),
//     });
//     controller.clear();
//   }
// }
