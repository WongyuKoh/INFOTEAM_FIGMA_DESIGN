import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';
import '../widgets/Input.dart';
import '../widgets/Navigator.dart';
import '../widgets/Header.dart';
import '../widgets/Tag.dart';
import '../widgets/Post.dart';
import '../api/post/post_models.dart';

@RoutePage()
class PostPage extends StatefulWidget {
  final Post postContext;

  const PostPage({super.key, required this.postContext});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PostHeader(postName: widget.postContext.board!.title),
          Expanded(child: PostWidget(postContext: widget.postContext)),
        ],
      ),
    );
  }
}
