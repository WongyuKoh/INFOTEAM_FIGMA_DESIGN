import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import '../gen/assets.gen.dart';
import '../widgets/Tag.dart';
import 'dart:convert'; // base64Decode
import 'package:figma_design/domain/entity/post.dart';

class PostWidget extends StatelessWidget {
  final Post postContext;

  const PostWidget({super.key, required this.postContext});

  @override
  Widget build(BuildContext context) {
    PostUser? postUser = postContext.createdBy;

    String _formatDate(DateTime? dt) {
      if (dt == null) return '';
      final d = dt.toLocal();
      return '${d.year}.'
          '${d.month.toString().padLeft(2, '0')}.'
          '${d.day.toString().padLeft(2, '0')}';
    }

    return SingleChildScrollView(
      child: Center(
        child: Container(
          width: 338,
          padding: EdgeInsets.only(
            top: 24.0, // 위쪽 여백
            bottom: 24.0, // 아래쪽 여백 (마지막 줄이 화면 끝에 붙지 않게)
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
                        postContext.title,
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
                            postUser != null
                                ? postUser.nickname
                                : context.t.auth.userNotFound,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              height: 1.47,
                              color: Color(0xFF979797),
                            ),
                          ),
                          Text(
                            _formatDate(postContext.createdAt),
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
                    if (postContext.tags.length > 0)
                      Container(
                        height: 26,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: postContext.tags.length,
                          separatorBuilder: (_, __) => SizedBox(width: 8),
                          itemBuilder: (context, index) =>
                              Tag(tagText: postContext.tags[index]),
                        ),
                      ),
                  ],
                ),
              ),
              if (postContext.hasImage)
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.memory(
                      width: double.infinity,
                      base64Decode(postContext.thumbnailBase64!),
                    ),
                  ),
                ),
              Container(
                width: double.infinity,
                child: Text(
                  postContext.body,
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
      ),
    );
  }
}
