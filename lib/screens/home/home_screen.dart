import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pie_chart/pie_chart.dart' as pie;
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:wikitek/api/repository/home/home.dart';
import 'package:wikitek/api/repository/invoice/invoice.dart';
import 'package:wikitek/api/repository/sales_lead/sales_lead.dart';
import 'package:wikitek/api/repository/sales_order/sales_order.dart';
import 'package:wikitek/models/home/kpi/kpi_model.dart';
import 'package:wikitek/models/invoice/invoice_model.dart';
import 'package:wikitek/models/lead/lead_model.dart';
import 'package:wikitek/models/sales_order/sales_order_model.dart' as order;
import 'package:wikitek/screens/splash/splash_screen.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/utility/constant.dart';
import 'package:wikitek/utility/images.dart';
import 'package:wikitek/widgets/custom_drawer_widget.dart';
import 'package:wikitek/widgets/show_progress_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  bool isLoading = false;
  bool _switchValue = false;
  String? salesLeadYear = "2023-2024";
  String? graphType = "By Type";
  Dept? selectedInvoiceDepartment;
  Dept? selectedInvoiceDepartmentActualInvoice;
  order.Department? selectedOrderDepartment;
  Department? selectedOrderDepartmentEstimatedPo;
  order.Department? selectedOrderDepartmentEstimatedInvoice;

  Map<String, double> kpiPOList = {};
  Map<String, double> kpiInvoiceList = {};

  List<SalesLeadData> salesLead = [];
  List<order.SalesOrderData> salesOrder = [];
  List<KpiResData> kpiPoApiResponse = [];
  List<KpiResData> kpiInvoiceApiResponse = [];
  List<InvoiceData> invoiceData = [];
  List<Dept> invoiceDepartment = [];
  List<Department> salesDepartment = [];
  List<order.Department> salesOrderDepartment = [];

  List<_SalesData> arGraphData = [
    _SalesData('Overdue (>30 days)', 0),
    _SalesData('Overdue (>15 days)', 0),
    _SalesData('Overdue (<15 days)', 0),
    _SalesData('Due in 15 days', 0),
    _SalesData('Due in 30 days', 0),
    _SalesData('Due in < 30 days', 0),
  ];

  List<_SalesData> salesActualPo = [
    _SalesData('Apr', 0),
    _SalesData('May', 0),
    _SalesData('Jun', 0),
    _SalesData('Jul', 0),
    _SalesData('Aug', 0),
    _SalesData('Set', 0),
    _SalesData('Oct', 0),
    _SalesData('Nov', 0),
    _SalesData('Dec', 0),
    _SalesData('Jan', 0),
    _SalesData('Feb', 0),
    _SalesData('Mar', 0),
  ];
  List<_SalesData> salesOrderActualPo = [
    _SalesData('Apr', 0),
    _SalesData('May', 0),
    _SalesData('Jun', 0),
    _SalesData('Jul', 0),
    _SalesData('Aug', 0),
    _SalesData('Set', 0),
    _SalesData('Oct', 0),
    _SalesData('Nov', 0),
    _SalesData('Dec', 0),
    _SalesData('Jan', 0),
    _SalesData('Feb', 0),
    _SalesData('Mar', 0),
  ];
  List<_SalesData> salesOrderActualInvoice = [
    _SalesData('Apr', 0),
    _SalesData('May', 0),
    _SalesData('Jun', 0),
    _SalesData('Jul', 0),
    _SalesData('Aug', 0),
    _SalesData('Set', 0),
    _SalesData('Oct', 0),
    _SalesData('Nov', 0),
    _SalesData('Dec', 0),
    _SalesData('Jan', 0),
    _SalesData('Feb', 0),
    _SalesData('Mar', 0),
  ];
  List<_SalesData> salesOrderEstimatedInvoice = [
    _SalesData('Apr', 0),
    _SalesData('May', 0),
    _SalesData('Jun', 0),
    _SalesData('Jul', 0),
    _SalesData('Aug', 0),
    _SalesData('Set', 0),
    _SalesData('Oct', 0),
    _SalesData('Nov', 0),
    _SalesData('Dec', 0),
    _SalesData('Jan', 0),
    _SalesData('Feb', 0),
    _SalesData('Mar', 0),
  ];
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
    try {
      setState(() {
        isLoading = true;
      });
      kpiPOList = {};
      kpiInvoiceList = {};

      await _getKpiPO();
      await _getKpiInvoice();
      await _getLeads();
      await _getSalesOrder();
      await _getInvoice();
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  color: ColorConstant.whiteColor,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 3),
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
                                ? pie.PieChart(
                                    dataMap: kpiPOList,
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: colorList,
                                    initialAngleInDegree: 0,
                                    chartType: pie.ChartType.ring,
                                    ringStrokeWidth: 20,
                                    centerText: "",
                                    legendOptions: const pie.LegendOptions(
                                      showLegendsInRow: true,

                                      legendPosition: pie.LegendPosition.bottom,
                                      showLegends: true,
                                      // legendShape: _BoxShape.circle,

                                      legendTextStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    chartValuesOptions:
                                        const pie.ChartValuesOptions(
                                      showChartValueBackground: false,
                                      showChartValues: true,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 1,
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: MediaQuery.of(context).size.height *
                                        .25,
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
                                ? pie.PieChart(
                                    dataMap: kpiInvoiceList,
                                    animationDuration:
                                        const Duration(milliseconds: 800),
                                    chartLegendSpacing: 32,
                                    chartRadius:
                                        MediaQuery.of(context).size.width / 3.2,
                                    colorList: colorList,
                                    initialAngleInDegree: 0,
                                    chartType: pie.ChartType.ring,
                                    ringStrokeWidth: 20,
                                    centerText: "",
                                    legendOptions: const pie.LegendOptions(
                                      showLegendsInRow: true,
                                      legendPosition: pie.LegendPosition.bottom,
                                      showLegends: true,
                                      // legendShape: _BoxShape.circle,
                                      legendTextStyle: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    chartValuesOptions:
                                        const pie.ChartValuesOptions(
                                      showChartValueBackground: false,
                                      showChartValues: true,
                                      showChartValuesInPercentage: false,
                                      showChartValuesOutside: false,
                                      decimalPlaces: 1,
                                    ),
                                  )
                                : Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    height: MediaQuery.of(context).size.height *
                                        .25,
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
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .43,
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
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 3),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton(
                              dropdownColor: ColorConstant.whiteColor,
                              icon: const Icon(
                                Icons.keyboard_arrow_down_sharp,
                                color: ColorConstant.greyDarkColor,
                              ),
                              isExpanded: true,
                              items: <String>["", "Actual", "Estimates"]
                                  .map((String value) {
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
                                graphType!,
                                maxLines: 1,
                                style: TextStyle(
                                  color: graphType == "By Type"
                                      ? ColorConstant.greyDarkColor
                                      : ColorConstant.bottomSheetColor,
                                  fontSize: 16,
                                  fontWeight: graphType == "By Type"
                                      ? FontWeight.w400
                                      : FontWeight.w500,
                                ),
                              ),
                              onChanged: (value) {
                                graphType = value!;

                                setState(() {});
                              },
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Text(
                            "PO",
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.greyBlueColor,
                                fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(width: 10),
                          CupertinoSwitch(
                            trackColor: ColorConstant.greyBlueColor,
                            onLabelColor: ColorConstant.blueDarkColor,
                            focusColor: ColorConstant.backgroundColor,
                            thumbColor: ColorConstant.blueDarkColor,
                            value: _switchValue,
                            onChanged: (bool value) {
                              setState(() {
                                _switchValue = value;
                              });
                            },
                            activeColor: CupertinoColors.activeGreen,
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            "Invoice",
                            style: TextStyle(
                                fontSize: 16,
                                color: ColorConstant.greyBlueColor,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                graphType == "By Type"
                    ? aRGraph()
                    : graphType == "Actual"
                        ? _switchValue == false
                            ? actualPoGraph()
                            : actualInvoiceGraph()
                        : graphType == "Estimates"
                            ? _switchValue == false
                                ? estimatesPoGraph()
                                : estimatesInvoiceGraph()
                            : const SizedBox(),
                const SizedBox(
                  height: 70,
                ),
              ],
            ),
          ),
          isLoading ? const ShowProgressBar() : const SizedBox(),
        ],
      ),
    );
  }

  Widget aRGraph() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "AR",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  salesLeadYear!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.greyDarkColor),
                )
              ],
            ),
          ),
          Container(
            alignment: Alignment.topLeft,
            width: MediaQuery.of(context).size.width * .9,
            height: 1,
            color: ColorConstant.greyColor,
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstant.greyBlueColor,
              ),
              color: ColorConstant.whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Dept>(
                  dropdownColor: ColorConstant.whiteColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ColorConstant.greyDarkColor,
                  ),
                  isExpanded: true,
                  items: invoiceDepartment.map((Dept value) {
                    return DropdownMenuItem<Dept>(
                      value: value,
                      child: Text(
                        value.name!,
                      ),
                    );
                  }).toList(),
                  style: const TextStyle(
                    color: ColorConstant.greyBlueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text(
                    selectedInvoiceDepartment != null
                        ? selectedInvoiceDepartment!.name!
                        : "Select Department",
                    maxLines: 1,
                    style: TextStyle(
                      color: selectedInvoiceDepartment == null
                          ? ColorConstant.greyBlueColor
                          : ColorConstant.blackColor,
                      fontSize: selectedInvoiceDepartment == null ? 16 : 18,
                      fontWeight: selectedInvoiceDepartment == null
                          ? FontWeight.w400
                          : FontWeight.w600,
                    ),
                  ),
                  onChanged: (value) {
                    selectedInvoiceDepartment = value;
                    arGraphData = [
                      _SalesData('Overdue (>30 days)', 0),
                      _SalesData('Overdue (>15 days)', 0),
                      _SalesData('Overdue (<15 days)', 0),
                      _SalesData('Due in 15 days', 0),
                      _SalesData('Due in 30 days', 0),
                      _SalesData('Due in < 30 days', 0),
                    ];
                    _getInvoiceListAR();
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 2,
              child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  isTransposed: false,
                  legend: const Legend(
                    isVisible: false,
                  ),
                  enableAxisAnimation: true,
                  title: ChartTitle(text: _getArAmountTotal()),
                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                  ),
                  series: <CartesianSeries<_SalesData, String>>[
                    BarSeries<_SalesData, String>(
                        dataSource: arGraphData,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales Actual PO',

                        // Enable data label
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ))
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget actualPoGraph() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Actual Po",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  salesLeadYear!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.greyDarkColor),
                )
              ],
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstant.greyBlueColor,
              ),
              color: ColorConstant.whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<order.Department>(
                  dropdownColor: ColorConstant.whiteColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ColorConstant.greyDarkColor,
                  ),
                  isExpanded: true,
                  items: salesOrderDepartment.map((order.Department value) {
                    return DropdownMenuItem<order.Department>(
                      value: value,
                      child: Text(
                        value.name!,
                      ),
                    );
                  }).toList(),
                  style: const TextStyle(
                    color: ColorConstant.greyBlueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text(
                    selectedOrderDepartment != null
                        ? selectedOrderDepartment!.name!
                        : "Select Department",
                    maxLines: 1,
                    style: TextStyle(
                      color: selectedOrderDepartment == null
                          ? ColorConstant.greyBlueColor
                          : ColorConstant.blackColor,
                      fontSize: selectedOrderDepartment == null ? 16 : 18,
                      fontWeight: selectedOrderDepartment == null
                          ? FontWeight.w400
                          : FontWeight.w600,
                    ),
                  ),
                  onChanged: (value) {
                    selectedOrderDepartment = value;
                    salesOrderActualPo = [
                      _SalesData('Apr', 0),
                      _SalesData('May', 0),
                      _SalesData('Jun', 0),
                      _SalesData('Jul', 0),
                      _SalesData('Aug', 0),
                      _SalesData('Set', 0),
                      _SalesData('Oct', 0),
                      _SalesData('Nov', 0),
                      _SalesData('Dec', 0),
                      _SalesData('Jan', 0),
                      _SalesData('Feb', 0),
                      _SalesData('Mar', 0),
                    ];
                    _getSalesOrderYearDataPo();
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 2,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                isTransposed: false,
                legend: const Legend(
                  isVisible: false,
                ),
                enableAxisAnimation: true,
                title: ChartTitle(text: _getActualPOTotal()),
                // Enable tooltip
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                ),
                series: <CartesianSeries<_SalesData, String>>[
                  BarSeries<_SalesData, String>(
                    dataSource: salesOrderActualPo,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales Actual PO',

                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(
                      isVisible: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget actualInvoiceGraph() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Actual Invoice",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  salesLeadYear!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.greyDarkColor),
                )
              ],
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstant.greyBlueColor,
              ),
              color: ColorConstant.whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Dept>(
                  dropdownColor: ColorConstant.whiteColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ColorConstant.greyDarkColor,
                  ),
                  isExpanded: true,
                  items: invoiceDepartment.map((Dept value) {
                    return DropdownMenuItem<Dept>(
                      value: value,
                      child: Text(
                        value.name!,
                      ),
                    );
                  }).toList(),
                  style: const TextStyle(
                    color: ColorConstant.greyBlueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text(
                    selectedInvoiceDepartmentActualInvoice != null
                        ? selectedInvoiceDepartmentActualInvoice!.name!
                        : "Select Department",
                    maxLines: 1,
                    style: TextStyle(
                      color: selectedInvoiceDepartmentActualInvoice == null
                          ? ColorConstant.greyBlueColor
                          : ColorConstant.blackColor,
                      fontSize: selectedInvoiceDepartmentActualInvoice == null
                          ? 16
                          : 18,
                      fontWeight: selectedInvoiceDepartmentActualInvoice == null
                          ? FontWeight.w400
                          : FontWeight.w600,
                    ),
                  ),
                  onChanged: (value) {
                    selectedInvoiceDepartmentActualInvoice = value;
                    salesOrderActualInvoice = [
                      _SalesData('Apr', 0),
                      _SalesData('May', 0),
                      _SalesData('Jun', 0),
                      _SalesData('Jul', 0),
                      _SalesData('Aug', 0),
                      _SalesData('Set', 0),
                      _SalesData('Oct', 0),
                      _SalesData('Nov', 0),
                      _SalesData('Dec', 0),
                      _SalesData('Jan', 0),
                      _SalesData('Feb', 0),
                      _SalesData('Mar', 0),
                    ];

                    _getInvoiceListActualInvoice();
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1.6,
              child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  isTransposed: false,
                  // Chart title
                  title: ChartTitle(text: _getActualInvoiceTotal()),

                  // Enable legend
                  legend: const Legend(
                    isVisible: false,
                  ),
                  enableAxisAnimation: true,

                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                  ),
                  series: <CartesianSeries<_SalesData, String>>[
                    BarSeries<_SalesData, String>(
                        dataSource: salesOrderActualInvoice,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales Actual PO',

                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget estimatesPoGraph() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Estimates Po",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  salesLeadYear!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.greyDarkColor),
                )
              ],
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstant.greyBlueColor,
              ),
              color: ColorConstant.whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<Department>(
                  dropdownColor: ColorConstant.whiteColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ColorConstant.greyDarkColor,
                  ),
                  isExpanded: true,
                  items: salesDepartment.map((Department value) {
                    return DropdownMenuItem<Department>(
                      value: value,
                      child: Text(
                        value.name!,
                      ),
                    );
                  }).toList(),
                  style: const TextStyle(
                    color: ColorConstant.greyBlueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text(
                    selectedOrderDepartmentEstimatedPo != null
                        ? selectedOrderDepartmentEstimatedPo!.name!
                        : "Select Department",
                    maxLines: 1,
                    style: TextStyle(
                      color: selectedOrderDepartmentEstimatedPo == null
                          ? ColorConstant.greyBlueColor
                          : ColorConstant.blackColor,
                      fontSize:
                          selectedOrderDepartmentEstimatedPo == null ? 16 : 18,
                      fontWeight: selectedOrderDepartmentEstimatedPo == null
                          ? FontWeight.w400
                          : FontWeight.w600,
                    ),
                  ),
                  onChanged: (value) {
                    selectedOrderDepartmentEstimatedPo = value;
                    salesActualPo = [
                      _SalesData('Apr', 0),
                      _SalesData('May', 0),
                      _SalesData('Jun', 0),
                      _SalesData('Jul', 0),
                      _SalesData('Aug', 0),
                      _SalesData('Set', 0),
                      _SalesData('Oct', 0),
                      _SalesData('Nov', 0),
                      _SalesData('Dec', 0),
                      _SalesData('Jan', 0),
                      _SalesData('Feb', 0),
                      _SalesData('Mar', 0),
                    ];

                    _getSalesLeadYearData();
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1.6,
              child: SfCartesianChart(
                primaryXAxis: const CategoryAxis(),
                isTransposed: false,
                title: ChartTitle(text: _getEstimatedPOTotal()),
                legend: const Legend(
                  isVisible: false,
                ),
                enableAxisAnimation: true,

                // Enable tooltip
                tooltipBehavior: TooltipBehavior(
                  enable: true,
                ),
                series: <CartesianSeries<_SalesData, String>>[
                  BarSeries<_SalesData, String>(
                    dataSource: salesActualPo,
                    xValueMapper: (_SalesData sales, _) => sales.year,
                    yValueMapper: (_SalesData sales, _) => sales.sales,
                    name: 'Sales Actual PO',

                    // Enable data label
                    dataLabelSettings: const DataLabelSettings(isVisible: true),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget estimatesInvoiceGraph() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: ColorConstant.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Estimate Invoice",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                ),
                Text(
                  salesLeadYear!,
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: ColorConstant.greyDarkColor),
                )
              ],
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
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              border: Border.all(
                color: ColorConstant.greyBlueColor,
              ),
              color: ColorConstant.whiteColor,
              borderRadius: BorderRadius.circular(5),
            ),
            height: 45,
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<order.Department>(
                  dropdownColor: ColorConstant.whiteColor,
                  icon: const Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: ColorConstant.greyDarkColor,
                  ),
                  isExpanded: true,
                  items: salesOrderDepartment.map((order.Department value) {
                    return DropdownMenuItem<order.Department>(
                      value: value,
                      child: Text(
                        value.name!,
                      ),
                    );
                  }).toList(),
                  style: const TextStyle(
                    color: ColorConstant.greyBlueColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                  hint: Text(
                    selectedOrderDepartmentEstimatedInvoice != null
                        ? selectedOrderDepartmentEstimatedInvoice!.name!
                        : "Select Department",
                    maxLines: 1,
                    style: TextStyle(
                      color: selectedOrderDepartmentEstimatedInvoice == null
                          ? ColorConstant.greyBlueColor
                          : ColorConstant.blackColor,
                      fontSize: selectedOrderDepartmentEstimatedInvoice == null
                          ? 16
                          : 18,
                      fontWeight:
                          selectedOrderDepartmentEstimatedInvoice == null
                              ? FontWeight.w400
                              : FontWeight.w600,
                    ),
                  ),
                  onChanged: (value) {
                    selectedOrderDepartmentEstimatedInvoice = value;
                    salesOrderEstimatedInvoice = [
                      _SalesData('Apr', 0),
                      _SalesData('May', 0),
                      _SalesData('Jun', 0),
                      _SalesData('Jul', 0),
                      _SalesData('Aug', 0),
                      _SalesData('Set', 0),
                      _SalesData('Oct', 0),
                      _SalesData('Nov', 0),
                      _SalesData('Dec', 0),
                      _SalesData('Jan', 0),
                      _SalesData('Feb', 0),
                      _SalesData('Mar', 0),
                    ];

                    _getSalesOrderYearDataInvoice();
                    setState(() {});
                  },
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 1.6,
              child: SfCartesianChart(
                  primaryXAxis: const CategoryAxis(),
                  isTransposed: false,
                  title: ChartTitle(text: _getEstimatedInvoiceTotal()),
                  legend: const Legend(
                    isVisible: false,
                  ),
                  enableAxisAnimation: true,

                  // Enable tooltip
                  tooltipBehavior: TooltipBehavior(
                    enable: true,
                  ),
                  series: <CartesianSeries<_SalesData, String>>[
                    BarSeries<_SalesData, String>(
                        dataSource: salesOrderEstimatedInvoice,
                        xValueMapper: (_SalesData sales, _) => sales.year,
                        yValueMapper: (_SalesData sales, _) => sales.sales,
                        name: 'Sales Actual PO',

                        // Enable data label
                        dataLabelSettings:
                            const DataLabelSettings(isVisible: true))
                  ]),
            ),
          ),
        ],
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
          (kpiPoApiResponse[i].total! / pow(7, 7));
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
          (kpiInvoiceApiResponse[i].total! / pow(7, 7));
    }
    setState(() {
      isLoading = false;
    });
  }

  _getLeads() async {
    try {
      setState(() {
        isLoading = true;
      });
      salesLead = [];

      SalesLeadRes response =
          await SalesLeadRepository().salesLeadApiCall(year: salesLeadYear);
      if (response.results!.isNotEmpty) {
        salesLead = response.results!;
        _getSalesLeadYearData();
        _getSalesLeadDepartment();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getSalesLeadDepartment() {
    for (int leadCount = 0; leadCount < salesLead.length; leadCount++) {
      if (salesLead[leadCount].department != null) {
        var contain = salesDepartment.where((element) =>
            element.id.toString() ==
            salesLead[leadCount].department!.id.toString());
        if (contain.isEmpty) {
          salesDepartment.add(salesLead[leadCount].department!);
        }
      }
    }
  }

  _getSalesOrder() async {
    try {
      setState(() {
        isLoading = true;
      });
      salesOrder = [];

      order.SalesOrderRes response =
          await SalesOrderRepository().salesOrderApiCall(year: salesLeadYear);
      if (response.results!.isNotEmpty) {
        salesOrder = response.results!;
        _getSalesOrderYearDataPo();
        _getSalesOrderYearDataInvoice();
        _getOrderDepartment();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getOrderDepartment() {
    for (int leadCount = 0; leadCount < salesOrder.length; leadCount++) {
      if (salesOrder[leadCount].department != null) {
        var contain = salesOrderDepartment.where((element) =>
            element.id.toString() ==
            salesOrder[leadCount].department!.id.toString());
        if (contain.isEmpty) {
          salesOrderDepartment.add(salesOrder[leadCount].department!);
        }
      }
    }
  }

  _getInvoice() async {
    try {
      setState(() {
        isLoading = true;
      });
      invoiceData = [];

      InvoiceRes response =
          await InvoiceRepository().invoiceApiCall(year: salesLeadYear);
      if (response.results!.isNotEmpty) {
        invoiceData = response.results!;

        _getTotal();
        _getInvoiceDepartment();
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  _getInvoiceDepartment() {
    for (int leadCount = 0; leadCount < invoiceData.length; leadCount++) {
      if (invoiceData[leadCount].dept != null) {
        var contain = invoiceDepartment.where((element) =>
            element.id.toString() ==
            invoiceData[leadCount].dept!.id.toString());
        if (contain.isEmpty) {
          invoiceDepartment.add(invoiceData[leadCount].dept!);
        }
      }
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
        if (invoiceData[i].paymentTerm?.id == 1) {
          invoiceData[i].expireData = invoiceData[i].invoiceDate;
          invoiceData[i].age = "0";
        }
        if (invoiceData[i].paymentTerm?.id == 2) {
          invoiceData[i].expireData = invoiceData[i].invoiceDate;
          invoiceData[i].age = "0";
        }
        if (invoiceData[i].paymentTerm?.id == 3) {
          invoiceData[i].expireData =
              (DateTime.parse(invoiceData[i].invoiceDate!).add(
            const Duration(days: 15),
          )).toString();
          invoiceData[i].age = "15";
        }
        if (invoiceData[i].paymentTerm?.id == 4) {
          invoiceData[i].expireData =
              (DateTime.parse(invoiceData[i].invoiceDate!).add(
            const Duration(days: 30),
          )).toString();
          invoiceData[i].age = "30";
        }
        if (invoiceData[i].paymentTerm?.id == 5) {
          invoiceData[i].expireData =
              (DateTime.parse(invoiceData[i].invoiceDate!).add(
            const Duration(days: 60),
          )).toString();
          invoiceData[i].age = "60";
        }
      }
      _getInvoiceListActualInvoice();
      _getInvoiceListAR();
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {});
    }
  }

  _getSalesLeadYearData() {
    for (int j = 0; j < salesActualPo.length; j++) {
      for (int i = 0; i < salesLead.length; i++) {
        if (DateFormat('dd-MMM-yyyy')
            .format(
              DateTime.parse(salesLead[i].created!),
            )
            .contains(salesActualPo[j].year)) {
          if (selectedOrderDepartmentEstimatedPo == null) {
            salesActualPo[j].sales =
                salesActualPo[j].sales + double.parse(salesLead[i].total!);
          } else {
            if (selectedOrderDepartmentEstimatedPo?.id ==
                salesLead[i].department?.id) {
              salesActualPo[j].sales =
                  salesActualPo[j].sales + double.parse(salesLead[i].total!);
            }
          }
        }
      }
    }
    setState(() {});
  }

  _getSalesOrderYearDataPo() {
    for (int j = 0; j < salesOrderActualPo.length; j++) {
      for (int i = 0; i < salesOrder.length; i++) {
        if (DateFormat('dd-MMM-yyyy')
            .format(
              DateTime.parse(salesOrder[i].poDate!),
            )
            .contains(salesOrderActualPo[j].year)) {
          if (selectedOrderDepartment == null) {
            salesOrderActualPo[j].sales = salesOrderActualPo[j].sales +
                double.parse(salesOrder[i].total!);
          } else {
            if (selectedOrderDepartment?.id == salesOrder[i].department?.id) {
              salesOrderActualPo[j].sales = salesOrderActualPo[j].sales +
                  double.parse(salesOrder[i].total!);
            }
          }
        }
      }
    }
    setState(() {});
  }

  _getSalesOrderYearDataInvoice() {
    for (int j = 0; j < salesOrderEstimatedInvoice.length; j++) {
      for (int i = 0; i < salesOrder.length; i++) {
        if (DateFormat('dd-MMM-yyyy')
            .format(
              DateTime.parse(salesOrder[i].expectedInvDate!),
            )
            .contains(salesOrderEstimatedInvoice[j].year)) {
          if (selectedOrderDepartmentEstimatedInvoice == null) {
            salesOrderEstimatedInvoice[j].sales =
                salesOrderEstimatedInvoice[j].sales +
                    double.parse(salesOrder[i].total!);
          } else {
            if (selectedOrderDepartmentEstimatedInvoice?.id ==
                salesOrder[i].department?.id) {
              salesOrderEstimatedInvoice[j].sales =
                  salesOrderEstimatedInvoice[j].sales +
                      double.parse(salesOrder[i].total!);
            }
          }
        }
      }
    }
    setState(() {});
  }

  _getInvoiceListActualInvoice() {
    for (int j = 0; j < salesOrderActualInvoice.length; j++) {
      for (int i = 0; i < invoiceData.length; i++) {
        if (DateFormat('dd-MMM-yyyy')
            .format(
              DateTime.parse(invoiceData[i].paymentDate!),
            )
            .contains(salesOrderActualInvoice[j].year)) {
          if (selectedInvoiceDepartmentActualInvoice == null) {
            salesOrderActualInvoice[j].sales =
                salesOrderActualInvoice[j].sales +
                    double.parse(invoiceData[i].total!);
          } else {
            if (selectedInvoiceDepartmentActualInvoice?.id ==
                invoiceData[i].dept?.id) {
              salesOrderActualInvoice[j].sales =
                  salesOrderActualInvoice[j].sales +
                      double.parse(invoiceData[i].total!);
            }
          }
        }
      }
    }
    setState(() {});
  }

  _getInvoiceListAR() {
    for (int j = 0; j < arGraphData.length; j++) {
      String typeSelected = "0";
      if (arGraphData[j].year == "Overdue (>30 days)") {
        typeSelected = "0";
      }
      if (arGraphData[j].year == "Overdue (>15 days)") {
        typeSelected = "2";
      }
      if (arGraphData[j].year == "Due in 15 days") {
        typeSelected = "3";
      }
      if (arGraphData[j].year == "Due in 30 days") {
        typeSelected = "4";
      }
      if (arGraphData[j].year == "Due in < 30 days") {
        typeSelected = "5";
      }

      for (int i = 0; i < invoiceData.length; i++) {
        if (typeSelected == invoiceData[i].paymentTerm?.id.toString()) {
          if (selectedInvoiceDepartment == null) {
            arGraphData[j].sales =
                arGraphData[j].sales + double.parse(invoiceData[i].total!);
          } else {
            if (invoiceData[i].dept!.id == selectedInvoiceDepartment!.id) {
              arGraphData[j].sales =
                  arGraphData[j].sales + double.parse(invoiceData[i].total!);
            }
          }
        }
      }
    }
    setState(() {});
  }

  _getArAmountTotal() {
    double totalAmount = 0.0;
    for (int j = 0; j < arGraphData.length; j++) {
      totalAmount = totalAmount + arGraphData[j].sales;
    }
    return totalAmount.toString();
  }

  _getActualPOTotal() {
    double totalAmount = 0.0;
    for (int j = 0; j < salesOrderActualPo.length; j++) {
      totalAmount = totalAmount + salesOrderActualPo[j].sales;
    }
    return totalAmount.toString();
  }

  _getActualInvoiceTotal() {
    double totalAmount = 0.0;
    for (int j = 0; j < salesOrderActualInvoice.length; j++) {
      totalAmount = totalAmount + salesOrderActualInvoice[j].sales;
    }
    return totalAmount.toString();
  }

  _getEstimatedPOTotal() {
    double totalAmount = 0.0;
    for (int j = 0; j < salesActualPo.length; j++) {
      totalAmount = totalAmount + salesActualPo[j].sales;
    }
    return totalAmount.toString();
  }

  _getEstimatedInvoiceTotal() {
    double totalAmount = 0.0;
    for (int j = 0; j < salesOrderEstimatedInvoice.length; j++) {
      totalAmount = totalAmount + salesOrderEstimatedInvoice[j].sales;
    }
    return totalAmount.toString();
  }
}

class _SalesData {
  _SalesData(
    this.year,
    this.sales,
  );

  final String year;
  double sales;
}
