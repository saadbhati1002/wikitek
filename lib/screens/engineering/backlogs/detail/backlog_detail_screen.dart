import 'package:flutter/material.dart';
import 'package:wikitek/models/engineering/backlog/backlog_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_detail.dart';

class BacklogDetailScreen extends StatefulWidget {
  final BacklogData? backlog;
  const BacklogDetailScreen({super.key, this.backlog});

  @override
  State<BacklogDetailScreen> createState() => _BacklogDetailScreenState();
}

class _BacklogDetailScreenState extends State<BacklogDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBarTitle(
        onTap: () {
          Navigator.pop(context);
        },
        context: context,
        title: 'Engineering',
        isAmount: false,
        subHeading: widget.backlog!.backlogId ?? "",
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 1,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 20),
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Column(children: [
                      commonRowDesign(
                        title: 'Project ID',
                        heading: widget.backlog!.project!.projectName ?? "",
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Title',
                        heading: widget.backlog!.userStory,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Description',
                        heading: widget.backlog!.projectDesc,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Engineer',
                        heading: '',
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Type',
                        heading: widget.backlog!.remark,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Status',
                        heading: widget.backlog!.status,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'Priority',
                        heading: widget.backlog!.priority.toString(),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(title: 'Start Date / Time', heading: ""),
                      const SizedBox(
                        height: 15,
                      ),
                      commonRowDesign(
                        title: 'EndDate / Time',
                        heading: widget.backlog!.targetDate,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ]),
                  ),
                ),
              ),
            ]),
      ),
    );
  }

  Widget commonRowDesign({String? title, String? heading, bool? isBold}) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .27,
            child: Text(
              "$title:",
              style: TextStyle(
                  fontWeight:
                      isBold == true ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 15,
                  fontFamily: "roboto",
                  color: ColorConstant.blackColor),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .575,
            child: Text(
              heading ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 15,
                  fontFamily: "roboto",
                  color: ColorConstant.greyTextColor),
            ),
          )
        ],
      ),
    );
  }
}
