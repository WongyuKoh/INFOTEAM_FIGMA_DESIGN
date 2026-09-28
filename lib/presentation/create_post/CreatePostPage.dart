import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../router/app_router.gr.dart';
import '../../widgets/Header.dart';
import '../../widgets/PhotoAdd.dart';
import '../../widgets/PostInput.dart';
import 'create_post_bloc.dart';

@RoutePage()
class CreatePostPage extends StatelessWidget implements AutoRouteWrapper {
  final String boardUuid;

  const CreatePostPage({super.key, required this.boardUuid});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(create: (_) => getIt<CreatePostBloc>(), child: this);
  }

  @override
  Widget build(BuildContext context) => _CreatePostView(boardUuid: boardUuid);
}

class _CreatePostView extends StatefulWidget {
  const _CreatePostView({required this.boardUuid});

  final String boardUuid;

  @override
  State<_CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<_CreatePostView> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  void _goToTagPage() {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.t.post.titleRequired)));
      return;
    }
    context.router.push(
      CreateTagRoute(
        boardUuid: widget.boardUuid,
        title: _titleController.text,
        body: _bodyController.text,
        images: List.of(context.read<CreatePostBloc>().state.images),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CreatePostBloc, CreatePostState>(
      listenWhen: (prev, curr) =>
          curr.errorMessage.isNotEmpty &&
          prev.errorMessage != curr.errorMessage,
      listener: (context, state) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        context.read<CreatePostBloc>().errorShown();
      },
      child: Scaffold(
        backgroundColor: const Color(0xFFF8F8F8),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NewpostCreateHeader(onNext: _goToTagPage),
            Expanded(
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 제목/본문은 좌우 18, 사진 줄은 좌우 10 이라 여백을 따로 준다.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: PostTitleInput(controller: _titleController),
                    ),
                    const SizedBox(height: 17),
                    // 본문은 제목과 사진 영역 사이의 남은 공간을 모두 차지한다.
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: PostBodyInput(controller: _bodyController),
                      ),
                    ),
                    // 사진 목록만 Bloc 상태를 구독한다.
                    BlocBuilder<CreatePostBloc, CreatePostState>(
                      buildWhen: (prev, curr) => prev.images != curr.images,
                      builder: (context, state) {
                        final bloc = context.read<CreatePostBloc>();
                        return PhotoRow(
                          photos: state.images,
                          onAdd: () => bloc.requestPhotos(),
                          onRemove: (index) => bloc.removePhoto(index),
                        );
                      },
                    ),
                    // 네이티브 카메라로 촬영해서 바로 첨부.
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton.icon(
                          onPressed: () =>
                              context.read<CreatePostBloc>().capturePhoto(),
                          icon: const Icon(Icons.photo_camera_outlined),
                          label: Text(context.t.post.capture),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
