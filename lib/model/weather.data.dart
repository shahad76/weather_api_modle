class WeatherData {
  final double maxtemp_c;
  final double temp_c;
  final double mintemp_c;
  final String last_updated;
  final String region;
  WeatherData(
      {required this.last_updated,
      required this.maxtemp_c,
      required this.mintemp_c,
      required this.region,
      required this.temp_c});
  @override
  String toString() {
    return '$maxtemp_c\n $last_updated \n $mintemp_c\n $temp_c\n $region ';
  }
}
