class ScheduleModel {
  int? startTime;
  int? endTime;
  String? title;
  String? description;
  String? uid;
  int? duration;
  ScheduleModel(
      {this.uid,
      this.description,
      this.duration,
      this.endTime,
      this.startTime,
      this.title});
}
