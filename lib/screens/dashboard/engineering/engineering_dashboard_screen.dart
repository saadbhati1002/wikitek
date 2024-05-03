import 'package:flutter/material.dart';
import 'package:wikitek/screens/engineering/backlogs/backlogs_screen.dart';
import 'package:wikitek/screens/engineering/list/engineering_list_screen.dart';
import 'package:wikitek/screens/engineering/time_sheet/user_time_sheet.dart';
import 'package:wikitek/utility/colors.dart';

class EngineeringDashBoardScreen extends StatefulWidget {
  final int? index;
  const EngineeringDashBoardScreen({super.key, this.index});

  @override
  State<EngineeringDashBoardScreen> createState() =>
      _EngineeringDashBoardScreenState();
}

class _EngineeringDashBoardScreenState
    extends State<EngineeringDashBoardScreen> {
  int _currentIndex = 0;

  final _children = const [
    EngineeringListScreen(),
    BacklogsScreen(),
    UserTimeSheetScreen(),
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  void initState() {
    if (widget.index != null) {
      _currentIndex = widget.index!;
      setState(() {});
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _children[_currentIndex],
      bottomNavigationBar: SizedBox(
        height: 60,
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: onTapped,
          currentIndex: _currentIndex,
          backgroundColor: ColorConstant.bottomSheetColor,
          unselectedItemColor: ColorConstant.greyColor.withOpacity(0.4),
          selectedItemColor: ColorConstant.mainColor,
          selectedLabelStyle: const TextStyle(
              fontFamily: "inter",
              fontWeight: FontWeight.w700,
              color: ColorConstant.mainColor,
              fontSize: 12),
          unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w400,
              color: ColorConstant.greyColor.withOpacity(0.4),
              fontSize: 12),
          items: [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: _currentIndex == 0
                      ? ColorConstant.mainColor
                      : ColorConstant.greyColor.withOpacity(0.4),
                  size: 30,
                ),
                label: "Engineering"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.circle_rounded,
                  color: _currentIndex == 1
                      ? ColorConstant.mainColor
                      : ColorConstant.greyColor.withOpacity(0.4),
                  size: 30,
                ),
                label: "Backlog"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.circle_rounded,
                color: _currentIndex == 2
                    ? ColorConstant.mainColor
                    : ColorConstant.greyColor.withOpacity(0.4),
                size: 30,
              ),
              label: "Time Sheet",
            ),
          ],
        ),
      ),
    );
  }
}
