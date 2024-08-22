import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'all_special_offer_state.dart';

class AllSpecialOfferCubit extends Cubit<AllSpecialOfferState> {
  AllSpecialOfferCubit() : super(AllSpecialOfferInitial());
}
