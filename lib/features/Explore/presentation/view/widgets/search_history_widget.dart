import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view/widgets/search_delegate.dart';
import 'package:negmt_heliopolis/features/Explore/presentation/view_model/cubit/explore_cubit.dart';

Widget searchHistoryWidget({
  required BuildContext context,
  required String text,
  required void Function() getSearchHistory,
}) {
  ExploreCubit exploreCubit = BlocProvider.of<ExploreCubit>(context);

  return InkWell(
    onTap: () async {
      await showSearch(
        context: context,
        delegate: CustomSearchDelegate(exploreCubit, historyValue: text),
      );

      getSearchHistory();
    },
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: 13.w,
        vertical: 10.h,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.r),
        border: Border.all(
          width: 0.5.r,
          color: const Color.fromRGBO(170, 170, 170, 1),
        ),
      ),
      child: Text(
        text,
        style: Styles.styles11w300NormalBlack,
      ),
    ),
  );
}
