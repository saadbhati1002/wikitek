import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/images.dart';

class FullImageScreen extends StatefulWidget {
  final String? imageUrl;

  const FullImageScreen({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  State<FullImageScreen> createState() => _FullImageScreenState();
}

class _FullImageScreenState extends State<FullImageScreen> {
  String? imageUrl;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    imageUrl = widget.imageUrl;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * 1,
              child: Center(
                child: PhotoView(
                  imageProvider: NetworkImage(imageUrl!),
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(Images.logo);
                  },
                ),
              ),
            ),
            Positioned(
              right: 15,
              top: 15,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Colors.black, // border color
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Icon(Icons.clear, size: 30, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
