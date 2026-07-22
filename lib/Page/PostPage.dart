import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';
import '../widgets/Input.dart';
import '../widgets/Navigator.dart';
import '../widgets/Header.dart';
import '../widgets/Tag.dart';

@RoutePage()
class PostPage extends StatefulWidget {
  const PostPage({super.key});

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
          PostHeader(postName: '게시글 이름',),
          Expanded(
            child: Post(),
          ),
        ]
      ),
    );
  }
}
class Post extends StatelessWidget {
  const Post({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 338,
        padding: EdgeInsets.only(
          top: 24.0,    // 위쪽 여백
        ),
        child: Column(
          spacing: 24,
          children: [
            Container(
              child: Column(
                spacing: 10,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 37,
                    
                    child: Text(
                      '게시글 제목',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 25,
                        height: 1.47,
                      ),
                    ),
                  ),
                  Container(
                    height: 18,
                    child: Row(
                      spacing: 20,
                      children: [
                        Text(
                          '고원규',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 1.47,
                            color: Color(0xFF979797),
                          ),
                        ),
                        Text(
                          '2026.04.29',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            height: 1.47,
                            color: Color(0xFF979797),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 26,
                    child: Row(
                      spacing: 8,
                      children: [
                        Tag(tagText: '일상',),
                        Tag(tagText: '행복',),
                        Tag(tagText: '감사',),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child : Assets.images.logo.image(
                  width: 338,
                  height: 191,
                  fit: BoxFit.fitWidth,
                ),
              )
            ),
            Container(
              child: Text(
                '''오늘 아침에 일어나자마자 창밖을 봤는데, 하늘이 분홍색이랑 주황색으로 물들어 있었어요. \n사진으로는 다 담기지 않아서 아쉽지만, 기분 좋은 하루의 시작이었네요 😊 \n다들 좋은 하루 보내세요!''',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 1.47,

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
