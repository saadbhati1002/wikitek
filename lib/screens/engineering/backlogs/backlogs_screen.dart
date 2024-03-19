import 'package:flutter/material.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';

class BacklogsScreen extends StatefulWidget {
  final String? engineeringID;
  const BacklogsScreen({super.key, this.engineeringID});

  @override
  State<BacklogsScreen> createState() => _BacklogsScreenState();
}

class _BacklogsScreenState extends State<BacklogsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBarTitle(
        context: context,
        isHome: false,
        onTap: () {
          Navigator.pop(context);
        },
        isAmount: false,
        title: 'Engineering',
        subHeading: "Backlogs",
      ),
    );
  }
}
