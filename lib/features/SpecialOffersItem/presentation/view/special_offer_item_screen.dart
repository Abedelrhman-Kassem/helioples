import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view_model/cubit/special_offers_item_cubit.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class SpecialOfferItemScreen extends StatefulWidget {
  final int id;
  const SpecialOfferItemScreen({
    super.key,
    required this.id,
  });

  @override
  State<SpecialOfferItemScreen> createState() => _SpecialOfferItemScreenState();
}

class _SpecialOfferItemScreenState extends State<SpecialOfferItemScreen> {
  late Offer offer;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SpecialOffersItemCubit()..getOffer(id: widget.id),
      child: BlocConsumer<SpecialOffersItemCubit, SpecialOffersItemState>(
        listener: (context, state) {
          if (state is SpecialOffersSuccess) {
            offer = Offer(
              id: state.specialOfferItemModel.offer!.id,
              name: state.specialOfferItemModel.offer!.name,
              badge: state.specialOfferItemModel.offer!.badge,
              thumbnailImage: state.specialOfferItemModel.offer!.thumbnailImage,
              visits: state.specialOfferItemModel.offer!.visits,
              companyImage: state.specialOfferItemModel.offer!.companyImage,
              createdAt: state.specialOfferItemModel.offer!.createdAt,
              expiresAt: state.specialOfferItemModel.offer!.expiresAt,
              homeScreen: state.specialOfferItemModel.offer!.homeScreen,
            );
          }

          if (state is SpecialOffersFailed) {
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
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(17.0.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is SpecialOffersSuccess) ...[
                      SpecialOfferWidget(
                        offer: offer,
                        canNavigate: false,
                      ),
                      SizedBox(height: 30.h),
                      GridView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            state.specialOfferItemModel.offer!.products!.length,
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 220,
                          // childAspectRatio: 1 / 2,
                        ),
                        itemBuilder: (context, index) => ItemWidget(
                          relatedProductsModel: state
                              .specialOfferItemModel.offer!.products![index],
                        ),
                      ),
                    ] else
                      Skeletonizer(
                        child: Column(
                          children: [
                            Helper.loadNetworkImage(
                              assetsErrorPath:
                                  'assets/screens_background/home-category.png',
                            ),
                            SizedBox(height: 30.h),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: 9,
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                maxCrossAxisExtent: 150,
                                crossAxisSpacing: 7,
                                mainAxisSpacing: 10,
                                mainAxisExtent: 220,
                              ),
                              itemBuilder: (context, index) => Skeletonizer(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 25, horizontal: 10),
                                  height: 240,
                                  width: 130,
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Icon(Icons.heart_broken),
                                        ],
                                      ),
                                      Helper.loadNetworkImage(
                                        assetsErrorPath:
                                            'assets/screens_background/home-category.png',
                                      ),
                                      const Text('hello there'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
