import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:skeletons/skeletons.dart';
import 'package:wikitek/api/repository/invoice/invoice.dart';
import 'package:wikitek/models/invoice/invoice_model.dart';
import 'package:wikitek/screens/dashboard/dashboard_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/widgets/app_bar_title.dart';
import 'package:wikitek/widgets/ar_widget.dart';

class ARScreen extends StatefulWidget {
  const ARScreen({super.key});

  @override
  State<ARScreen> createState() => _ARScreenState();
}

class _ARScreenState extends State<ARScreen> {
  String? invoiceDataYear = "2023 - 2024";

  List<InvoiceData> invoiceData = [];

  int? filterIndex;
  bool isLoading = false;
  @override
  void initState() {
    _getInvoice();
    super.initState();
  }

  _getInvoice() async {
    try {
      setState(() {
        isLoading = true;
      });
      invoiceData = [];

      InvoiceRes response =
          await InvoiceRepository().invoiceApiCall(year: invoiceDataYear);
      if (response.results!.isNotEmpty) {
        invoiceData = response.results!;
        _getTotal();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getTotal() {
    try {
      double dummyTotal = 0.0;
      for (int i = 0; i < invoiceData.length; i++) {
        for (int j = 0; j < invoiceData[i].partsInvoice!.length; j++) {
          dummyTotal = dummyTotal +
              invoiceData[i].partsInvoice![j].price! *
                  invoiceData[i].partsInvoice![j].quantity!;
        }
        invoiceData[i].total = dummyTotal.toString();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {});
    }
  }

  _getTotalAmount() {
    double localAmount = 0.0;
    for (int leadCount = 0; leadCount < invoiceData.length; leadCount++) {
      if (invoiceData[leadCount].amountPaid != null) {
        localAmount = localAmount + double.parse(invoiceData[leadCount].total!);
      }
    }
    return localAmount.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      appBar: titleAppBar(
        isHome: true,
        onTap: () {
          Get.to(() => const DashBoardScreen());
        },
        context: context,
        title: 'Account Receivables',
        amount: _getTotalAmount(),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height * .82,
        child: SingleChildScrollView(
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
              : invoiceData.isEmpty
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height * .77,
                      child: const Center(
                        child: Text(
                          "No Invoice Found",
                          style: TextStyle(
                              fontSize: 16,
                              color: ColorConstant.blackColor,
                              fontFamily: "roboto",
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: invoiceData.length,
                      shrinkWrap: true,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 15),
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return arWidget(
                            context: context, invoiceData: invoiceData[index]);
                      },
                    ),
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
                  height: 100, width: MediaQuery.of(context).size.width),
            ),
          ),
        ),
      ),
    );
  }
}
