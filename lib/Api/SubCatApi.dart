import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:thaliparamb_rozza/Api/networkutils.dart';



Future getSubCatApi() async {

  // var prefs = await SharedPreferences.getInstance();
  // var strId = prefs.getString('userId');
  // print(strId);

  final response = await http.post(
    baseUrl+banner,

    body: jsonEncode(<String, String>{

    }

    ),
  );
  var convertDataToJson = json.decode(response.body);
  // Map<String, dynamic> map = json.decode(response.body);
  // List<dynamic> data = map["sellerproducts"];
  return convertDataToJson;
}