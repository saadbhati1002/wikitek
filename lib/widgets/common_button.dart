import 'package:flutter/material.dart';
import 'package:wikitek/utility/colors.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({Key? key, this.width, this.onTap, this.title})
      : super(key: key);
  final double? width;
  final Function()? onTap;
  final String? title;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 45,
        width: width,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: ColorConstant.mainColor),
        alignment: Alignment.center,
        child: Text(
          title!,
          style: const TextStyle(
              fontSize: 16,
              color: ColorConstant.whiteColor,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
