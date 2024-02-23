import 'package:flutter/material.dart';

import 'package:wikitek/models/invoice/invoice_model.dart';

import 'package:wikitek/utility/colors.dart';

Widget arWidget({BuildContext? context, InvoiceData? invoiceData}) {
  return Padding(
    padding: const EdgeInsets.only(top: 10),
    child: Material(
      elevation: 1,
      borderRadius: BorderRadius.circular(5),
      child: Container(
        width: MediaQuery.of(context!).size.width,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        decoration: BoxDecoration(
          color: ColorConstant.whiteColor,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * .64,
                  child: Text(
                    '${invoiceData!.invoiceNumber.toString().substring(14, invoiceData.invoiceNumber!.length)}/${invoiceData.org?.companyName}',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width * .21,
                  child: Text(
                    invoiceData.invoiceDate ?? '',
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     SizedBox(
            //       width: MediaQuery.of(context).size.width * .8,
            //       child: Text(
            //         'Client: ${invoiceData.org?.companyName}',
            //         maxLines: 1,
            //         style: const TextStyle(
            //             fontSize: 14,
            //             fontFamily: "roboto",
            //             color: ColorConstant.greyDarkColor,
            //             fontWeight: FontWeight.w400),
            //       ),
            //     ),
            //     // SizedBox(
            //     //   width: MediaQuery.of(context).size.width * .43,
            //     //   child: Text(
            //     //     'Name: ${invoiceData.contactName}',
            //     //     textAlign: TextAlign.right,
            //     //     maxLines: 1,
            //     //     style: const TextStyle(
            //     //         fontSize: 14,
            //     //         fontFamily: "roboto",
            //     //         color: ColorConstant.greyDarkColor,
            //     //         fontWeight: FontWeight.w400),
            //     //   ),
            //     // ),
            //   ],
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  width: MediaQuery.of(context).size.width * .46,
                  child: Text(
                    "${(double.parse(invoiceData.total!) - double.parse(invoiceData.amountPaid!)).toStringAsFixed(2)} / ${double.parse(invoiceData.total!).toStringAsFixed(2)}",
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  width: MediaQuery.of(context).size.width * .4,
                  child: Text(
                    invoiceData.paymentDate!,
                    maxLines: 1,
                    style: const TextStyle(
                        fontSize: 14,
                        fontFamily: "roboto",
                        color: ColorConstant.greyDarkColor,
                        fontWeight: FontWeight.w400),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
