import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/egypt_code_widget.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/Date_picker.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/name_textfield.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

class CahngeInformationScreen extends StatefulWidget {
  const CahngeInformationScreen({super.key});

  @override
  State<CahngeInformationScreen> createState() =>
      _CahngeInformationScreenState();
}

class _CahngeInformationScreenState extends State<CahngeInformationScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: "Omar");
  final TextEditingController lastNameController =
      TextEditingController(text: "Salah");
  final TextEditingController phoneNumberController =
      TextEditingController(text: "01116026564");
  final TextEditingController birthdayDateController =
      TextEditingController(text: "17/5/2002");
  final DateTime initialDate = DateTime(2002, 5, 17);

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    phoneNumberController.dispose();
    birthdayDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Positioned.fill(child: BackgroundImage()),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                     returnArrow(context: context, onTap: (){
                Navigator.of(context).pop();
              }),
                      SizedBox(
                        width: 70.w,
                      ),
                      Text(
                        "Profile Information",
                        style: Styles.styles16w400grey
                            .copyWith(color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    "Edit Your Personal Information",
                    style: Styles.styles25w600black,
                  ),
                  SizedBox(
                    height: 30.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: NameTextField(
                          labelText: "First Name",
                          controller: firstNameController,
                          isEnabled: true,
                        ),
                      ),
                      SizedBox(width: 20.w),
                      Expanded(
                        child: NameTextField(
                          labelText: "Last Name",
                          controller: lastNameController,
                          isEnabled: true,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      "Phone Number".tr(context),
                      style: Styles.styles14w400NormalBlack,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    children: [
                      const EgyptionCodeWidget(),
                      SizedBox(width: 10.w),
                      Expanded(
                        child: TextField(
                          controller: phoneNumberController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
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
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 16.w, vertical: 14.h),
                          ),
                          style: Styles.styles17w500NormalBlack,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Padding(
                    padding: EdgeInsets.only(left: 10.w),
                    child: Text(
                      "Birthday Date".tr(context),
                      style: Styles.styles14w400NormalBlack,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  DatePicker(labelText: " ", initialDate: initialDate),
                  SizedBox(height: 20.h),
                  Center(
                    child: SignUpCustomButton(
                      buttonText: "Save",
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          verficationChangesScreen,
                          arguments: {
                            'phoneNumber': phoneNumberController.text,
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 300.h,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
