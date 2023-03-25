class ScheduleModel {
  String? uid;
  int? startTime;
  int? endTime;
  String? title;
  String? description;
  double? duration;
  ScheduleModel(
      {this.uid,
      this.description,
      this.duration,
      this.endTime,
      this.startTime,
      this.title});
}
