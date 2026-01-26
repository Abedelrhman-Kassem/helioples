import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/text_form_date.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/name_textfield.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/profile%20cubit/update_profile_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ChangeInfoBody extends StatelessWidget {
  final bool isLoading;
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController birthdayDateController;
  final DateTime initialDate;
  final UpdateProfileState state;
  final Widget updateButton;

  const ChangeInfoBody({
    super.key,
    required this.isLoading,
    required this.firstNameController,
    required this.lastNameController,
    required this.birthdayDateController,
    required this.initialDate,
    required this.state,
    required this.updateButton,
  });

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: isLoading,
      child: SingleChildScrollView(
        child: Column(
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
                SizedBox(width: 70.w),
                Text(
                  LocaleKeys.change_information_screen_profile_information.tr(),
                  style: Styles.styles16w400grey.copyWith(color: Colors.black),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Text(
              LocaleKeys
                  .change_information_screen_edit_your_personal_information
                  .tr(),
              style: Styles.styles25w600black,
            ),
            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: NameTextField(
                    isPassword: false,
                    labelText: LocaleKeys.change_information_screen_first_name
                        .tr(),
                    controller: firstNameController,
                    isEnabled: !isLoading,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: NameTextField(
                    isPassword: false,
                    labelText: LocaleKeys.change_information_screen_last_name
                        .tr(),
                    controller: lastNameController,
                    isEnabled: !isLoading,
                  ),
                ),
              ],
            ),
            SizedBox(height: 15.h),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.only(left: 10.w),
              child: Text(
                LocaleKeys.change_information_screen_birthday_date.tr(),
                style: Styles.styles14w400NormalBlack,
              ),
            ),
            SizedBox(height: 15.h),
            TextFormDate(
              initialDate: initialDate,
              onDateTimeChanged: (newDate) {},
              isEnabled: !isLoading,
              controller: birthdayDateController,
            ),
            SizedBox(height: 20.h),
            Center(child: updateButton),
            SizedBox(height: 300.h),
          ],
        ),
      ),
    );
  }
}
