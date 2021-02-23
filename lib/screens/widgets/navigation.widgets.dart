import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class Nav extends StatelessWidget {
  final int index;
  const Nav({Key key, this.index}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var iconList = <IconData>[
      Icons.home_outlined,
      Icons.format_list_bulleted,
      Icons.search,
    ];
    return AnimatedBottomNavigationBar(
      icons: iconList,
      backgroundColor: Color(0XFF373A36),
      gapLocation: GapLocation.none,
      activeIndex: index,
      onTap: (index) {
        print(index);
      },
    );
  }
}

