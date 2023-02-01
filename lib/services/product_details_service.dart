import 'dart:convert';

import 'package:flutter/widgets.dart';
import 'package:no_name_ecommerce/model/product_details_model.dart';
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/view/utils/config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ProductDetailsService with ChangeNotifier {
  var productDetails;

  bool isLoading = false;

  setLoadingStatus(bool status) {
    isLoading = status;
    notifyListeners();
  }

  fetchProductDetails(BuildContext context, {required productId}) async {
    //check internet connection
    var connection = await checkConnection();
    if (!connection) return;
    //internet connection is on
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    print('product id $productId');

    //
    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      // "Authorization": "Bearer $token",
    };

    setLoadingStatus(true);

    var response = await http.get(Uri.parse('$baseApi/product/$productId'),
        headers: header);

    if (response.statusCode == 200) {
      productDetails = ProductDetailsModel.fromJson(jsonDecode(response.body));

      notifyListeners();
    } else {
      print('error fetching product details');
      print(response.body);
    }
  }
}
