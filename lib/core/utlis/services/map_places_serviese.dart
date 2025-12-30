import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';

class MapPlacesServiese {
  ApiService apiserviese;

  MapPlacesServiese(this.apiserviese);
  static const String _apiKey = "AIzaSyAu0m3tQS3f8P5xujTQviEJpWqfUgI5pVo";

  static const String _baseUrl =
      "https://maps.googleapis.com/maps/api/place/autocomplete/json";

  Future<Map<String, dynamic>> fetchPredictions(
    String input,
    String sessionToken,
    String language,
  ) async {
    var response = await apiserviese.get(
      endpoint:
          "$_baseUrl?input=$input&language=$language&key=$_apiKey&sessionToken=$sessionToken",
    );

    return response;
  }

  Future<Map<String, dynamic>> getPlaceDetails(
    String placeId,
    String sessionToken,
    String language,
  ) async {
    var response = await apiserviese.get(
      endpoint:
          "https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeId&language=$language&key=$_apiKey&sessionToken=$sessionToken",
    );
    return response;
  }
}
