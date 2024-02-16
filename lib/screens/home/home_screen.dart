import 'package:flutter/material.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/images.dart';
import 'package:wikitek/widgets/custom_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      drawer: const CustomDrawerWidget(),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: SizedBox(
                height: 30,
                width: 43,
                child: Image.asset(Images.logo),
              ),
            ),
            const Text(
              'Sales',
              style: TextStyle(
                  fontSize: 20,
                  color: ColorConstant.whiteColor,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
              width: 43,
            ),
          ],
        ),
      ),
    );
  }
}
