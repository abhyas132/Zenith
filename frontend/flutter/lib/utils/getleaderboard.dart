import 'dart:convert';
import '../models/userModal.dart';
import 'package:http/http.dart' as http;

import '../pages/form_page.dart';

class GetLeaderBoard {
  List<UserModal> users = [];
  Future<void> getData() async {
    try {
      var Url = Uri.parse('${url}api/v1/all/user');
      var response = await http.get(Url);
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      if (jsonData['status'] == 200) {
        jsonData['users'].forEach((element) {
          UserModal userModel = UserModal(
              userId: element['userId'],
              name: element['name'],
              zenCoins: element['zenCoins']);
          users.add(userModel);
          print(userModel);
        });
        //}
      }
      users.sort(mySortComparison);
    } catch (e) {
      print("Not fetched leaderboard");
    }
  }

  int mySortComparison(UserModal a, UserModal b) {
    int propertyA = a.zenCoins!;
    int propertyB = b.zenCoins!;
    if (propertyA > propertyB) {
      return -1;
    } else if (propertyA < propertyB) {
      return 1;
    } else {
      return 0;
    }
  }
}
