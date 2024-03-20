import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wikitek/api/repository/enginnering/engineering.dart';
import 'package:wikitek/models/engineering/backlog/backlog_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/backlog_list_widget.dart';

class BacklogsScreen extends StatefulWidget {
  final String? engineeringID;
  const BacklogsScreen({super.key, this.engineeringID});

  @override
  State<BacklogsScreen> createState() => _BacklogsScreenState();
}

class _BacklogsScreenState extends State<BacklogsScreen> {
  bool isLoading = false;
  List<BacklogData> backlogList = [];
  @override
  void initState() {
    _getBackLock();
    super.initState();
  }

  _getBackLock() async {
    try {
      setState(() {
        isLoading = true;
      });
      BacklogRes response = await EngineeringRepository()
          .getEngineeringBacklogApiCall(
              engineeringBacklog: widget.engineeringID);
      if (response.results != null) {
        for (int backlogCount = 0;
            backlogCount < response.results!.length;
            backlogCount++) {
          if (response.results![backlogCount].backlogId != null &&
              response.results![backlogCount].backlogId != '' &&
              response.results![backlogCount].backlogId != "null") {
            backlogList.add(response.results![backlogCount]);
          }
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

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
      body: isLoading
          ? ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              itemCount: 10,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return engineeringSkelton();
              },
            )
          : backlogList.isEmpty
              ? SizedBox(
                  height: MediaQuery.of(context).size.height * .77,
                  child: const Center(
                    child: Text(
                      "No Backlog Found",
                      style: TextStyle(
                          fontSize: 16,
                          color: ColorConstant.blackColor,
                          fontFamily: "roboto",
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: backlogList.length,
                  shrinkWrap: true,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return backlogListWidget(
                      context: context,
                      backlogData: backlogList[index],
                    );
                  },
                ),
    );
  }

  Widget engineeringSkelton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.9, color: ColorConstant.mainColor),
          ),
          child: SkeletonTheme(
            themeMode: ThemeMode.light,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: 100, width: MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }
}
