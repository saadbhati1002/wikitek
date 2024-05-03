import 'package:flutter/material.dart';
import 'package:wikitek/utility/colors.dart';

titleAppBarTitle({
  BuildContext? context,
  VoidCallback? onTap,
  String? title,
  String? subHeading,
  String? amount,
  bool? isHome,
  bool? isAmount,
}) {
  return AppBar(
    backgroundColor: ColorConstant.mainColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          isHome == true
              ? const SizedBox()
              : GestureDetector(
                  onTap: onTap,
                  child: const Icon(
                    Icons.arrow_back_ios_new,
                    color: ColorConstant.whiteColor,
                    size: 18,
                  ),
                ),
          const SizedBox(
            width: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: subHeading != null
                ? [
                    Text(
                      title!,
                      style: const TextStyle(
                          fontSize: 20,
                          color: ColorConstant.whiteColor,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context!).size.width * .5,
                      child: Text(
                        subHeading,
                        maxLines: 1,
                        style: const TextStyle(
                            fontSize: 12,
                            color: ColorConstant.whiteColor,
                            fontFamily: 'roboto',
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ]
                : [
                    Text(
                      title!,
                      style: const TextStyle(
                          fontSize: 20,
                          color: ColorConstant.whiteColor,
                          fontFamily: 'roboto',
                          fontWeight: FontWeight.w500),
                    ),
                  ],
          )
        ],
      ),
    ),
    actions: [
      isAmount == false
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.only(top: 0, right: 10),
              child: Text(
                "$amount CR",
                style: const TextStyle(
                    color: ColorConstant.whiteColor,
                    fontSize: 18,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w500),
              ),
            )
    ],
  );
}
