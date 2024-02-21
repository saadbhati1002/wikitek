import 'package:flutter/material.dart';
import 'package:wikitek/screens/dashboard/coming_soon_widget.dart';
import 'package:wikitek/screens/home/home_screen.dart';
import 'package:wikitek/screens/invoice/invoice_list/invoice_list_screen.dart';
import 'package:wikitek/screens/sales_lead/lead_list/sales_lead_screen.dart';
import 'package:wikitek/screens/sales_order/sales_order/sales_order_list_screen.dart';
import 'package:wikitek/utility/colors.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  int _currentIndex = 0;

  final _children = const [
    HomeScreen(),
    SalesLeadScreen(),
    SalesOrderListScreen(),
    InvoiceListScreen(),
    ComingSoonWidget(),
  ];

  void onTapped(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  void initState() {
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
                  Icons.show_chart_sharp,
                  color: _currentIndex == 0
                      ? ColorConstant.mainColor
                      : ColorConstant.greyColor.withOpacity(0.4),
                  size: 30,
                ),
                label: "Sales"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.circle_rounded,
                  color: _currentIndex == 1
                      ? ColorConstant.mainColor
                      : ColorConstant.greyColor.withOpacity(0.4),
                  size: 30,
                ),
                label: "SL"),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.circle_rounded,
                color: _currentIndex == 2
                    ? ColorConstant.mainColor
                    : ColorConstant.greyColor.withOpacity(0.4),
                size: 30,
              ),
              label: "SO",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.circle_rounded,
                  color: _currentIndex == 3
                      ? ColorConstant.mainColor
                      : ColorConstant.greyColor.withOpacity(0.4),
                  size: 30,
                ),
                label: "INV"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.circle_rounded,
                  color: _currentIndex == 4
                      ? ColorConstant.mainColor
                      : ColorConstant.greyColor.withOpacity(0.4),
                  size: 30,
                ),
                label: "AR"),
          ],
        ),
      ),
    );
  }
}
