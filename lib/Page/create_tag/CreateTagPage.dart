import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repository/post_repository.dart';
import '../../repository/tag_repository.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/Header.dart';
import '../../widgets/Tag.dart';
import '../../widgets/TagCreateButton.dart';
import '../../widgets/TagInput.dart';
import 'create_tag_bloc.dart';

@RoutePage()
class CreateTagPage extends StatelessWidget implements AutoRouteWrapper {
  final String boardUuid;
  final String title;
  final String body;

  /// 글쓰기 화면에서 고른 사진들. base64 문자열이다.
  final List<String> images;

  const CreateTagPage({
    super.key,
    required this.boardUuid,
    required this.title,
    required this.body,
    this.images = const [],
  });

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      // 앞 화면에서 넘어온 글 내용을 Bloc 생성자로 그대로 넘긴다.
      create: (ctx) => CreateTagBloc(
        ctx.read<PostRepository>(),
        ctx.read<TagRepository>(),
        boardUuid: boardUuid,
        title: title,
        body: body,
        images: images,
      ),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const _CreateTagView();
}

class _CreateTagView extends StatefulWidget {
  const _CreateTagView();

  @override
  State<_CreateTagView> createState() => _CreateTagViewState();
}

class _CreateTagViewState extends State<_CreateTagView> {
  final TextEditingController _tagController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tagController.addListener(_onTextChanged);
  }

  void _onTextChanged() {
    context.read<CreateTagBloc>().add(
      CreateTagEvent.inputChanged(_tagController.text),
    );
  }

  @override
  void dispose() {
    _tagController.removeListener(_onTextChanged);
    _tagController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        // 태그가 목록에 담기면 Bloc 이 input 을 비우므로 입력창도 같이 비운다.
        BlocListener<CreateTagBloc, CreateTagState>(
          listenWhen: (prev, curr) =>
              prev.input.isNotEmpty && curr.input.isEmpty,
          listener: (context, state) => _tagController.clear(),
        ),
        BlocListener<CreateTagBloc, CreateTagState>(
          listenWhen: (prev, curr) => prev.status != curr.status,
          listener: (context, state) {
            switch (state.status) {
              case CreateTagStatus.success:
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(const SnackBar(content: Text('게시글이 등록되었습니다')));
                context.router.popUntilRouteWithName(MyHomeRoute.name);
              case CreateTagStatus.failure:
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              case CreateTagStatus.editing:
              case CreateTagStatus.submitting:
                break;
            }
          },
        ),
      ],
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NewtagCreateHeader(
              onComplete: () => context.read<CreateTagBloc>().add(
                const CreateTagEvent.submitted(),
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: SizedBox(
                    width: 366,
                    child: Column(
                      spacing: 24,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 48,
                          child: Row(
                            spacing: 10,
                            children: [
                              TagInputBox(controller: _tagController),
                              // 입력 여부에 따라 버튼 색이 바뀌는 부분만 구독한다.
                              BlocBuilder<CreateTagBloc, CreateTagState>(
                                buildWhen: (prev, curr) =>
                                    prev.isInputEmpty != curr.isInputEmpty,
                                builder: (context, state) {
                                  return TagCreateButton(
                                    tagTextEmpty: state.isInputEmpty,
                                    onTap: () => context
                                        .read<CreateTagBloc>()
                                        .add(const CreateTagEvent.tagAdded()),
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                        BlocBuilder<CreateTagBloc, CreateTagState>(
                          buildWhen: (prev, curr) => prev.tags != curr.tags,
                          builder: (context, state) {
                            return Wrap(
                              spacing: 8,
                              runSpacing: 8,
                              children: state.tags
                                  .map((tag) => Tag(tagText: tag))
                                  .toList(),
                            );
                          },
                        ),
                      ],
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
