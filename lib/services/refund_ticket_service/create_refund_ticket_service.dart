// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:no_name_ecommerce/services/common_service.dart';
import 'package:no_name_ecommerce/services/refund_ticket_service/refund_ticket_service.dart';
import 'package:no_name_ecommerce/view/utils/api_url.dart';
import 'package:no_name_ecommerce/view/utils/others_helper.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateRefundTicketService with ChangeNotifier {
  bool isLoading = false;

  //create ticket ====>

  createTicket(title, subject, description, BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var token = prefs.getString('token');

    var header = {
      "Accept": "application/json",
      "Content-Type": "application/json",
      "Authorization": "Bearer $token",
    };

    var data = jsonEncode({
      'title': title,
      'subject': subject,
      'description': description,
    });

    var connection = await checkConnection();
    if (connection) {
      isLoading = true;
      notifyListeners();
      //if connection is ok
      var response = await http.post(Uri.parse(ApiUrl.createRefundTicketUri),
          headers: header, body: data);
      isLoading = false;
      notifyListeners();

      print(response.statusCode);
      if (response.statusCode == 200) {
        showToast('Ticket created successfully', Colors.black);

        //add ticket to ticket list
        Provider.of<RefundTicketService>(context, listen: false)
            .addNewDataToTicketList(jsonDecode(response.body)['ticket']['id'],
                title, subject, description, 'open');

        //======>
        Navigator.pop(context);
      } else {
        showToast('Something went wrong', Colors.black);
        print('ticket create failed ${response.body}');
      }
    }
  }
}