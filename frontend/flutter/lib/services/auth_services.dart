import 'dart:developer';

import 'package:zenith/globalvariables.dart';
import 'package:zenith/models/user_modal.dart';
import 'package:zenith/utils/snackbar.dart';
import 'package:http/http.dart' as http;

class AuthServices {
  final url = GlobalVariables.baseUrl;
  void signUp({
    required context,
    required name,
    required email,
    required password,
  }) async {
    try {
      User user = User(
        userId: '',
        name: name,
        email: email,
        password: password,
      );
      print("hh");
      final res = await http.post(Uri.parse('${url}api/v1/create/user'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      print(res.body);
      if (res.statusCode == 200) {
        //print(res.body);
      } else {
        ShowSnakBar(
          context: context,
          content: res.body,
        );
      }
    } catch (e) {
      ShowSnakBar(context: context, content: e.toString());
    }
  }
}
