import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:study_buddy/helpers/database_helper.dart';
import 'package:study_buddy/models/post.dart';
import 'package:study_buddy/widgets/post_card.dart';

class PostList extends StatefulWidget {
  const PostList({Key? key}) : super(key: key);

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  int expandedPost = -1;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: getPostStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final posts = (snapshot.data as QuerySnapshot)
                .docs
                .map((doc) => Post.fromJson(doc.data() as Map<String, dynamic>))
                .toList();

            return ListView.separated(
              shrinkWrap: true,
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return PostCard(
                  post: posts[index],
                  onTap: () {
                    setState(() {
                      if(expandedPost == index){
                        expandedPost = -1;
                      }else{
                        expandedPost = index;
                      }
                    });
                  },
                  isExpanded: index == expandedPost,
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const SizedBox(height: 20);
              },
            );
          }

          return const Text("NO POSTS FOUND");
        });
  }
}
