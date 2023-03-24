class ScheduleModel {
  int? startTime;
  int? endTime;
  String? title;
  String? description;
  String duration;
  ScheduleModel(
      {this.description,
      this.duration = '',
      this.endTime,
      this.startTime,
      this.title});
}
