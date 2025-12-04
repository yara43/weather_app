class Weather {
  final String cityName;
  final double temperature;
  final String description;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final DateTime localTime;
  final DateTime sunrise;
  final DateTime sunset;
  final String iconCode;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.localTime,
    required this.sunrise,
    required this.sunset,
    required this.iconCode,
  });

  factory Weather.fromJson(Map<String, dynamic> json) {
    final main = json['main'] ?? {};
    final weatherList = json['weather'] as List<dynamic>? ?? [];
    final weather0 =
        weatherList.isNotEmpty ? weatherList[0] as Map<String, dynamic> : {};
    final wind = json['wind'] ?? {};
    final sys = json['sys'] ?? {};

    final int timezone = (json['timezone'] ?? 0) as int; // seconds offset
    final int dt = (json['dt'] ?? 0) as int;
    final int sunriseUnix = (sys['sunrise'] ?? 0) as int;
    final int sunsetUnix = (sys['sunset'] ?? 0) as int;

    final DateTime localTime = DateTime.fromMillisecondsSinceEpoch(
      (dt + timezone) * 1000,
      isUtc: true,
    );

    final DateTime sunrise = DateTime.fromMillisecondsSinceEpoch(
      (sunriseUnix + timezone) * 1000,
      isUtc: true,
    );

    final DateTime sunset = DateTime.fromMillisecondsSinceEpoch(
      (sunsetUnix + timezone) * 1000,
      isUtc: true,
    );

    return Weather(
      cityName: (json['name'] ?? '') as String,
      temperature: (main['temp'] ?? 0).toDouble(),
      description: (weather0['description'] ?? '') as String,
      feelsLike: (main['feels_like'] ?? 0).toDouble(),
      humidity: (main['humidity'] ?? 0) is int
          ? main['humidity'] as int
          : (main['humidity'] ?? 0).toInt(),
      windSpeed: (wind['speed'] ?? 0).toDouble(),
      localTime: localTime,
      sunrise: sunrise,
      sunset: sunset,
      iconCode: (weather0['icon'] ?? '') as String,
    );
  }

  String get iconUrl => 'https://openweathermap.org/img/wn/$iconCode@4x.png';
}
