import 'package:flutter/material.dart';
import 'package:frontend/api/apiservice.dart';
import 'package:frontend/api/likeapi.dart';
import 'package:frontend/model/blog.model.dart';
import 'package:frontend/model/userModel.dart';
import 'package:frontend/provider/blog_provider.dart';
import 'package:frontend/views/blog/userprofile.dart';
import 'package:frontend/views/widgets/cardlayot.dart';
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
    LikeApi la = LikeApi();

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
                    var data = snapshot.data![index];

                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            la.addLike(
                              data.id.toString(),
                              widget.accessToken,
                              widget.refreshToken,
                            );
                          },
                          child: CardWidget(
                            image: data.images[0],
                            userName: 'xxx',
                            title: data.title,
                            description: data.description,
                          ),
                        ),
                      ],
                    );
                  });
            } else {
              return Text('no data');
            }
          },
        ),
      ),
    );
  }
}
