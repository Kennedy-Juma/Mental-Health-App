// import 'package:flutter/material.dart';
// import 'package:flutter_tawk/flutter_tawk.dart';
//
// class Message extends StatefulWidget {
//   Message({Key? key}) : super(key: key);
//
//   @override
//   _MessageState createState() => _MessageState();
// }
//
// class _MessageState extends State<Message>  {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Customer Support'),
//           backgroundColor: const Color(0XFF233C54),
//           elevation: 0,
//         ),
//         body: Tawk(
//           directChatLink: 'https://tawk.to/chat/65169da710c0b2572486c18f/1hbg5flog',
//           visitor: TawkVisitor(
//             name: 'Said Mohammed',
//             email: 'odnyukaa@gmail.com',
//           ),
//           onLoad: () {
//             print('Hello, Said Mohammed!');
//           },
//           onLinkTap: (String url) {
//             print(url);
//           },
//           placeholder: const Center(
//             child: Text('Loading...'),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
