import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class NetworkPdf extends StatefulWidget {
  final String? path;
  const NetworkPdf({Key? key, this.path}) : super(key: key);

  @override
  State<NetworkPdf> createState() => _NetworkPdfState();
}

class _NetworkPdfState extends State<NetworkPdf> {
  bool isReady = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SfPdfViewer.network(
          widget.path!,
        ),
      ),
    );
  }
}
