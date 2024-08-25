
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/place.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/place_suggestion.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/web%20services/places_web_services.dart';

class MapsRepository {
  final PlacesWebservices placesWebservices;

  MapsRepository(this.placesWebservices);

  Future<List<PlaceSuggestion>> fetchSuggestions(
      String place, String sessionToken) async {
    final suggestions =
        await placesWebservices.fetchSuggestions(place, sessionToken);

    return suggestions
        .map((suggestion) => PlaceSuggestion.fromJson(suggestion))
        .toList();
  }

  Future<Place> getPlaceLocation(String placeId, String sessionToken) async {
    final place =
        await placesWebservices.getPlaceLocation(placeId, sessionToken);
    // var readyPlace = Place.fromJson(place);
    return Place.fromJson(place);
  }


}