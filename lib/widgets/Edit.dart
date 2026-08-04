import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';
import '../router/app_router.gr.dart';

class Edit extends StatelessWidget {
  final VoidCallback? onPressed;
  const Edit({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: IconButton(
        constraints: BoxConstraints.tightFor(width: 24, height: 24),
        padding: EdgeInsets.zero,
        icon: Assets.icons.review.svg(width: 18, height: 18),
        onPressed: onPressed,
      ),
    );
  }
}
