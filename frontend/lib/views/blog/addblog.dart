// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:frontend/model/blog.model.dart';
// import 'package:frontend/provider/blog_provider.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';

// class AddBlog extends StatefulWidget {
//   final accessToken;
//   final refreshToken;
//   AddBlog({
//     required this.accessToken,
//     required this.refreshToken,
//   });

//   @override
//   State<AddBlog> createState() => _AddBlogState();
// }

// class _AddBlogState extends State<AddBlog> {
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   XFile? image;

//   // Function to pick an image from the gallery
//   Future<void> pickImage() async {
//     try {
//       final pickedImage =
//           await ImagePicker().pickImage(source: ImageSource.gallery);
//       if (pickedImage != null) {
//         setState(() {
//           image = pickedImage;
//         });
//       } else {
//         print('Image not selected');
//       }
//     } catch (e) {
//       print('Error picking image: $e');
//     }
//   }

//   // Function to add a new blog post
//   void addNewBlog() {
//     if (titleController.text.isEmpty || descriptionController.text.isEmpty) {
//       print('Please fill all fields');
//       return;
//     }

//     if (image == null) {
//       print('Please select an image');
//       return;
//     }

//     BlogModel blog = BlogModel(
//       title: titleController.text,
//       description: descriptionController.text,
//       images: image!.path,
//     );

//     Navigator.pop(context);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Blog'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             TextField(
//               controller: titleController,
//               decoration: InputDecoration(labelText: 'Title'),
//             ),
//             SizedBox(height: 16),
//             TextField(
//               controller: descriptionController,
//               decoration: InputDecoration(labelText: 'Description'),
//             ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: pickImage,
//               child: Text('Pick Image'),
//             ),
//             SizedBox(height: 16),
//             if (image != null)
//               Image.file(
//                 File(image!.path),
//                 height: 200,
//                 fit: BoxFit.cover,
//               ),
//             SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: addNewBlog,
//               child: Text('Add Blog'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
