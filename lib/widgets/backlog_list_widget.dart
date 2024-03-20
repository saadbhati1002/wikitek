import 'package:flutter/material.dart';
import 'package:wikitek/models/engineering/backlog/backlog_model.dart';

import 'package:wikitek/utility/colors.dart';

Widget backlogListWidget({BuildContext? context, BacklogData? backlogData}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: MediaQuery.of(context!).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * .6,
                  child: Text(
                    backlogData!.backlogId != null
                        ? '${backlogData.backlogId}/${backlogData.project!.projectName}'
                        : '',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width * .25,
                  child: Text(
                    '${backlogData.priority}/${backlogData.userStory}',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * .48,
                  child: Text(
                    backlogData.user == null
                        ? ""
                        : backlogData.user!.lastName != null
                            ? '${backlogData.user!.firstName} ${backlogData.user!.lastName}'
                            : backlogData.user!.firstName ?? "",
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width * .38,
                  child: Text(
                    '${backlogData.status}',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
