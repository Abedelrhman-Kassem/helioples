import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/view_model/cubit/all_special_offer_cubit.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/widget/large_offers_grid.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/widget/small_offers_grid.dart';
import 'package:negmt_heliopolis/features/AllSpecialOffers/presentation/widget/loading_offers.dart';
import 'package:negmt_heliopolis/core/widgets/pagination_listener.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class AllSpecialOffersScreen extends StatefulWidget {
  const AllSpecialOffersScreen({super.key});

  @override
  State<AllSpecialOffersScreen> createState() => _AllSpecialOffersScreenState();
}

class _AllSpecialOffersScreenState extends State<AllSpecialOffersScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllSpecialOfferCubit()..getSpecialOffers(),
      child: BlocConsumer<AllSpecialOfferCubit, AllSpecialOfferState>(
        listener: (context, state) {
          if (state is FetchOffersFailed) {
            CustomSnackBar.show(
              context: context,
              duration: const Duration(seconds: 10),
              text: state.error,
              isGreen: false,
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              leading: returnArrow(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                LocaleKeys.all_special_offers_screen_special_offers.tr(),
                style: Styles.styles16w700interFamily,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0.r),
              child: BlocBuilder<AllSpecialOfferCubit, AllSpecialOfferState>(
                builder: (context, state) {
                  AllSpecialOfferCubit allSpecialOffersCubit =
                      BlocProvider.of<AllSpecialOfferCubit>(context);

                  return PaginationListener(
                    isLoading: allSpecialOffersCubit.isLoading,
                    onLoadMore: () {
                      allSpecialOffersCubit.getSpecialOffers();
                    },
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              if (allSpecialOffersCubit.isLoading &&
                                  allSpecialOffersCubit.offers.isEmpty)
                                LoadingOffers(
                                  crossAxisCount: allSpecialOffersCubit.isGrid
                                      ? 2
                                      : 1,
                                ),
                              if (allSpecialOffersCubit.offers.isNotEmpty) ...[
                                LargeOffersGrid(
                                  allSpecialOffersCubit: allSpecialOffersCubit,
                                ),
                                SmallOffersGrid(
                                  allSpecialOffersCubit: allSpecialOffersCubit,
                                ),
                              ],
                            ],
                          ),
                          if (allSpecialOffersCubit.isLoading &&
                              allSpecialOffersCubit.offers.isNotEmpty)
                            LoadingOffers(
                              crossAxisCount: allSpecialOffersCubit.isGrid
                                  ? 2
                                  : 1,
                            ),
                          SizedBox(height: 20.h),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
