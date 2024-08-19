import 'package:dio/dio.dart';
import 'package:rokyapp/constants/strings.dart';

class CharactersWebServices {
  late Dio dio;

  CharactersWebServices() {
    BaseOptions options = BaseOptions(
      baseUrl: baseUrl,
      receiveDataWhenStatusError: true,
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    );
    dio = Dio(options);
  }

  Future<List<dynamic>> getAllCharacters() async {
    try {
      Response response = await dio.get('character');
      print('Response Data: ${response.data}');

      // Extracting the 'results' field from the response
      return response.data['results'] as List<dynamic>;
    } on DioException catch (e) {
      print('Request failed with status: ${e.response?.statusCode}');
      print('Response data: ${e.response?.data}');
      return [];
    }
  }
}
