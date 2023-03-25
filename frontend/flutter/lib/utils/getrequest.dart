import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:zenith/utils/snackbar.dart';

import '../models/scheduleModel.dart';
import '../pages/form_page.dart';
import 'package:http/http.dart' as http;

class GetRequest {
  List<ScheduleModel> schedules = [];
  Future<void> getData() async {
    try {
      var Url = Uri.parse('${url}api/v1/create/schedule');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');
      print(token);
      var response = await http.post(
        Uri.parse('${url}api/v1/get/schedule'),
        body: {"name": "name"},
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': token!
        },
      );

      var jsonData = jsonDecode(response.body);
      print(response.body);
      if (jsonData['status'] == 200) {
        jsonData['schedule'].forEach((element) {
          ScheduleModel scheduleModel = ScheduleModel(
            description: element['description'],
            duration: element['duration'] == null ? '0' : element['duration'],
            endTime: element['endTime'],
            startTime: element['startTime'],
            title: element['title'],
          );
          schedules.add(scheduleModel);
          print(jsonData);
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }
}