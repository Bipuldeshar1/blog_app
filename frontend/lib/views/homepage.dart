import 'package:flutter/material.dart';
import 'package:frontend/api/apiservice.dart';
import 'package:frontend/model/blog.model.dart';
import 'package:frontend/model/userModel.dart';
import 'package:frontend/provider/blog_provider.dart';
import 'package:frontend/views/blog/userprofile.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  String accessToken;
  String refreshToken;
  HomePage({
    required this.accessToken,
    required this.refreshToken,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    BlogProvider blogProvider = Provider.of<BlogProvider>(context);
    ApiService a = ApiService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('BlogApp'),
        actions: [
          IconButton(
            onPressed: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => UserProfile(
              //       accessToken: accessToken,
              //       refreshToken: refreshToken,
              //     ),
              //   ),
              // );
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: a.fetchBlog(
            widget.accessToken.toString(),
            widget.refreshToken.toString(),
          ),
          builder: (context, AsyncSnapshot<List<BlogModel>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].title),
                    subtitle: Text(snapshot.data![index].description),
                    trailing: InkWell(
                        onTap: () {
                          setState(() {
                            a.deleteBlog(
                              snapshot.data![index],
                              widget.accessToken,
                              widget.refreshToken,
                            );
                          });
                        },
                        child: Icon(Icons.delete)),
                  );
                },
              );
            } else {
              return Text('no data');
            }
          },
        ),
      ),
    );
  }
}
