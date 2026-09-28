import 'package:figma_design/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:figma_design/i18n/strings.g.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../gen/assets.gen.dart';

class MainBottomNavigationBar extends StatefulWidget {
  final int selectedIndex;

  const MainBottomNavigationBar({super.key, required this.selectedIndex});

  @override
  State<MainBottomNavigationBar> createState() =>
      _MainBottomNavigationBarState();
}

class _MainBottomNavigationBarState extends State<MainBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.black12, width: 1.5)),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: false,
        showSelectedLabels: false,
        currentIndex: widget.selectedIndex,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black,
        elevation: 5,
        items: [
          BottomNavigationBarItem(
            icon: (widget.selectedIndex == 0
                ? Assets.icons.homeFilled.svg
                : Assets.icons.homeOutlined.svg)(width: 24, height: 24),
            label: context.t.nav.home,
          ),
          BottomNavigationBarItem(
            icon: (widget.selectedIndex == 1
                ? Assets.icons.viewGridFilled.svg
                : Assets.icons.viewGridOutlined.svg)(width: 24, height: 24),
            label: context.t.nav.dashboard,
          ),
          BottomNavigationBarItem(
            icon: (widget.selectedIndex == 2
                ? Assets.icons.profileFilled.svg
                : Assets.icons.profileOutlined.svg)(width: 24, height: 24),
            label: context.t.nav.profile,
          ),
        ],
        onTap: (int value) {
          switch (value) {
            case 0:
              if (widget.selectedIndex != value)
                context.router.push(MyHomeRoute());
            case 1:
              if (widget.selectedIndex != value)
                context.router.push(ViewGridRoute());
            case 2:
              if (widget.selectedIndex != value)
                context.router.push(ProfileRoute());
          }
        },
      ),
    );
  }
}
