import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

/// 글쓰기 화면 하단의 사진 영역. (Figma Write - Frame 4125)
/// 좌우 10 안쪽 여백에 '사진 추가' 박스와 선택한 사진들을 10 간격으로 늘어놓는다.
class PhotoRow extends StatelessWidget {
  final VoidCallback? onAdd;

  /// base64 로 인코딩된 사진들. 서버가 이미지를 base64 로 주고받는다.
  final List<String> photos;
  final void Function(int index)? onRemove;

  const PhotoRow({
    super.key,
    this.onAdd,
    this.photos = const [],
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: PhotoAddBox.boxSize + 20, // 위아래 padding 10
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),
        itemCount: photos.length + 1,
        separatorBuilder: (_, _) => SizedBox(width: 10),
        itemBuilder: (context, index) {
          // 디자인상 고른 사진들이 먼저 오고 '사진 추가' 박스가 마지막에 온다.
          if (index == photos.length) return PhotoAddBox(onTap: onAdd);
          return PhotoItem(
            base64Image: photos[index],
            onRemove: onRemove == null ? null : () => onRemove!(index),
          );
        },
      ),
    );
  }
}

/// 선택한 사진 한 장. (Figma Write - PhotoItem)
/// 사진 위 오른쪽 위에 삭제 버튼이 겹쳐진다.
class PhotoItem extends StatelessWidget {
  final String base64Image;
  final VoidCallback? onRemove;

  const PhotoItem({super.key, required this.base64Image, this.onRemove});

  @override
  Widget build(BuildContext context) {
    final Uint8List? bytes = decodeBase64Image(base64Image);

    return SizedBox(
      width: PhotoAddBox.boxSize,
      height: PhotoAddBox.boxSize,
      child: Stack(
        children: [
          Positioned.fill(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: bytes == null
                  ? ColoredBox(color: Color(0xFFE5E5E5))
                  : Image.memory(bytes, fit: BoxFit.cover),
            ),
          ),
          Positioned(
            top: 6,
            right: 6,
            child: GestureDetector(
              onTap: onRemove,
              child: Container(
                width: 26,
                height: 26,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.cancel, size: 24, color: Color(0xFF3E3E3E)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// base64 문자열을 이미지 바이트로 되돌린다. 형식이 잘못되면 null.
Uint8List? decodeBase64Image(String value) {
  try {
    // 'data:image/png;base64,...' 형태로 들어오는 경우도 있어 앞부분을 떼어낸다.
    final commaIndex = value.indexOf(',');
    final payload = value.startsWith('data:') && commaIndex != -1
        ? value.substring(commaIndex + 1)
        : value;
    return base64Decode(payload);
  } catch (_) {
    return null;
  }
}

/// '사진 추가' 점선 박스. (Figma Write - Frame 4011)
class PhotoAddBox extends StatelessWidget {
  static const double boxSize = 140;

  final VoidCallback? onTap;

  const PhotoAddBox({super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: CustomPaint(
        painter: DashedBorderPainter(),
        child: SizedBox(
          width: boxSize,
          height: boxSize,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 5,
            children: [
              Icon(
                Icons.add_photo_alternate_outlined,
                size: 50,
                color: Color(0xFF6E6E73),
              ),
              Text(
                '사진 추가',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF6E6E73),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// 둥근 사각형을 점선으로 그린다. (Flutter 기본 Border 는 점선을 지원하지 않는다)
class DashedBorderPainter extends CustomPainter {
  final Color color;
  final double radius;
  final double strokeWidth;
  final double dashLength;
  final double gapLength;

  const DashedBorderPainter({
    this.color = const Color(0xFFB3B3B3),
    this.radius = 10,
    this.strokeWidth = 2,
    this.dashLength = 10,
    this.gapLength = 4,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;
    // 테두리가 안쪽에 그려지도록 선 두께의 절반만큼 줄인다. (Figma: alignment inside)
    final inset = strokeWidth / 2;
    final border = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(
            inset,
            inset,
            size.width - strokeWidth,
            size.height - strokeWidth,
          ),
          Radius.circular(radius - inset),
        ),
      );

    for (final metric in border.computeMetrics()) {
      double start = 0;
      while (start < metric.length) {
        final end = (start + dashLength).clamp(0.0, metric.length);
        canvas.drawPath(metric.extractPath(start, end), paint);
        start = end + gapLength;
      }
    }
  }

  @override
  bool shouldRepaint(covariant DashedBorderPainter oldDelegate) =>
      oldDelegate.color != color ||
      oldDelegate.radius != radius ||
      oldDelegate.strokeWidth != strokeWidth ||
      oldDelegate.dashLength != dashLength ||
      oldDelegate.gapLength != gapLength;
}
