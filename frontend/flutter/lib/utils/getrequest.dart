import 'dart:convert';

import '../models/scheduleModel.dart';
import '../pages/form_page.dart';
import 'package:http/http.dart' as http;

class GetRequest {
  List<ScheduleModel> schedules = [];
  Future<void> getData() async {
    var Url = Uri.parse('${url}api/v1/create/schedule');
    var response = await http.get(Url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == 200) {
      jsonData['schedule'].forEach((element) {
        ScheduleModel scheduleModel = ScheduleModel(
            title: element['title'],
            description: element['description'],
            startTime: element['startTime'],
            endTime: element['endTime']);
        schedules.add(scheduleModel);
      });
    }
  }
}
