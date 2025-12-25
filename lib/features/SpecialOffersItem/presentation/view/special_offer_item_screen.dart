import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/item_widget.dart';
import 'package:negmt_heliopolis/core/widgets/pagination_listener.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/core/widgets/special_offer_widget.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/widgets/loading_product.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view/widgets/special_offer_item_loading.dart';
import 'package:negmt_heliopolis/features/SpecialOffersItem/presentation/view_model/cubit/special_offers_item_cubit.dart';
import 'package:negmt_heliopolis/features/homeScreen/data/model/special_offer_model.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class SpecialOfferItemScreen extends StatefulWidget {
  final String id;
  const SpecialOfferItemScreen({
    super.key,
    required this.id,
  });

  @override
  State<SpecialOfferItemScreen> createState() => _SpecialOfferItemScreenState();
}

class _SpecialOfferItemScreenState extends State<SpecialOfferItemScreen> {
  Offer? offer;

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
              active: state.specialOfferItemModel.offer!.active,
              pagedProducts: state.specialOfferItemModel.offer!.pagedProducts,
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
          final cubit = context.read<SpecialOffersItemCubit>();
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
            body: PaginationListener(
              isLoading: cubit.isLoading,
              onLoadMore: () {
                cubit.getOffer(id: widget.id);
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  if (offer != null) ...[
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: EdgeInsets.all(17.0.r),
                        child: Column(
                          children: [
                            SpecialOfferWidget(
                              padding: 0,
                              offer: offer!,
                              canNavigate: false,
                            ),
                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 17.0.r),
                      sliver: SliverGrid(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 150,
                          crossAxisSpacing: 7,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 300.h,
                        ),
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            if (index < cubit.products.length) {
                              return ItemWidget(
                                relatedProductsModel: cubit.products[index],
                              );
                            } else {
                              return const LoadingProduct();
                            }
                          },
                          childCount:
                              cubit.products.length + (cubit.isLoading ? 6 : 0),
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(child: SizedBox(height: 20.h)),
                  ] else
                    const SliverToBoxAdapter(
                      child: SpecialOfferItemLoading(),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
