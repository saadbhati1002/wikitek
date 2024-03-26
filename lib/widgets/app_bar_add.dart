import 'package:flutter/material.dart';
import 'package:wikitek/utility/colors.dart';

titleAppBarAddTitle({
  BuildContext? context,
  VoidCallback? onTap,
  VoidCallback? addFunction,
  String? title,
  String? subHeading,
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
          GestureDetector(
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
            children: [
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
                  subHeading!,
                  maxLines: 1,
                  style: const TextStyle(
                      fontSize: 12,
                      color: ColorConstant.whiteColor,
                      fontFamily: 'roboto',
                      fontWeight: FontWeight.w500),
                ),
              ),
            ],
          )
        ],
      ),
    ),
    actions: [
      GestureDetector(
        onTap: addFunction,
        child: const Padding(
          padding: EdgeInsets.only(right: 10),
          child: Icon(
            Icons.add_circle,
            color: ColorConstant.whiteColor,
          ),
        ),
      ),
    ],
  );
}
