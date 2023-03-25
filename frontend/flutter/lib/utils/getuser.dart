import 'dart:convert';
import '../models/userModal.dart';
import '../pages/form_page.dart';
import 'package:http/http.dart' as http;

class GetUser {
  List<UserModal> users = [];
  Future<void> getData() async {
    var Url = Uri.parse('${url}api/v1/');
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
      });
      // users.sort(mySortComparison);
    }
  }

  // int mySortComparison(UserModal a, UserModal b) {
  //   int propertyA = a.zenCoins!;
  //   int propertyB = b.zenCoins!;
  //   if (propertyA > propertyB) {
  //     return -1;
  //   } else if (propertyA < propertyB) {
  //     return 1;
  //   } else {
  //     return 0;
  //   }
  // }
}
