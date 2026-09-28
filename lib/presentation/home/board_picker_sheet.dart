import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:figma_design/domain/entity/board.dart';
import '../../di/injection.dart';
import '../board_list/board_list_bloc.dart';

/// 글을 쓸 게시판을 고르는 바텀시트를 띄우고, 고른 게시판을 돌려준다.
/// 취소(바깥 탭 / 아래로 스와이프)하면 null.
///
/// 시트 자체가 [BoardListBloc] 을 갖고 있어서, 열자마자 로딩 스피너를 보여주고
/// 목록이 도착하면 그 자리에서 리스트로 바뀐다.
Future<Board?> showBoardPickerSheet(BuildContext context) {
  // getIt 이 전역이라 BoardRepository 를 context 로 찾을 필요가 없다.
  return showModalBottomSheet<Board>(
    context: context,
    builder: (_) => BlocProvider(
      create: (_) => getIt<BoardListBloc>()..load(),
      child: const _BoardPickerSheet(),
    ),
  );
}

class _BoardPickerSheet extends StatelessWidget {
  const _BoardPickerSheet();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              context.t.home.writeSheetTitle,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          BlocBuilder<BoardListBloc, BoardListState>(
            builder: (context, state) {
              return state.when(
                // 초기 상태 — 시트를 열자마자 started 가 들어가므로 보이지 않는다.
                init: () => const SizedBox.shrink(),

                loading: () => Padding(
                  padding: EdgeInsets.all(32),
                  child: CircularProgressIndicator(),
                ),

                failure: (message) => Padding(
                  padding: const EdgeInsets.all(24),
                  child: Text(message, textAlign: TextAlign.center),
                ),

                loaded: (boards) {
                  if (boards.isEmpty) {
                    return Padding(
                      padding: EdgeInsets.all(24),
                      child: Text(context.t.home.createBoardFirst),
                    );
                  }
                  // 게시판이 많으면 시트 높이를 넘기므로 목록만 스크롤되게 한다.
                  return Flexible(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: boards.length,
                      itemBuilder: (_, index) => ListTile(
                        title: Text(boards[index].title),
                        // pop 에 넘긴 값이 showBoardPickerSheet 의 결과가 된다.
                        onTap: () => Navigator.of(context).pop(boards[index]),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
