import 'package:flutter/material.dart';
import 'package:wikitek/utility/colors.dart';

titleAppBar({
  BuildContext? context,
  VoidCallback? onTap,
  String? title,
  String? amount,
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
          GestureDetector(
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
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w500),
            ),
          )
        ],
      ),
    ),
    actions: [
      Padding(
        padding: const EdgeInsets.only(top: 17, right: 10),
        child: Text(
          "$amount CR",
          style: const TextStyle(
              fontSize: 20, fontFamily: 'roboto', fontWeight: FontWeight.w500),
        ),
      )
    ],
  );
}
