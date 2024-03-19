import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wikitek/api/repository/enginnering/engineering.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/engineering_list_widget.dart';

class EngineeringListScreen extends StatefulWidget {
  const EngineeringListScreen({super.key});

  @override
  State<EngineeringListScreen> createState() => _EngineeringListScreenState();
}

class _EngineeringListScreenState extends State<EngineeringListScreen> {
  List<Client> selectedClientID = [];
  List<StatusModel> selectedStatus = [];
  List<EngineeringData> engineeringList = [];
  List<EngineeringData> allEngineeringList = [];
  List<Client> clientListForFilter = [];
  List<StatusModel> statusList = [];
  bool isLoading = false;
  int? filterIndex;

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
      allEngineeringList = [];

      clientListForFilter = [];
      EngineeringRes response =
          await EngineeringRepository().getEngineeringListApiCall();
      if (response.results!.isNotEmpty) {
        allEngineeringList = response.results!;
        engineeringList = response.results!;
        _getClient();
        _getStatus();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getClient() {
    for (int engineeringList = 0;
        engineeringList < allEngineeringList.length;
        engineeringList++) {
      if (allEngineeringList[engineeringList].client != null) {
        var contain = clientListForFilter.where((element) =>
            element.id.toString() ==
            allEngineeringList[engineeringList].client!.id.toString());
        if (contain.isEmpty) {
          clientListForFilter.add(allEngineeringList[engineeringList].client!);
        }
      }
    }
  }

  _getStatus() {
    for (int engineeringList = 0;
        engineeringList < allEngineeringList.length;
        engineeringList++) {
      if (allEngineeringList[engineeringList].status != null) {
        var contain = statusList.where((element) =>
            element.status.toString() ==
            allEngineeringList[engineeringList].status.toString());
        if (contain.isEmpty) {
          statusList.add(
            StatusModel(
                isSelected: false,
                status: allEngineeringList[engineeringList].status!),
          );
        }
      }
    }
  }

  filterEngineeringForClient() {
    engineeringList = [];
    for (int engineeringCount = 0;
        engineeringCount < allEngineeringList.length;
        engineeringCount++) {
      if (allEngineeringList[engineeringCount].client != null) {
        for (int selectedCount = 0;
            selectedCount < selectedClientID.length;
            selectedCount++) {
          if (allEngineeringList[engineeringCount].client!.id.toString() ==
              selectedClientID[selectedCount].id.toString()) {
            engineeringList.add(allEngineeringList[engineeringCount]);
          }
        }
      }
    }
    setState(() {});
  }

  filterEngineeringForStatus() {
    engineeringList = [];
    for (int engineeringCount = 0;
        engineeringCount < allEngineeringList.length;
        engineeringCount++) {
      if (allEngineeringList[engineeringCount].status != null) {
        for (int selectedCount = 0;
            selectedCount < selectedStatus.length;
            selectedCount++) {
          if (allEngineeringList[engineeringCount].status.toString() ==
              selectedStatus[selectedCount].status.toString()) {
            engineeringList.add(allEngineeringList[engineeringCount]);
          }
        }
      }
    }
    setState(() {});
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
        subHeading: "Projects",
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 45,
              color: ColorConstant.mainColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  tabBarTitle(
                    index: 0,
                    title: "By Client",
                    onTap: () {
                      filterClientBottomSheet(context: context);
                      // departmentSelected = [];
                      setState(() {
                        filterIndex = 0;
                      });
                    },
                  ),
                  tabBarTitle(
                    index: 1,
                    title: "By Status",
                    onTap: () {
                      filterStatusBottomSheet(context: context);
                      selectedClientID = [];

                      setState(() {
                        filterIndex = 1;
                      });
                    },
                  ),
                ],
              ),
            ),
            isLoading
                ? ListView.builder(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    itemCount: 10,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return engineeringSkelton();
                    },
                  )
                : engineeringList.isEmpty
                    ? SizedBox(
                        height: MediaQuery.of(context).size.height * .77,
                        child: const Center(
                          child: Text(
                            "No Leads Found",
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.blackColor,
                                fontFamily: "roboto",
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: engineeringList.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 15),
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Get.to(
                              //   () => SalesLeadDetailsScreen(
                              //     leadData: salesLead[index],
                              //   ),
                              // );
                            },
                            child: engineeringListWidget(
                              context: context,
                              engineeringData: engineeringList[index],
                            ),
                          );
                        },
                      ),
            const SizedBox(
              height: 60,
            ),
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

  Widget tabBarTitle({String? title, int? index, VoidCallback? onTap}) {
    return GestureDetector(
      onTap: onTap!,
      child: Container(
        height: 45,
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * .48,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title!,
              style: TextStyle(
                  fontSize: 16,
                  fontFamily: "roboto",
                  fontWeight:
                      index == filterIndex ? FontWeight.bold : FontWeight.w500,
                  color: index == filterIndex
                      ? ColorConstant.whiteColor
                      : ColorConstant.greyColor),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: index == filterIndex
                    ? ColorConstant.whiteColor
                    : ColorConstant.mainColor,
                height: 2,
                width: MediaQuery.of(context).size.width * .48,
              ),
            )
          ],
        ),
      ),
    );
  }

  filterClientBottomSheet({BuildContext? context}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              decoration: const BoxDecoration(
                color: ColorConstant.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: MediaQuery.of(context).size.height * .62,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * .08,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Select Client",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "roboto",
                          color: ColorConstant.whiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * .54,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .48,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: clientListForFilter.length,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (clientListForFilter[index]
                                              .isSelected ==
                                          true) {
                                        clientListForFilter[index].isSelected =
                                            false;
                                        selectedClientID
                                            .remove(clientListForFilter[index]);
                                      } else {
                                        clientListForFilter[index].isSelected =
                                            true;
                                        selectedClientID
                                            .add(clientListForFilter[index]);
                                      }
                                      setState(
                                        () {},
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            clientListForFilter[index]
                                                        .isSelected ==
                                                    true
                                                ? Icons.check_box
                                                : Icons
                                                    .check_box_outline_blank_outlined,
                                            size: 25,
                                            color: ColorConstant.mainColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            clientListForFilter[index]
                                                    .companyName ??
                                                '',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: ColorConstant.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "roboto"),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height * .05,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CommonButton(
                              onTap: () {
                                filterEngineeringForClient();
                                Navigator.pop(context);
                              },
                              title: 'Search',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  filterStatusBottomSheet({BuildContext? context}) {
    return showModalBottomSheet(
      isScrollControlled: true,
      context: context!,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context,
              StateSetter setState /*You can rename this!*/) {
            return Container(
              decoration: const BoxDecoration(
                color: ColorConstant.mainColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              height: MediaQuery.of(context).size.height * .62,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    height: MediaQuery.of(context).size.height * .08,
                    alignment: Alignment.centerLeft,
                    child: const Text(
                      "Select Status",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: "roboto",
                          color: ColorConstant.whiteColor,
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
                      ),
                    ),
                    height: MediaQuery.of(context).size.height * .54,
                    child: Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height * .48,
                          child: SingleChildScrollView(
                            child: ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: statusList.length,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                    onTap: () {
                                      if (statusList[index].isSelected ==
                                          true) {
                                        statusList[index].isSelected = false;
                                        selectedStatus
                                            .remove(statusList[index]);
                                      } else {
                                        statusList[index].isSelected = true;
                                        selectedStatus.add(statusList[index]);
                                      }
                                      setState(
                                        () {},
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Row(
                                        children: [
                                          Icon(
                                            statusList[index].isSelected == true
                                                ? Icons.check_box
                                                : Icons
                                                    .check_box_outline_blank_outlined,
                                            size: 25,
                                            color: ColorConstant.mainColor,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            statusList[index].status ?? '',
                                            style: const TextStyle(
                                                fontSize: 14,
                                                color: ColorConstant.blackColor,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "roboto"),
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                          ),
                        ),
                        Container(
                          color: Colors.transparent,
                          height: MediaQuery.of(context).size.height * .05,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: CommonButton(
                              onTap: () {
                                filterEngineeringForStatus();
                                Navigator.pop(context);
                              },
                              title: 'Search',
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }
}
