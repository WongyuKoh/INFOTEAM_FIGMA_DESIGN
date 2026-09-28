import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../di/injection.dart';
import '../../widgets/Header.dart';
import '../../widgets/Input.dart';
import 'newboard_bloc.dart';

@RoutePage()
class NewboardPage extends StatelessWidget implements AutoRouteWrapper {
  const NewboardPage({super.key});

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NewboardBloc>(),
      child: this,
    );
  }

  @override
  Widget build(BuildContext context) => const _NewboardView();
}

class _NewboardView extends StatefulWidget {
  const _NewboardView();

  @override
  State<_NewboardView> createState() => _NewboardViewState();
}

class _NewboardViewState extends State<_NewboardView> {
  final TextEditingController _boardnamecontroller = TextEditingController();

  @override
  void dispose() {
    _boardnamecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<NewboardBloc, NewboardState>(
      listenWhen: (prev, curr) => prev.status != curr.status,
      listener: (context, state) {
        switch (state.status) {
          case NewboardStatus.success:
            // true 를 돌려주면 게시판 목록 화면이 그걸 보고 새로고침한다.
            context.router.maybePop(true);
          case NewboardStatus.failure:
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
          case NewboardStatus.initial:
          case NewboardStatus.submitting:
            break;
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            NewboardCreateHeader(
              onComplete: () =>
                  context.read<NewboardBloc>().submit(_boardnamecontroller.text),
            ),
            Expanded(child: Newboard(controller: _boardnamecontroller)),
          ],
        ),
      ),
    );
  }
}

class Newboard extends StatelessWidget {
  final TextEditingController controller;
  const Newboard({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16.0, left: 18.0, right: 18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [InputBox(InputBoxText: context.t.board.name, controller: controller)],
      ),
    );
  }
}
