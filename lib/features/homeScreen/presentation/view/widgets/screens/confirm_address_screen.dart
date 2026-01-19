// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
// import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
// import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
// import 'package:negmt_heliopolis/features/maps/model/address_model.dart';

// class ConfirmAddress extends StatefulWidget {
//   final Address address;
//   const ConfirmAddress({super.key, required this.address});

//   @override
//   State<ConfirmAddress> createState() => _ConfirmAddressState();
// }

// class _ConfirmAddressState extends State<ConfirmAddress> {
//   @override
//   Widget build(BuildContext context) {
//     final formKey = GlobalKey<FormState>();

//     return SingleChildScrollView(
//       child: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 25.h),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   'Address Name',
//                   style: Styles.styles14w500interFamily.copyWith(
//                     color: const Color.fromRGBO(40, 40, 40, 1),
//                   ),
//                 ),
//                 // InkWell(
//                 //   onTap: () {
//                 //     Navigator.pop(context);
//                 //   },
//                 //   child: Text(
//                 //     'Back',
//                 //     style: Styles.styles14w400Black.copyWith(
//                 //       color: const Color.fromRGBO(41, 41, 41, 1),
//                 //     ),
//                 //   ),
//                 // ),
//               ],
//             ),
//             SizedBox(height: 10.h),
//             RichText(
//               text: TextSpan(
//                 text: 'Cairo, Egypt ',
//                 style: Styles.styles12w600Black.copyWith(
//                   color: const Color.fromRGBO(70, 70, 70, 1),
//                 ),
//                 children: [
//                   TextSpan(
//                     text:
//                         '8228 Imam Ali Road Riyadh 12345-6789 Kingdom Of Saudi Arabia Generate A Fake address',
//                     style: Styles.styles12w400black.copyWith(
//                       color: const Color.fromRGBO(70, 70, 70, 1),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.h),
//             Form(
//               key: formKey,
//               child: Column(
//                 children: [
//                   TextFormField(
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         widget.address.locationStr = value;
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter Address Name';
//                       }
//                       return null;
//                     },
//                     decoration: textInputDecoration('Enter Address Name'),
//                     cursorColor: MyColors.mainColor,
//                     style: Styles.styles17w700MainColor,
//                     textInputAction: TextInputAction.next,
//                   ),
//                   SizedBox(height: 10.h),
//                   TextFormField(
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         widget.address.buildingNo = value;
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter Building Number';
//                       }
//                       return null;
//                     },
//                     decoration: textInputDecoration('Enter Building Number'),
//                     cursorColor: MyColors.mainColor,
//                     style: Styles.styles17w700MainColor,
//                     textInputAction: TextInputAction.next,
//                   ),
//                   SizedBox(height: 10.h),
//                   TextFormField(
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         widget.address.floor = value;
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter Floor Number';
//                       }
//                       return null;
//                     },
//                     decoration: textInputDecoration('Enter Floor Number'),
//                     cursorColor: MyColors.mainColor,
//                     style: Styles.styles17w700MainColor,
//                     textInputAction: TextInputAction.next,
//                   ),
//                   SizedBox(height: 10.h),
//                   TextFormField(
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         widget.address.street = value;
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter Street Name';
//                       }
//                       return null;
//                     },
//                     decoration: textInputDecoration('Enter Street Name'),
//                     cursorColor: MyColors.mainColor,
//                     style: Styles.styles17w700MainColor,
//                     textInputAction: TextInputAction.next,
//                   ),
//                   SizedBox(height: 10.h),
//                   TextFormField(
//                     onChanged: (value) {
//                       if (value.isNotEmpty) {
//                         widget.address.department = value;
//                       }
//                     },
//                     validator: (value) {
//                       if (value == null || value.isEmpty) {
//                         return 'Please Enter Department';
//                       }
//                       return null;
//                     },
//                     decoration: textInputDecoration('Enter Department'),
//                     cursorColor: MyColors.mainColor,
//                     style: Styles.styles17w700MainColor,
//                     textInputAction: TextInputAction.done,
//                   ),
//                 ],
//               ),
//             ),
//             SizedBox(height: 20.h),
//             Row(
//               children: [
//                 Expanded(
//                   child: buttonWidget(
//                     color: MyColors.mainColor,
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 30.w,
//                       vertical: 20.h,
//                     ),
//                     borderRadius: 53.r,
//                     child: Text(
//                       'Save Address',
//                       style: Styles.styles17w600White,
//                     ),
//                     onTap: () {
//                       if (formKey.currentState!.validate()) {
//                         Navigator.pop(context, true);
//                       }
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 10.w),
//                 Expanded(
//                   child: buttonWidget(
//                     padding: EdgeInsets.symmetric(
//                       horizontal: 30.w,
//                       vertical: 20.h,
//                     ),
//                     borderRadius: 53.r,
//                     border: Border.all(color: MyColors.mainColor, width: 1.5.r),
//                     child: Text(
//                       'Use Once',
//                       style: Styles.styles17w600White.copyWith(
//                         color: MyColors.mainColor,
//                       ),
//                     ),
//                     onTap: () {
//                       if (formKey.currentState!.validate()) {
//                         Navigator.pop(context);
//                       }
//                     },
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// InputDecoration textInputDecoration(String hint) => InputDecoration(
//   contentPadding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
//   hintText: hint,
//   hintStyle: Styles.styles17w400interFamily.copyWith(
//     color: const Color.fromRGBO(181, 185, 190, 1),
//   ),
//   border: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(40.r),
//     borderSide: const BorderSide(
//       color: Color.fromRGBO(210, 210, 210, 1),
//       width: 1.0,
//     ),
//   ),
//   enabledBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(40.r),
//     borderSide: const BorderSide(
//       color: Color.fromRGBO(210, 210, 210, 1), // Color for enabled state
//       width: 1.0,
//     ),
//   ),
//   focusedBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(40.r),
//     borderSide: BorderSide(
//       color: MyColors.mainColor, // Color for focused state
//       width: 2.0, // Width for focused state
//     ),
//   ),
//   errorBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(40.r),
//     borderSide: const BorderSide(
//       color: Color.fromRGBO(255, 0, 0, 1), // Color for error state
//       width: 1.5,
//     ),
//   ),
//   focusedErrorBorder: OutlineInputBorder(
//     borderRadius: BorderRadius.circular(40.r),
//     borderSide: const BorderSide(
//       color: Color.fromRGBO(255, 50, 50, 1), // Color for focused error state
//       width: 2.0,
//     ),
//   ),
// );

// BoxDecoration containerBoxDecoration() => BoxDecoration(
//   color: const Color.fromRGBO(246, 246, 246, 1),
//   borderRadius: BorderRadius.circular(40.r),
//   border: Border.all(
//     color: const Color.fromRGBO(210, 210, 210, 1),
//     width: 1.5.r,
//   ),
// );
