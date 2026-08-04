import 'package:flutter/material.dart';
import 'package:figma_design/router/app_router.gr.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';
import 'Search.dart';
import 'Edit.dart';
import 'BackArrowButton.dart';

class ViewGridHeader extends StatelessWidget {
  final VoidCallback? onBoardCreated;
  const ViewGridHeader({super.key, this.onBoardCreated});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: 402,
        height: 56,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Row(
          spacing: 8,
          children: [
            Container(
              width: 330,
              height: 32,
              margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Text(
                '나의 게시판 앱',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.47,
                ),
              ),
            ),
            SizedBox(
              width: 24,
              height: 24,
              child: IconButton(
                constraints: BoxConstraints.tightFor(width: 24, height: 24),
                padding: EdgeInsets.zero,
                icon: Assets.icons.newBoard.svg(
                  width: 24, // 👈 아이콘의 가로 크기
                  height: 24, // 👈 아이콘의 세로 크기
                  fit: BoxFit.contain,
                ),
                onPressed: () async {
                  final result = await context.router.push(NewboardRoute());
                  print('[ViewGridHeader] NewboardRoute 복귀, result=$result');
                  onBoardCreated?.call();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  final VoidCallback? onWrite;
  const HomeHeader({super.key, this.onWrite});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: 402,
        height: 56,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Row(
          spacing: 8,
          children: [
            Container(
              width: 290,
              height: 32,
              margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
              child: Text(
                '나의 게시판 앱',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  height: 1.47,
                ),
              ),
            ),
            Container(
              width: 64,
              height: 24,
              child: Row(
                children: [
                  Search(),
                  SizedBox(width: 16, height: 24),
                  Edit(onPressed: onWrite),
                ],
                //24,16,24
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SigninupHeader extends StatelessWidget {
  final inorup;

  const SigninupHeader({super.key, required this.inorup});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: 402,
        height: 56,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 298,
                  height: 32,
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Row(
                    children: [
                      BackArrowButton(opacity: 0),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                Container(
                  width: 64,
                  height: 24,
                  child: Row(
                    children: [
                      Search(),
                      SizedBox(width: 16, height: 24),
                      Edit(),
                    ],
                    //24,16,24
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 258,
                height: 32,

                child: Container(
                  width: 77,
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    inorup,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.47,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  final postName;
  final VoidCallback? onEdit;
  const PostHeader({super.key, required this.postName, this.onEdit});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: 402,
        height: 56,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Stack(
          children: [
            Row(
              children: [
                Container(
                  width: 298,
                  height: 32,
                  margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                  child: Row(
                    children: [
                      BackArrowButton(opacity: 1),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                ),
                Container(
                  width: 64,
                  height: 24,
                  child: Row(
                    children: [
                      Search(),
                      SizedBox(width: 16, height: 24),
                      Edit(onPressed: onEdit),
                    ],
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 258,
                height: 32,
                child: Container(
                  width: 77,
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    postName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.47,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewboardCreateHeader extends StatelessWidget {
  final VoidCallback? onComplete;
  const NewboardCreateHeader({super.key, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 폭을 고정하면 화면이 좁을 때 오른쪽 버튼이 잘리므로 남는 공간을 차지하게 한다.
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Row(
                        children: [
                          BackArrowButton(opacity: 1),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    height: 29,
                    child: GestureDetector(
                      onTap: onComplete,
                      child: Text(
                        '완료',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.47,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 258,

                child: Container(
                  width: 77,
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    '게시판 만들기',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.47,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchHeader extends StatefulWidget {
  final TextEditingController controller;
  const SearchHeader({super.key, required this.controller});

  @override
  State<SearchHeader> createState() => _SearchHeaderState();
}

class _SearchHeaderState extends State<SearchHeader> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {
        _hasText = widget.controller.text.isNotEmpty; // 텍스트 있으면 true
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Center(
        child: Container(
          width: 402,
          height: 61,
          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFFF8F8F8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 344,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    spacing: 5,
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: Assets.icons.search.svg(
                          color: Color(0xFF6E6E73),
                          width: 18, // 👈 아이콘의 가로 크기
                          height: 18, // 👈 아이콘의 세로 크기
                          fit: BoxFit.contain,
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: widget.controller,

                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFF6E6E73),
                          ),
                          decoration: InputDecoration(
                            hintText: '공지 검색',
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 16, // 힌트 텍스트 크기
                              color: Color(0xFF6E6E73),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 38,
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      context.router.back();
                    },
                    child: Text(
                      '취소',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NewpostCreateHeader extends StatelessWidget {
  final VoidCallback? onNext;
  const NewpostCreateHeader({super.key, this.onNext});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 폭을 고정하면 화면이 좁을 때 오른쪽 버튼이 잘리므로 남는 공간을 차지하게 한다.
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Row(
                        children: [
                          BackArrowButton(opacity: 1),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    height: 29,
                    child: GestureDetector(
                      onTap: onNext,
                      child: Text(
                        '다음',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.47,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 258,

                child: Container(
                  width: 77,
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    '게시글 작성',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.47,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NewtagCreateHeader extends StatelessWidget {
  final VoidCallback? onComplete;
  const NewtagCreateHeader({super.key, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        width: double.infinity,
        height: 56,
        padding: EdgeInsets.fromLTRB(20, 8, 20, 8),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 폭을 고정하면 화면이 좁을 때 오른쪽 버튼이 잘리므로 남는 공간을 차지하게 한다.
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.fromLTRB(0, 4, 0, 4),
                      child: Row(
                        children: [
                          BackArrowButton(opacity: 1),
                          Expanded(child: SizedBox()),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 35,
                    height: 29,
                    child: GestureDetector(
                      onTap: onComplete,
                      child: Text(
                        '완료',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w400,
                          height: 1.47,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Container(
                width: 258,
                child: Container(
                  width: 77,
                  height: 32,
                  alignment: Alignment.center,
                  child: Text(
                    '태그 추가',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      height: 1.47,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
