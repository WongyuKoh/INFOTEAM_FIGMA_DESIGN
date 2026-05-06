import 'package:figma_design/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';


class NoticeThumbnail extends StatelessWidget {

  final String noticeTitle;
  final String noticeDetail;
  final bool ImageExist;
  final String? imageUrl;

  const NoticeThumbnail({super.key, required this.noticeTitle, required this.ImageExist, this.noticeDetail = '', this.imageUrl});

  @override
  Widget build(BuildContext context) {

    var noticeform;

    switch(ImageExist){
      case false:
        noticeform = Text(
          noticeDetail,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        );
      case true:
        noticeform = imageUrl != null
          ? Image.network(
              imageUrl!,
              width: double.infinity,
              fit: BoxFit.fitWidth,
            )
          : Assets.images.logo.image(
              width: double.infinity,
              fit: BoxFit.fitWidth,
            );
    }

    return GestureDetector(
      onTap: (){
        context.router.push(PostRoute()); //
        print("asdasdasda");
      },
      child: Column(
        children: [
          Container(
            width: double.infinity,

            padding: EdgeInsets.only(
              top: 15.0,    // 위쪽 여백
              left: 14.0,   // 왼쪽 여백
              right: 14.0,  // 오른쪽 여백
              bottom: 14.0,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(
                color: Colors.blue, // 테두리 색상
                width: 2, // 테두리 두께
              ),
            ),
            child: Column(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  noticeTitle,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                noticeform,
              ],

            )
          ),
        ],
      ),
    );
  }
}