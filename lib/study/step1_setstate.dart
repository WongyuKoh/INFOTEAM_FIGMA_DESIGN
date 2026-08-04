// ============================================================
// STEP 1. BLoC 없이 — setState 방식 (비교용 출발점)
// ============================================================
// 이게 왜 문제냐면:
//  - 상태(_count)가 위젯 안에 갇혀 있어서 다른 화면/테스트에서 못 씀
//  - 화면이 커지면 setState 호출이 사방에 흩어짐
//  - "누가 언제 상태를 바꿨는지" 추적이 안 됨
// ============================================================

import 'package:flutter/material.dart';

class Step1Page extends StatefulWidget {
  const Step1Page({super.key});

  @override
  State<Step1Page> createState() => _Step1PageState();
}

class _Step1PageState extends State<Step1Page> {
  // 👇 상태가 위젯 내부에 있다
  int _count = 0;

  void _increment() {
    setState(() {
      _count++; // 값을 직접 변경 (mutable)
    });
  }

  void _decrement() {
    setState(() {
      _count--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('STEP 1 · setState')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('상태가 위젯 안에 있음'),
            const SizedBox(height: 16),
            Text('$_count', style: const TextStyle(fontSize: 64)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FilledButton(onPressed: _decrement, child: const Text('-1')),
                const SizedBox(width: 12),
                FilledButton(onPressed: _increment, child: const Text('+1')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
