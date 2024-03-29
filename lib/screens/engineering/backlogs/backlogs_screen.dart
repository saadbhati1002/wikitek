import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wikitek/api/repository/engineering/engineering.dart';
import 'package:wikitek/models/engineering/backlog/backlog_model.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';
import 'package:wikitek/screens/dashboard/engineering/engineering_dashboard_screen.dart';
import 'package:wikitek/screens/engineering/backlogs/add/add_backlog_screen.dart';
import 'package:wikitek/screens/engineering/backlogs/detail/backlog_detail_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_add.dart';

import 'package:wikitek/widgets/backlog_list_widget.dart';

class BacklogsScreen extends StatefulWidget {
  const BacklogsScreen({
    super.key,
  });

  @override
  State<BacklogsScreen> createState() => _BacklogsScreenState();
}

class _BacklogsScreenState extends State<BacklogsScreen> {
  bool isLoading = false;
  List<BacklogData> backlogList = [];
  List<EngineeringData> engineeringList = [];

  @override
  void initState() {
    getLeads();
    super.initState();
  }

  getLeads() async {
    try {
      setState(() {
        isLoading = true;
      });
      engineeringList = [];
      EngineeringRes response =
          await EngineeringRepository().getEngineeringListApiCall();
      if (response.results!.isNotEmpty) {
        engineeringList = response.results!;

        await _getBackLock();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future _getBackLock() async {
    backlogList = [];
    for (int i = 0; i < engineeringList.length; i++) {
      try {
        setState(() {
          isLoading = true;
        });
        BacklogRes response = await EngineeringRepository()
            .getEngineeringBacklogApiCall(
                engineeringBacklog: engineeringList[i].id.toString());
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: titleAppBarAddTitle(
        context: context,
        onTap: () {
          Get.to(() => const EngineeringDashBoardScreen());
        },
        addFunction: () async {
          var response = await Get.to(
            () => const AddBacklogScreen(),
          );
          if (response != null) {
            _getBackLock();
          }
        },
        title: 'Engineering',
        subHeading: "Backlogs",
      ),
      body: isLoading
          ? SingleChildScrollView(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return engineeringSkelton();
                },
              ),
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
              : SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ListView.builder(
                        itemCount: backlogList.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Get.to(
                                () => BacklogDetailScreen(
                                  backlog: backlogList[index],
                                ),
                              );
                            },
                            child: backlogListWidget(
                              context: context,
                              backlogData: backlogList[index],
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
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
