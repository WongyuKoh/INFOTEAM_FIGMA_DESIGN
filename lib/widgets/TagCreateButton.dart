import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';

class TagCreateButton extends StatefulWidget {
  final bool tagTextEmpty;
  final VoidCallback? onTap;
  const TagCreateButton({super.key, required this.tagTextEmpty, this.onTap});

  @override
  State<TagCreateButton> createState() => _TagCreateButtonState();
}

class _TagCreateButtonState extends State<TagCreateButton> {
  @override
  Widget build(BuildContext context) {
    Widget Style;
    switch (widget.tagTextEmpty) {
      case true:
        Style = Container(
          height: double.infinity,
          width: 68,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Color(0xFFF5F5F7),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            context.t.common.add,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: Color(0xFFB3B3B3),
              fontSize: 16,
              height: 1,
            ),
          ),
        );

      case false:
        Style = GestureDetector(
          onTap: widget.onTap,
          child: Container(
            height: double.infinity,
            width: 68,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Color(0xFFFF4500),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              context.t.common.add,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: Color(0xFFFFFFFF),
                fontSize: 15,
                height: 1,
              ),
            ),
          ),
        );

      default:
        throw UnimplementedError('no widget for  islogin');
    }
    return Style;
  }
}
