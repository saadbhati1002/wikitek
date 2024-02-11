import 'package:flutter/material.dart';
import 'package:wikitek/utility/colors.dart';

class ComingSoonWidget extends StatefulWidget {
  const ComingSoonWidget({super.key});

  @override
  State<ComingSoonWidget> createState() => _ComingSoonWidgetState();
}

class _ComingSoonWidgetState extends State<ComingSoonWidget> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Coming Soon",
          style: TextStyle(
              fontSize: 14,
              color: ColorConstant.blackColor,
              fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}
