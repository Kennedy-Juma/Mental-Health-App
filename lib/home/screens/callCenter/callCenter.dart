//
// import 'package:flutter/material.dart';
//
// import '../../../constant.dart';
// import '../notification/components/defaultAppBar.dart';
// import '../notification/components/defaultBackButton.dart';
//
// class CallCenter extends StatefulWidget {
//   CallCenter({Key? key}) : super(key: key);
//
//   @override
//   _CallCenterState createState() => _CallCenterState();
// }
//
// class _CallCenterState extends State<CallCenter> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: kWhiteColor,
//       appBar: DefaultAppBar(
//         title: "Call Center",
//         child: DefaultBackButton(),
//       ),
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           EmptySection(
//             emptyImg: callCenter,
//             emptyMsg: "We're happy to help you!",
//           ),
//           SubTitle(
//             subTitleText: "If you have Inquiry/complain about the product chat me",
//           ),
//           DefaultButton(
//             btnText: "Chat Me",
//             onPressed: () => Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) => Chat(),
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
