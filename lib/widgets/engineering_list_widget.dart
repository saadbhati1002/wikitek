import 'package:flutter/material.dart';
import 'package:wikitek/models/engineering/engineering_model.dart';

import 'package:wikitek/utility/colors.dart';

Widget engineeringListWidget(
    {BuildContext? context, EngineeringData? engineeringData}) {
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
                  width: MediaQuery.of(context).size.width * .64,
                  child: Text(
                    engineeringData!.projectId != null
                        ? '${engineeringData.projectId}/${engineeringData.projectName}'
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
                  width: MediaQuery.of(context).size.width * .21,
                  child: Text(
                    engineeringData.so?.id ?? '',
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
                    engineeringData.client!.companyName ?? '',
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
                    '${engineeringData.tasks!.length} #/${engineeringData.status}',
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
