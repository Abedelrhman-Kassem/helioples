


import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/place.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/data/model/place_suggestion.dart';

abstract class MapsState {}

class MapsInitial extends MapsState {}

class PlacesLoaded extends MapsState {
  final List<PlaceSuggestion> places;

  PlacesLoaded(this.places);

}

class PlaceLocationLoaded extends MapsState {
  final Place place;

  PlaceLocationLoaded(this.place);

}


