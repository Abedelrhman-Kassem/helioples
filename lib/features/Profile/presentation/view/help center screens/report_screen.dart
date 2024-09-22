import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/name_textfield.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/phone_number_row.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: "Omar");
  final TextEditingController lastNameController =
      TextEditingController(text: "Salah");
  final TextEditingController phoneNumberController =
      TextEditingController(text: "01116026564");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(
            start: 16.w, end: 16.w, top: 60.h, bottom: 10.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                returnArrow(context: context, onTap: (){
                Navigator.of(context).pop();
              }),
                SizedBox(
                  width: 90.w,
                ),
                Text(
                  "Report An Issue",
                  style: Styles.styles16w400Black,
                ),
              ],
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: NameTextField(
                    labelText: "First Name",
                    controller: firstNameController,
                    isEnabled: false,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: NameTextField(
                    labelText: "Last Name",
                    controller: lastNameController,
                    isEnabled: false,
                  ),
                ),
              ],
            ),
            PhoneNumberRow(
              labelText: "Phone Number",
              controller: phoneNumberController,
            ),
            SizedBox(
              height: 14.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                "Your Message",
                style: Styles.styles14w400NormalBlack,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              minLines: 6,
              maxLines: 9,
              decoration: InputDecoration(
                hintText: "Enter Your Message In Details",
                hintStyle: Styles.styles17w500NormalBlack
                    .copyWith(color: const Color.fromRGBO(50, 50, 50, 1)),
                filled: true,
                fillColor: const Color.fromRGBO(246, 246, 246, 1),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(210, 210, 210, 1),
                    width: 1.5,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.r),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(210, 210, 210, 1),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.r),
                  borderSide: const BorderSide(
                    color: Color.fromRGBO(210, 210, 210, 1),
                    width: 1.5,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Center(
                child: SignUpCustomButton(
                    buttonText: "Submit Message", onPressed: () {}))
          ],
        ),
      ),
    );
  }
}
