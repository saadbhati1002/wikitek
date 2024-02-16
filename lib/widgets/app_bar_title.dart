import 'package:flutter/material.dart';
import 'package:wikitek/utility/colors.dart';

titleAppBar({
  BuildContext? context,
  VoidCallback? onTap,
  String? title,
  String? amount,
  bool? isHome,
  bool? isAmount,
}) {
  return AppBar(
    backgroundColor: ColorConstant.mainColor,
    elevation: 0,
    automaticallyImplyLeading: false,
    title: SizedBox(
      height: 40,
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
            width: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Text(
              title!,
              style: const TextStyle(
                  fontSize: 20,
                  color: ColorConstant.whiteColor,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w500),
            ),
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
                    fontSize: 20,
                    fontFamily: 'roboto',
                    fontWeight: FontWeight.w500),
              ),
            )
    ],
  );
}
