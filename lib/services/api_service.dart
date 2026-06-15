import 'package:country_list_app/core/constant.dart';
import 'package:country_list_app/models/country_model.dart';
import 'package:dio/dio.dart';

class ApiService {
  late Dio dio;

  ApiService() {
    dio = Dio(BaseOptions(baseUrl: ApiConstants.baseUrl));

    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final key = ApiConstants.apiKey;
          options.headers["Authorization"] = "Bearer $key";
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<CountryModel>> getCountries({
    required int limit,
    required int offset,
  }) async {
    final response = await dio.get(
      "",
      queryParameters: {
        "limit": limit,
        "offset": offset,
        "response_fields": "names.common,capitals.name,flag.url_png",
      },
    );

    final List items = response.data["data"]["objects"];

    return items.map((e) => CountryModel.fromJson(e)).toList();
  }

  Future<List<CountryModel>> searchCountries(String query) async {
    final response = await dio.get(
      "",
      queryParameters: {
        "q": query,
        "limit": 20,
        "response_fields": "names.common,capitals.name,flag.url_png",
      },
    );

    final List items = response.data["data"]["objects"];

    return items.map((e) => CountryModel.fromJson(e)).toList();
  }
}
