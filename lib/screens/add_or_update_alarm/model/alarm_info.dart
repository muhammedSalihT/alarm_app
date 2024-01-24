class AlarmModel {
  int? id;
  String label;
  DateTime alarmSetTime;

  AlarmModel({
    this.id,
    required this.label,
    required this.alarmSetTime,
  });

  factory AlarmModel.fromMap(Map<String, dynamic> json) => AlarmModel(
        id: json["id"],
        label: json["label"],
        alarmSetTime: DateTime.parse(json["alarmSetTime"]),
      );
  Map<String, dynamic> toMap() => {
        "id": id,
        "label": label,
        "alarmSetTime": alarmSetTime.toIso8601String(),
      };
}
