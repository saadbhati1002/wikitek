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
                  width: engineeringData!.so != null
                      ? MediaQuery.of(context).size.width * .47
                      : MediaQuery.of(context).size.width * .8,
                  child: Text(
                    engineeringData.projectId != null
                        ? '${engineeringData.projectId!.substring(14, engineeringData.projectId!.length)}/${engineeringData.projectName}'
                        : engineeringData.projectName!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                engineeringData.so != null
                    ? Container(
                        alignment: Alignment.topRight,
                        width: MediaQuery.of(context).size.width * .39,
                        child: Text(
                          engineeringData.so?.soId ?? '',
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "roboto",
                              color: ColorConstant.greyDarkColor,
                              fontWeight: FontWeight.w400),
                        ),
                      )
                    : const SizedBox(),
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
                    engineeringData.client != null
                        ? engineeringData.client!.companyName ?? ''
                        : "",
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
                    engineeringData.status ?? "",
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
            engineeringData.backlogList.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      engineeringData.backlogList
                          .toString()
                          .replaceAll('[', '')
                          .replaceAll(']', ''),
                      style: const TextStyle(
                          fontSize: 14,
                          fontFamily: "roboto",
                          color: ColorConstant.greyDarkColor,
                          fontWeight: FontWeight.w400),
                    ),
                  )
                : const SizedBox()
          ],
        ),
      ),
    ),
  );
}
