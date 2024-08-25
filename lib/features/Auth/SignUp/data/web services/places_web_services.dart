import 'package:dio/dio.dart';


class PlacesWebservices {
  late Dio dio;

  PlacesWebservices() {

    dio = Dio();
  }

  Future<List<dynamic>> fetchSuggestions(
      String place, String sessionToken) async {
    try {
      Response response = await dio.get(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:eg',
          'key': 'AIzaSyDBXX4GHuuSl6w2WYT9YTbRnkDJVgqjxsU',
          'sessiontoken': sessionToken
        },
      );
      print(response.data['predictions']);
      print(response.statusCode);
      return response.data['predictions'];
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  Future<dynamic> getPlaceLocation(String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
       'https://maps.googleapis.com/maps/api/place/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': 'AIzaSyDBXX4GHuuSl6w2WYT9YTbRnkDJVgqjxsU',
          'sessiontoken': sessionToken
        },
      );
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }


}