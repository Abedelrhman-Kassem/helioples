import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'special_offers_item_state.dart';

class SpecialOffersItemCubit extends Cubit<SpecialOffersItemState> {
  SpecialOffersItemCubit() : super(SpecialOffersInitial());
}
