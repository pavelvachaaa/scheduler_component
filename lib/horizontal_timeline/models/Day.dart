class Day {
  var dayH;
  var dayN;
  var year;
  var month;
  var weekDay;

  final czech_days = [
    "Neděle",
    "Pondělí",
    "Úterý",
    "Středa",
    "Čtvrtek",
    "Pátek",
    "Sobota"
  ];

  Day({this.dayH, this.dayN, this.year, this.month, this.weekDay});

  factory Day.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Day(
      dayH: map['dayH'] ?? "",
      dayN: map['dayN'] ?? "",
      year: map['year'] ?? "",
      month: map['month'] ?? "",
      weekDay: map['weekDay'] ?? "",
    );
  }

  // Debug
  String toString() => "DayH: ${dayH} DayN: ${dayN} year ${year} month: ${month} weekDay ${dayH}";


  String get readableWeekDay => this.czech_days[int.parse(this.weekDay )];
}
