import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/db_helper.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(MainInitial());

  List<Map<String, Object?>>? tableValues;
  Future<void> clearDb() async {
    tableValues = await DBHelper.queryData(table: cartItemTable);

    await DBHelper.deleteData(table: cartItemTable);
  }
}
