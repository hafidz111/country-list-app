import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiConstants {
  static const String baseUrl = "https://api.restcountries.com/countries/v5";

  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
