import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:wikitek/api/repository/home/home.dart';
import 'package:wikitek/models/home/kpi/kpi_model.dart';
import 'package:wikitek/screens/splash/splash_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/utility/images.dart';
import 'package:wikitek/widgets/custom_drawer_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;
  String? salesLeadYear = "2023-2024";
  List<KpiResData> kpiPoApiResponse = [];
  List<KpiResData> kpiInvoiceApiResponse = [];
  Map<String, double> kpiPOList = {};
  Map<String, double> kpiInvoiceList = {};
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  final colorList = <Color>[
    const Color(0xFF76B6D9),
    const Color(0xFFFFB31F),
    const Color(0xFFAA1FFF),
    const Color(0xFF1BEA6E),
    ColorConstant.mainColor,
    ColorConstant.redColor,
    ColorConstant.greyBlueColor,
    ColorConstant.greyColor,
  ];
  @override
  void initState() {
    _getData();
    super.initState();
  }

  _getData() async {
    kpiPOList = {};
    kpiInvoiceList = {};

    await _getKpiPO();
    await _getKpiInvoice();
  }

  _getKpiPO() async {
    try {
      setState(() {
        isLoading = true;
      });
      KpiRes response = await HomeRepository().getKpiApiCall(
        year: salesLeadYear,
        type: 'PO',
      );
      if (response.results.isNotEmpty) {
        kpiPoApiResponse = response.results;
        _calculateTotalKpiPO();
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (kpiPoApiResponse.isEmpty) {
        setState(() {
          isLoading = true;
        });
      }
    }
  }

  _getKpiInvoice() async {
    try {
      setState(() {
        isLoading = true;
      });
      KpiRes response = await HomeRepository().getKpiApiCall(
        year: salesLeadYear,
        type: 'INVOICE',
      );
      if (response.results.isNotEmpty) {
        kpiInvoiceApiResponse = response.results;
        _calculateTotalKpiInvoice();
      }
      return response;
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (kpiInvoiceApiResponse.isEmpty) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  _calculateTotalKpiPO() async {
    for (int i = 0; i < kpiPoApiResponse.length; i++) {
      kpiPoApiResponse[i].total = kpiPoApiResponse[i].jan! +
          kpiPoApiResponse[i].feb! +
          kpiPoApiResponse[i].mar! +
          kpiPoApiResponse[i].apr! +
          kpiPoApiResponse[i].may! +
          kpiPoApiResponse[i].jun! +
          kpiPoApiResponse[i].jul! +
          kpiPoApiResponse[i].aug! +
          kpiPoApiResponse[i].sep! +
          kpiPoApiResponse[i].oct! +
          kpiPoApiResponse[i].nov! +
          kpiPoApiResponse[i].dec!;
    }
    _calculateKpiPO();
  }

  _calculateTotalKpiInvoice() async {
    for (int i = 0; i < kpiInvoiceApiResponse.length; i++) {
      kpiInvoiceApiResponse[i].total = kpiInvoiceApiResponse[i].jan! +
          kpiInvoiceApiResponse[i].feb! +
          kpiInvoiceApiResponse[i].mar! +
          kpiInvoiceApiResponse[i].apr! +
          kpiInvoiceApiResponse[i].may! +
          kpiInvoiceApiResponse[i].jun! +
          kpiInvoiceApiResponse[i].jul! +
          kpiInvoiceApiResponse[i].aug! +
          kpiInvoiceApiResponse[i].sep! +
          kpiInvoiceApiResponse[i].oct! +
          kpiInvoiceApiResponse[i].nov! +
          kpiInvoiceApiResponse[i].dec!;
    }
    _calculateKpiInvoice();
  }

  _calculateKpiPO() {
    double totalPrice = 0.0;
    for (int i = 0; i < kpiPoApiResponse.length; i++) {
      totalPrice = totalPrice + kpiPoApiResponse[i].total!;
    }

    for (int i = 0; i < kpiPoApiResponse.length; i++) {
      kpiPOList[kpiPoApiResponse[i].department!] =
          (kpiPoApiResponse[i].total! / totalPrice) * 100;
    }
    setState(() {});
  }

  _calculateKpiInvoice() {
    double totalPrice = 0.0;
    for (int i = 0; i < kpiInvoiceApiResponse.length; i++) {
      totalPrice = totalPrice + kpiInvoiceApiResponse[i].total!;
    }

    for (int i = 0; i < kpiInvoiceApiResponse.length; i++) {
      kpiInvoiceList[kpiInvoiceApiResponse[i].department!] =
          (kpiInvoiceApiResponse[i].total! / totalPrice) * 100;
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.backgroundColor,
      key: _key,
      drawer: CustomDrawerWidget(
        onTap: () {
          Navigator.pop(context);
          _logOutPopUp();
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: ColorConstant.mainColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                _key.currentState!.openDrawer();
              },
              child: SizedBox(
                height: 30,
                width: 43,
                child: Image.asset(Images.logo),
              ),
            ),
            const Text(
              'Sales',
              style: TextStyle(
                  fontSize: 20,
                  color: ColorConstant.whiteColor,
                  fontFamily: 'roboto',
                  fontWeight: FontWeight.w500),
            ),
            const SizedBox(
              height: 30,
              width: 43,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: ColorConstant.whiteColor,
              margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1,
                    color: ColorConstant.greyBlueColor,
                  ),
                  color: ColorConstant.whiteColor,
                  borderRadius: BorderRadius.circular(5),
                ),
                height: 45,
                alignment: Alignment.center,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      dropdownColor: ColorConstant.whiteColor,
                      icon: const Icon(
                        Icons.keyboard_arrow_down_sharp,
                        color: ColorConstant.greyDarkColor,
                      ),
                      isExpanded: true,
                      items: <String>[
                        "2019-2020",
                        "2020-2021",
                        "2021-2022",
                        "2022-2023",
                        "2023-2024",
                        "2024-2025",
                      ].map((String value) {
                        return DropdownMenuItem(
                          value: value,
                          child: Text(
                            value,
                          ),
                        );
                      }).toList(),
                      style: const TextStyle(
                        color: ColorConstant.greyBlueColor,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                      hint: Text(
                        salesLeadYear!,
                        maxLines: 1,
                        style: TextStyle(
                          color: salesLeadYear == "2023-2024"
                              ? ColorConstant.greyDarkColor
                              : ColorConstant.bottomSheetColor,
                          fontSize: 16,
                          fontWeight: salesLeadYear == "2023-2024"
                              ? FontWeight.w400
                              : FontWeight.w500,
                        ),
                      ),
                      onChanged: (value) {
                        salesLeadYear = value!;
                        _getData();
                        setState(() {});
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * .43,
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            "KPI PO",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: ColorConstant.greyColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        kpiPOList.isNotEmpty
                            ? PieChart(
                                dataMap: kpiPOList,
                                animationDuration:
                                    const Duration(milliseconds: 800),
                                chartLegendSpacing: 32,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                colorList: colorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 20,
                                centerText: "",
                                legendOptions: const LegendOptions(
                                  showLegendsInRow: true,
                                  legendPosition: LegendPosition.bottom,
                                  showLegends: true,
                                  // legendShape: _BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValueBackground: false,
                                  showChartValues: true,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height:
                                    MediaQuery.of(context).size.height * .25,
                                child: const Center(
                                  child: Text("No data found to show"),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * .43,
                    decoration: BoxDecoration(
                      color: ColorConstant.whiteColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          child: Text(
                            "KPI Invoice",
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 1,
                          color: ColorConstant.greyColor,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        kpiInvoiceList.isNotEmpty
                            ? PieChart(
                                dataMap: kpiInvoiceList,
                                animationDuration:
                                    const Duration(milliseconds: 800),
                                chartLegendSpacing: 32,
                                chartRadius:
                                    MediaQuery.of(context).size.width / 3.2,
                                colorList: colorList,
                                initialAngleInDegree: 0,
                                chartType: ChartType.ring,
                                ringStrokeWidth: 20,
                                centerText: "",
                                legendOptions: const LegendOptions(
                                  showLegendsInRow: true,
                                  legendPosition: LegendPosition.bottom,
                                  showLegends: true,
                                  // legendShape: _BoxShape.circle,
                                  legendTextStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                chartValuesOptions: const ChartValuesOptions(
                                  showChartValueBackground: false,
                                  showChartValues: true,
                                  showChartValuesInPercentage: false,
                                  showChartValuesOutside: false,
                                  decimalPlaces: 1,
                                ),
                              )
                            : Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                height:
                                    MediaQuery.of(context).size.height * .25,
                                child: const Center(
                                  child: Text("No data found to show"),
                                ),
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _logOutPopUp() async {
    return showDialog(
      context: context,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              shape: const RoundedRectangleBorder(
                  side: BorderSide(color: ColorConstant.greyColor),
                  borderRadius: BorderRadius.all(
                    Radius.circular(15.0),
                  )),
              elevation: 0,
              backgroundColor: ColorConstant.whiteColor,
              actionsPadding: const EdgeInsets.symmetric(vertical: 0),
              title: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                    color: ColorConstant.whiteColor,
                    borderRadius: BorderRadius.circular(15)),
                // height: MediaQuery.of(context).size.height * .25,
                width: MediaQuery.of(context).size.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Are you sure?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 18,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(
                      height: 13,
                    ),
                    const Text(
                      'Do you want to logout from the app?',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: ColorConstant.blackColor,
                        fontSize: 14,
                        fontFamily: 'inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstant.whiteColor),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            _logoutFromDevice();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: ColorConstant.mainColor,
                                borderRadius: BorderRadius.circular(8)),
                            height: 35,
                            // width: MediaQuery.of(context).size.width * .2,
                            alignment: Alignment.center,
                            child: const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 15),
                              child: Text(
                                'Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                    color: ColorConstant.whiteColor),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  _logoutFromDevice() {
    AppConstant.saveUserDetail("null");
    toastShow(message: "User logout successfully");
    Get.to(() => const SplashScreen());
  }
}
