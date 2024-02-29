import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wikitek/models/user_model.dart';
import 'package:wikitek/utility/colors.dart';
import 'package:wikitek/screens/home/home_screen.dart';

class AppConstant {
  static const String baseUrl = "http://143.244.142.0/api/v1/";
  static const String bearerToken = "null";
  static const String appName = "Wikitek";
  static UserData? userData;
  static List filterYears = [
    "2024 - 2025",
    "2023 - 2024",
    "2022 - 2023",
    "2021 - 2022",
  ];
  static List<SalesData> graphMonth = [
    SalesData('Mar', 0),
    SalesData('Feb', 0),
    SalesData('Jan', 0),
    SalesData('Dec', 0),
    SalesData('Nov', 0),
    SalesData('Oct', 0),
    SalesData('Set', 0),
    SalesData('Aug', 0),
    SalesData('Jul', 0),
    SalesData('Jun', 0),
    SalesData('May', 0),
    SalesData('Apr', 0),
  ];

  //for saving current user detail
  static saveUserDetail(String userDetail) async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('userDetail', userDetail);
  }

//for getting current user detail
  static Future getSavedUserDetail() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getString('userDetail');
  }
}

//for showing toast in app
Future toastShow({String? message}) {
  return Fluttertoast.showToast(
      msg: message!,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 3,
      backgroundColor: ColorConstant.whiteColor,
      textColor: ColorConstant.blackColor,
      fontSize: 16.0);
}
