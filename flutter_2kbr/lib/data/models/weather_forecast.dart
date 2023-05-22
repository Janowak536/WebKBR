class WeatherForecast {
  DateTime date;
  int temperatureC;
  int temperatureF;
  String summary;

  WeatherForecast({
    required this.date,
    required this.temperatureC,
    required this.temperatureF,
    required this.summary,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: DateTime.parse(json['date']),
      temperatureC: json['temperatureC'],
      temperatureF: json['temperatureF'],
      summary: json['summary'],
    );
  }
}
