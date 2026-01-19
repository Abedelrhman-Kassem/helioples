import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/faqs.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/Widgets/accordion_item.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/profile%20cubit/faqs_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/profile%20cubit/faqs_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:shimmer/shimmer.dart';

class FaqsScreen extends StatelessWidget {
  const FaqsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          top: 60.h,
          bottom: 10.h,
        ),
        child: BlocProvider(
          create: (context) =>
              FaqsCubit(ProfileRepoImp(api: ApiService()))..fetchFaqs(),
          child: BlocBuilder<FaqsCubit, FetchFaqsState>(
            builder: (context, state) {
              if (state is FetchFaqsLoading) {
                return buildFaqsShimmer();
              } else if (state is FetchFaqsFailure) {
                return Center(child: Text(state.msg));
              } else if (state is FetchFaqsSuccess) {
                List<FaqsData> faqs = state.faqs;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        returnArrow(
                          context: context,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(width: 125.w),
                        Text(
                          LocaleKeys.help_center_screen_faqs.tr(),
                          style: Styles.styles16w400Black,
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Expanded(
                      child: ListView.builder(
                        itemCount: state.faqs.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5.h),
                            child: AccordionItem(
                              title: faqs[index].question!,
                              content: faqs[index].answer!,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}

Widget buildFaqsShimmer() {
  return Shimmer.fromColors(
    baseColor: Colors.grey[300]!,
    highlightColor: Colors.grey[100]!,
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(),
              SizedBox(width: 125.w),
              // Container(
              //   width: 10.w,
              //   height: 5.h,
              //   color: Colors.white,
              // )
            ],
          ),
          SizedBox(height: 40.h),
          Column(
            children: List.generate(10, (index) {
              return Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.0.w,
                  vertical: 5.h,
                ),
                child: Container(
                  width: double.infinity,
                  height: 70.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    ),
  );
}
