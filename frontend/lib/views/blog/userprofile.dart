// import 'package:flutter/material.dart';
// import 'package:frontend/views/blog/addblog.dart';

// class UserProfile extends StatefulWidget {
//   final accessToken;
//   final refreshToken;
//   UserProfile({
//     required this.accessToken,
//     required this.refreshToken,
//   });
//   @override
//   State<UserProfile> createState() => _UserProfileState();
// }

// class _UserProfileState extends State<UserProfile> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               icon: Icon(Icons.back_hand))
//         ],
//       ),
//       body: Column(
//         children: [
//           ElevatedButton(
//             onPressed: () {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => AddBlog(
//                           accessToken: widget.accessToken,
//                           refreshToken: widget.refreshToken)));
//             },
//             child: Text('add blog'),
//           ),
//           ElevatedButton(
//             onPressed: () {},
//             child: Text('user blog'),
//           ),
//         ],
//       ),
//     );
//   }
// }
