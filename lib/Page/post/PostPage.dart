import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../api/post/post_models.dart';
import '../../widgets/Header.dart';
import '../../widgets/Post.dart';

/// 게시글 상세.
///
/// ⭐ 이 화면에는 Bloc 이 없다.
/// 표시할 [Post] 를 앞 화면에서 그대로 받아오기 때문에 불러올 것도,
/// 시간에 따라 변하는 상태도 없다. 상태가 없으면 Bloc 도 필요 없다.
@RoutePage()
class PostPage extends StatelessWidget {
  final Post postContext;

  const PostPage({super.key, required this.postContext});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          PostHeader(postName: postContext.board?.title ?? ''),
          Expanded(child: PostWidget(postContext: postContext)),
        ],
      ),
    );
  }
}
