import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/notifiers/sub_categories_notifier.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/cart_counter.dart';
import 'package:negmt_heliopolis/core/widgets/categories_bottom_sheet.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Categories/data/model/sub_categories.dart';

class CustomAppbar extends StatefulWidget {
  final String categoryName;
  final List<SubCategories> subCategories;
  final List<GlobalKey> listKeys;
  final double sectionBtnWidth;
  final ScrollController listViewScrollController;

  const CustomAppbar({
    super.key,
    required this.categoryName,
    required this.subCategories,
    required this.listKeys,
    required this.sectionBtnWidth,
    required this.listViewScrollController,
  });

  @override
  State<CustomAppbar> createState() => _CustomAppbarState();
}

class _CustomAppbarState extends State<CustomAppbar> {
  SubCategoriesNotifier notifier = SubCategoriesNotifier();

  int activeSection = 0;

  void refreshState() {
    if (notifier.activeSection != activeSection) {
      activeSection = notifier.activeSection;
      setState(() {});
    }
  }

  @override
  void initState() {
    notifier.addListener(refreshState);

    super.initState();
  }

  @override
  void dispose() {
    notifier.removeListener(refreshState);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: returnArrow(
        context: context,
        onTap: () {
          Navigator.pop(context);
        },
      ),
      title: CategoriesBottomSheet(
        title: widget.categoryName,
      ),
      actions: const [
        CartCounter(),
      ],
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(70.h),
        child: Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(bottom: 15.h),
                height: 42.h,
                child: ListView.builder(
                  controller: widget.listViewScrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.subCategories.length,
                  itemBuilder: (context, index) {
                    print('bulid ');
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      width: widget.sectionBtnWidth,
                      decoration: BoxDecoration(
                        border: activeSection == index
                            ? null
                            : Border.all(
                                // strokeAlign: 1,
                                color: const Color.fromRGBO(
                                  170,
                                  170,
                                  170,
                                  1,
                                ),
                              ),
                        borderRadius: BorderRadius.circular(50.r),
                        color: activeSection == index
                            ? const Color.fromRGBO(0, 126, 143, 0.2)
                            : Colors.transparent,
                      ),
                      child: TextButton(
                        onPressed: () async {
                          notifier.allowFetch = false;

                          await Scrollable.ensureVisible(
                            widget.listKeys[index].currentContext!,
                            duration: const Duration(milliseconds: 1500),
                            curve: Curves.easeInOut,
                          );

                          notifier.activeSection = index;

                          Future.delayed(
                            const Duration(milliseconds: 5000),
                            () {
                              notifier.allowFetch = true;
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Helper.loadNetworkImage(
                              assetsErrorPath: 'assets/Icons_logos/Donuts.png',
                              url:
                                  widget.subCategories[index].bannerImage ?? '',
                              width: 30.w,
                            ),
                            const SizedBox(width: 10),
                            Container(
                              constraints: BoxConstraints(
                                maxWidth: 95.w,
                              ),
                              child: Text(
                                widget.subCategories[index].name ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: Styles.styles15w500interFamily.copyWith(
                                  color: const Color.fromRGBO(
                                    150,
                                    150,
                                    150,
                                    1,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
