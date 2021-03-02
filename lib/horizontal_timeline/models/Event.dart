
class EventData {
  String id;

  DateTime start;
  DateTime end;
  String label;

  String backgroundColor;
  String textColor;

  /// V kolikátem řádku mám event zobrazit?
  int rowNumber;

  EventData(
      {this.id,
      this.start,
      this.end,
      this.label,
      this.backgroundColor,
      this.textColor,
      this.rowNumber
      });

  String toString() =>
      "ID: $id Start: $start, End: $end, Label: $label, BG: $backgroundColor TC: $textColor  RowNumber: $rowNumber";

  factory EventData.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return EventData(
      id: map['id'] ?? "65989||12|1",
      rowNumber: map["rowNumber"] ?? 0,
      start: new DateTime(2021, 12, 3, map["startHour"], map["startMinute"]),
      end: new DateTime(2021, 12, 3, map["endHour"], map["endMinute"]),
      label: map['label'] ?? "",
      backgroundColor: map['backgroundColor'] ?? "#ff0089",
      textColor: map['textColor'] ?? "#ffffff",
    );
  }

}
