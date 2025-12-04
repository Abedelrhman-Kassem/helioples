import 'package:bloc/bloc.dart';

import 'package:negmt_heliopolis/features/Auth/SignUp/data/repo/maps_repo.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view_model/set_location_cubit/set_location_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final MapsRepository mapsRepository;

  MapsCubit(this.mapsRepository) : super(MapsInitial());

  void emitPlaceSuggestions(String place, String sessionToken) {
    mapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PlacesLoaded(suggestions));
    });
  }

  void emitPlaceLocation(String placeId, String sessionToken) {
    mapsRepository.getPlaceLocation(placeId, sessionToken).then((place) {
      emit(PlaceLocationLoaded(place));
    });
  }
}
