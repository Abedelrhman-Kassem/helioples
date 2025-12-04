import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/branches_model.dart';
import 'package:negmt_heliopolis/features/Checkout/data/model/create_order_model.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class BranchesRow extends StatefulWidget {
  final BranchesModel branchesModel;
  final CreateOrderModel createOrderModel;
  const BranchesRow({
    super.key,
    required this.branchesModel,
    required this.createOrderModel,
  });

  @override
  State<BranchesRow> createState() => _BranchesRowState();
}

class _BranchesRowState extends State<BranchesRow> {
  late int selectedBranch;
  late List<Branches> branches;
  @override
  void initState() {
    selectedBranch = widget.branchesModel.branches?[0].id ?? 0;
    log(widget.branchesModel.branches.toString());
    branches = widget.branchesModel.branches!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    widget.createOrderModel.branchId = selectedBranch;

    BlocProvider.of<CreateOrderCubit>(context).branch = branches.firstWhere(
      (branch) => branch.id == selectedBranch,
    );

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.pickup_order_details_screen_pickup_branch.tr(),
            style: Styles.styles17w700Black.copyWith(
              color: const Color.fromRGBO(41, 41, 41, 1),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          GridView.builder(
            shrinkWrap: true,
            itemCount: branches.length,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 160.w,
              crossAxisSpacing: 7.w,
              mainAxisSpacing: 10.h,
              mainAxisExtent: 150.h,
              // childAspectRatio: 1 / 2,
            ),
            itemBuilder: (context, index) => BranchItem(
              key: ValueKey(branches[index].id),
              name: branches[index].name!,
              isSelected: branches[index].id == selectedBranch,
              onTap: () {
                setState(() {
                  selectedBranch = branches[index].id!;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

class BranchItem extends StatelessWidget {
  final String name;
  final void Function() onTap;
  final bool isSelected;
  const BranchItem({
    super.key,
    required this.onTap,
    required this.isSelected,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            "assets/Icons_logos/bracnh_image.png",
            width: 125.w,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              svgIcon(
                path: "assets/svg_icons/branch_icon.svg",
                color: isSelected
                    ? Colors.white
                    : Colors.white.withValues(alpha: 0.3),
                width: 50.w,
                height: 50.h,
              ),
              SizedBox(height: 5.h),
              Text(
                name,
                style: Styles.styles11w600White,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
