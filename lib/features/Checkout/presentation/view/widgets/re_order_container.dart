// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
// import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
// import 'package:negmt_heliopolis/core/widgets/svg_asset.dart';
// import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/create_order_cubit/create_order_cubit.dart';


// class ReOrderContainer extends StatelessWidget {

//   const ReOrderContainer({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return  Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.all(20.r),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           borderRadius: BorderRadius.circular(15.r),
//                         ),
//                         child: Column(
//                           children: [
//                             Text(
//                               'You can edit order’s terms and re-order',
//                               style: Styles.styles17w400interFamily,
//                             ),
//                             SizedBox(height: 10.h),
//                             Padding(
//                               padding: EdgeInsets.symmetric(horizontal: 18.w),
//                               child: Material(
//                                 color: Colors.transparent,
//                                 child: InkWell(
//                                   onTap: () {
//                                     BlocProvider.of<CreateOrderCubit>(context)
//                                         .createOrder(createOrderModel);
//                                   },
//                                   borderRadius: BorderRadius.circular(40.r),
//                                   splashColor:
//                                       MyColors.mainColor.withOpacity(0.5),
//                                   child: Container(
//                                     padding: EdgeInsets.symmetric(
//                                       horizontal: 64.w,
//                                       vertical: 20.h,
//                                     ),
//                                     decoration: BoxDecoration(
//                                       border: Border.all(
//                                         color: MyColors.mainColor,
//                                         width: 2.r,
//                                       ),
//                                       borderRadius: BorderRadius.circular(40.r),
//                                     ),
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       children: [
//                                         if (state is CreateOrderLoading)
//                                           Helper.loadingWidget()
//                                         else
//                                           svgIcon(
//                                             path:
//                                                 'assets/svg_icons/3d-rotate.svg',
//                                             width: 24.w,
//                                             height: 24.h,
//                                             color: MyColors.mainColor,
//                                           ),
//                                         SizedBox(width: 5.w),
//                                         Text(
//                                           'Re-Order',
//                                           style: Styles.styles17w500MainColor,
//                                         ),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       }
// }
