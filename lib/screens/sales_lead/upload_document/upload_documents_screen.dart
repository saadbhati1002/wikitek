import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wikitek/api/repository/media/media.dart';
import 'package:wikitek/api/repository/sales_lead/sales_lead.dart';
import 'package:wikitek/models/lead/document/upload_document_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/models/media/media_model.dart';
import 'package:wikitek/screens/image_view/image_view_screen.dart';
import 'package:wikitek/screens/pdf_view/pdf_view_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/common_button.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class UploadDocumentsScreen extends StatefulWidget {
  final SalesLeadData? leadData;

  const UploadDocumentsScreen({super.key, this.leadData});

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  bool isLoading = false;
  bool isAddingDocument = false;
  int? selectedMediaType;
  String mediaType = "Media Type";
  List<MediaType> mediaTypeList = [];
  File? selectedFie;
  @override
  void initState() {
    _getMediaType();
    super.initState();
  }

  _getMediaType() async {
    try {
      setState(() {
        isLoading = true;
      });
      MediaRes response = await MediaRepository().getMediaTypeApiCall();
      if (response.results!.isNotEmpty) {
        mediaTypeList = response.results!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<bool> willPopScope() {
    Navigator.pop(context, jsonEncode(widget.leadData));

    return Future.value(true);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: willPopScope,
      child: Scaffold(
        backgroundColor: ColorConstant.backgroundColor,
        appBar: titleAppBar(
          isHome: false,
          onTap: () {
            Navigator.pop(context, jsonEncode(widget.leadData));
          },
          context: context,
          title: 'Sales - Lead',
          amount: "",
          isAmount: false,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Documents",
                          maxLines: 1,
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: "roboto",
                              color: ColorConstant.bottomSheetColor,
                              fontWeight: FontWeight.w700),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .35,
                          child: CommonButton(
                            onTap: () {
                              setState(() {
                                isAddingDocument = true;
                              });
                            },
                            title: 'Update',
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: widget.leadData?.salesLeadDocument?.length,
                    itemBuilder: (context, index) {
                      return historyWidget(
                          index: index,
                          salesLeadDocument:
                              widget.leadData?.salesLeadDocument![index]);
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            isAddingDocument == true ? addDocument() : const SizedBox(),
            isLoading ? const ShowProgressBar() : const SizedBox(),
          ],
        ),
      ),
    );
  }

  Widget historyWidget({index, SalesLeadDocument? salesLeadDocument}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      child: GestureDetector(
        onTap: () {
          if (salesLeadDocument.mediaType == 1) {
            Get.to(
              () => FullImageScreen(imageUrl: salesLeadDocument.attachment),
            );
          } else if (salesLeadDocument.mediaType == 2) {
            launchUrl(
              Uri.parse(salesLeadDocument.attachment!),
            );
          } else if (salesLeadDocument.mediaType == 3) {
            Get.to(
              () => NetworkPdf(path: salesLeadDocument.attachment),
            );
          }
        },
        child: Material(
          elevation: 1,
          borderRadius: BorderRadius.circular(5),
          child: Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            decoration: BoxDecoration(
              color: ColorConstant.whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                commonRowDesign(
                  title: "Media Type",
                  heading: salesLeadDocument!.mediaType.toString(),
                  isBold: true,
                ),
                const SizedBox(
                  height: 7,
                ),
                Text(
                  salesLeadDocument.name ?? "",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                    fontFamily: "roboto",
                    color: ColorConstant.blackColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget commonRowDesign({String? title, String? heading, bool? isBold}) {
    return SizedBox(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * .27,
            child: Text(
              "$title:",
              style: TextStyle(
                  fontWeight:
                      isBold == true ? FontWeight.w600 : FontWeight.w500,
                  fontSize: 15,
                  fontFamily: "roboto",
                  color: ColorConstant.blackColor),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * .575,
            child: Text(
              heading ?? "",
              style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15,
                  fontFamily: "roboto",
                  color: ColorConstant.greyTextColor),
            ),
          )
        ],
      ),
    );
  }

  Widget addDocument() {
    return Container(
      color: ColorConstant.blackColor.withOpacity(0.6),
      height: MediaQuery.of(context).size.height * .9,
      width: MediaQuery.of(context).size.width * 1,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            color: ColorConstant.whiteColor,
            borderRadius: BorderRadius.circular(15),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 15),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * .57,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: MediaQuery.of(context).size.height * .019,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Add Document",
                      maxLines: 1,
                      style: TextStyle(
                          fontSize: 18,
                          fontFamily: "roboto",
                          color: ColorConstant.bottomSheetColor,
                          fontWeight: FontWeight.w700),
                    ),
                    GestureDetector(
                      onTap: () {
                        isAddingDocument = false;
                        selectedMediaType = null;
                        selectedFie = null;
                        setState(() {});
                      },
                      child: const FaIcon(
                        FontAwesomeIcons.xmark,
                        color: ColorConstant.redColor,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 0.5,
                color: ColorConstant.greyBlueColor,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .022,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: ColorConstant.greenLightColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 45,
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<MediaType>(
                      dropdownColor: ColorConstant.whiteColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: ColorConstant.greyDarkColor,
                      ),
                      isExpanded: true,
                      items: mediaTypeList.map((MediaType value) {
                        return DropdownMenuItem<MediaType>(
                          value: value,
                          child: Text(
                            value.name ?? '',
                          ),
                        );
                      }).toList(),
                      style: const TextStyle(
                        color: ColorConstant.greyBlueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: Text(
                        mediaType,
                        maxLines: 1,
                        style: TextStyle(
                          color: mediaType == "Media Type"
                              ? ColorConstant.greyBlueColor
                              : ColorConstant.bottomSheetColor,
                          fontSize: mediaType == "Select Part" ? 16 : 18,
                          fontWeight: mediaType == "Select Part"
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        selectedMediaType = value!.id;
                        mediaType = value.name!;
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .019,
              ),
              selectedMediaType == null
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .29,
                      width: MediaQuery.of(context).size.width,
                    )
                  : GestureDetector(
                      onTap: () {
                        _selectFileToUpload();
                      },
                      child: selectedFie != null
                          ? SizedBox(
                              child: selectedMediaType == 1
                                  ? Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .29,
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                            image: FileImage(selectedFie!),
                                            fit: BoxFit.cover),
                                      ),
                                    )
                                  : Container(
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 15),
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .29,
                                      width: MediaQuery.of(context).size.width,
                                      child: Center(
                                        child: Text(
                                          selectedFie!.path,
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color:
                                                  ColorConstant.greyDarkColor,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ),
                            )
                          : Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              height: MediaQuery.of(context).size.height * .29,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    width: 1,
                                    color: ColorConstant.greyDarkColor),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Text(
                                    "drag and drop here",
                                    style: TextStyle(
                                        fontFamily: "roboto",
                                        fontSize: 18,
                                        color: ColorConstant.greyTextColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Text(
                                    "or",
                                    style: TextStyle(
                                        fontFamily: "roboto",
                                        fontSize: 18,
                                        color: ColorConstant.greyTextColor,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width:
                                        MediaQuery.of(context).size.width * .6,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: ColorConstant.greyColor,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    alignment: Alignment.center,
                                    child: const Text(
                                      "Select File",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: ColorConstant.whiteColor,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                    ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .027,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: CommonButton(
                  onTap: () {
                    _uploadDocuments();
                  },
                  title: 'Add History',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _selectFileToUpload() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: selectedMediaType == 1
          ? ['jpg', 'pdf', 'png', 'jpeg']
          : selectedMediaType == 2
              ? ["mp4"]
              : ["pdf"],
    );
    if (result != null) {
      selectedFie = File(result.files[0].path!);
      setState(() {});
    }
  }

  _uploadDocuments() async {
    if (selectedFie == null) {
      toastShow(message: "Please select a file to upload");
      return;
    }
    try {
      setState(() {
        isLoading = true;
        isAddingDocument = false;
      });
      SalesLeadDocumentUploadRes response = await SalesLeadRepository()
          .addSalesLeadDocumentApiCall(
              mediaType: selectedMediaType.toString(),
              salesLeadId: widget.leadData!.leadNo,
              selectedFile: selectedFie);
      if (response.success == true) {
        widget.leadData!.salesLeadDocument!.add(
          SalesLeadDocument(
            mediaType: selectedMediaType,
            salesLead: widget.leadData!.leadNo,
            name: selectedFie!.path.split('/').last,
            attachment: response.attachment,
            date: DateFormat('yyyy-MM-dd').format(DateTime.now()).toString(),
          ),
        );

        widget
            .leadData!
            .salesLeadDocument![widget.leadData!.salesLeadDocument!.length - 1]
            .attachment = response.attachment;
        widget
            .leadData!
            .salesLeadDocument![widget.leadData!.salesLeadDocument!.length - 1]
            .date = DateFormat('yyyy-MM-dd').format(DateTime.now()).toString();
        widget
            .leadData!
            .salesLeadDocument![widget.leadData!.salesLeadDocument!.length - 1]
            .name = selectedFie!.path.split('/').last;
        widget
            .leadData!
            .salesLeadDocument![widget.leadData!.salesLeadDocument!.length - 1]
            .mediaType = selectedMediaType;
        selectedFie = null;
        selectedMediaType = null;
        mediaType = "Media Type";
        toastShow(message: "Uploaded Successfully");
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
