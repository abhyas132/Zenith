import 'dart:convert';

import 'package:zenith/utils/snackbar.dart';

import '../models/scheduleModel.dart';
import '../pages/form_page.dart';
import 'package:http/http.dart' as http;

class GetRequest {
  List<ScheduleModel> schedules = [];
  Future<void> getData() async {
    try {
      var Url = Uri.parse('${url}api/v1/create/schedule');

      var response = await http.post(Url);
      var jsonData = jsonDecode(response.body);

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
      print("No data fetched");
    }
  }
}
