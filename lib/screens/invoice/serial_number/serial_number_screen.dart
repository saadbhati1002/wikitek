import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wikitek/api/repository/invoice/invoice.dart';
import 'package:wikitek/models/invoice/serial_number/serial_number_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_title.dart';

class SerialNumberScreen extends StatefulWidget {
  final String? invoiceNumber;
  final String? partNumber;
  const SerialNumberScreen({super.key, this.partNumber, this.invoiceNumber});

  @override
  State<SerialNumberScreen> createState() => _SerialNumberScreenState();
}

class _SerialNumberScreenState extends State<SerialNumberScreen> {
  bool isLoading = false;
  List<String> serialNumbersList = [];
  @override
  void initState() {
    _serialNumber();
    super.initState();
  }

  _serialNumber() async {
    try {
      setState(() {
        isLoading = true;
      });
      SerialNumberRes response =
          await InvoiceRepository().invoicePartSerialNumberApiCall(
        invoiceNumber: widget.invoiceNumber,
        partNumber: widget.partNumber,
      );
      if (response.serialNumbers!.isNotEmpty) {
        serialNumbersList = response.serialNumbers!;
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBar(
        isHome: false,
        onTap: () {
          Navigator.pop(context);
        },
        context: context,
        title: 'Invoices - Detail',
        isAmount: false,
        amount: '',
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                itemCount: 10,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return leadSkelton();
                },
              )
            : serialNumbersList.isEmpty
                ? SizedBox(
                    height: MediaQuery.of(context).size.height * .77,
                    child: const Center(
                      child: Text(
                        "No Serial Number Found",
                        style: TextStyle(
                            fontSize: 16,
                            color: ColorConstant.blackColor,
                            fontFamily: "roboto",
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: serialNumbersList.length,
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 15),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return serialNumberWidget(index);
                    },
                  ),
      ),
    );
  }

  Widget leadSkelton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 2,
        borderRadius: BorderRadius.circular(10),
        shadowColor: ColorConstant.mainColor,
        child: Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(width: 0.9, color: ColorConstant.mainColor),
          ),
          child: SkeletonTheme(
            themeMode: ThemeMode.light,
            child: SkeletonAvatar(
              style: SkeletonAvatarStyle(
                  height: 70, width: MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }

  Widget serialNumberWidget(index) {
    return Container(
      height: 55,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: ColorConstant.mainColor.withOpacity(0.3),
      ),
      alignment: Alignment.center,
      child: Text(
        serialNumbersList[index],
        style: const TextStyle(
            fontSize: 17,
            color: ColorConstant.blackColor,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
