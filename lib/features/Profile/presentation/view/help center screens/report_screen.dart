import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/custom_snack_bar.dart';
import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/name_textfield.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/phone_number_row.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/report.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo_imp.dart';
import 'dart:io';

import 'package:negmt_heliopolis/features/Profile/presentation/view_model/report%20cubit/report_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/report%20cubit/report_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final TextEditingController firstNameController =
      TextEditingController(text: "mohamed");
  final TextEditingController lastNameController =
      TextEditingController(text: "Hisham ");
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  File? _selectedImage;
  Future<void> _pickImage(String type) async {
    final ImagePicker picker = ImagePicker();

    if (type == "Camera") {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } else {
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    }
  }

  void _showImageSourceDialog() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                "Choose Image Source",
                style: Styles.styles12w600Black
                    .copyWith(fontSize: 18.sp, fontWeight: FontWeight.w600),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.camera_alt,
                      color: MyColors.mainColor,
                    ),
                    title: const Text("Camera"),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                      _pickImage("Camera");
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.photo,
                      color: MyColors.mainColor,
                    ),
                    title: const Text("Gallery"),
                    onTap: () {
                      Navigator.of(context).pop(); // Close the dialog
                      _pickImage("Gallery");
                    },
                  ),
                ],
              ),
            ));
  }

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
                returnArrow(
                    context: context,
                    onTap: () {
                      Navigator.of(context).pop();
                    }),
                SizedBox(
                  width: 90.w,
                ),
                Text(
                  LocaleKeys.report_screen_report_an_issue.tr(),
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
                    isPassword: false,
                    labelText: LocaleKeys.report_screen_first_name.tr(),
                    controller: firstNameController,
                    isEnabled: true,
                  ),
                ),
                SizedBox(width: 20.w),
                Expanded(
                  child: NameTextField(
                    isPassword: false,
                    labelText: LocaleKeys.report_screen_last_name.tr(),
                    controller: lastNameController,
                    isEnabled: true,
                  ),
                ),
              ],
            ),
            PhoneNumberRow(
              labelText: LocaleKeys.report_screen_phone_number.tr(),
              controller: phoneNumberController,
            ),
            SizedBox(
              height: 14.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w),
              child: Text(
                LocaleKeys.report_screen_your_message.tr(),
                style: Styles.styles14w400NormalBlack,
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            TextField(
              minLines: 6,
              maxLines: 9,
              controller: messageController,
              decoration: InputDecoration(
                hintText:
                    LocaleKeys.report_screen_enter_your_message_in_details.tr(),
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
              height: 20.h,
            ),
            Container(
              width: double.infinity,
              height: 60.h,
              decoration: BoxDecoration(
                  color: const Color.fromRGBO(246, 246, 246, 1),
                  borderRadius: BorderRadius.circular(20.r)),
              child: GestureDetector(
                onTap: _showImageSourceDialog,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.w),
                  child: Row(
                    children: [
                      if (_selectedImage != null) ...[
                        Image.file(
                          _selectedImage!,
                          width: 40.w,
                          height: 40.h,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 10.w),
                      ],
                      const Spacer(),
                      Text(
                        LocaleKeys.report_screen_upload.tr(),
                        style: Styles.styles13w400interFamily.copyWith(
                            fontWeight: FontWeight.w500,
                            color: MyColors.mainColor,
                            fontSize: 15.sp),
                      ),
                      SizedBox(
                        width: 8.w,
                      ),
                      Image.asset(
                        "assets/Icons_logos/gallery-export.png",
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 20.h,
            ),
            BlocProvider(
                create: (context) =>
                    ReportCubit(ProfileRepoImp(api: ApiService())),
                child: BlocConsumer<ReportCubit, SubmitReportState>(
                    builder: (context, state) {
                  var cubit = BlocProvider.of<ReportCubit>(context);
                  if (state is SubmitReportLoading) {
                    return const LoadingButton(
                      height: 60,
                      radius: 10,
                    );
                  } else {
                    return Center(
                        child: SignUpCustomButton(
                            buttonText:
                                LocaleKeys.report_screen_submit_message.tr(),
                            onPressed: () {
                              Report report = Report(
                                  firstName: firstNameController.text,
                                  imageUrl:
                                      "https://www.google.com/imgres?q=cristiano%20ronaldo&imgurl=https%3A%2F%2Fupload.wikimedia.org%2Fwikipedia%2Fcommons%2Fthumb%2Fd%2Fd7%2FCristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%252C_September_2023_%2528cropped%2529.jpg%2F640px-Cristiano_Ronaldo_playing_for_Al_Nassr_FC_against_Persepolis%252C_September_2023_%2528cropped%2529.jpg&imgrefurl=https%3A%2F%2Fen.wikipedia.org%2Fwiki%2FCristiano_Ronaldo&docid=CBspcpQflHogDM&tbnid=VxxZB7gC_IBLmM&vet=12ahUKEwj-vd3S6P6JAxUhTqQEHWmkKiUQM3oECBoQAA..i&w=640&h=837&hcb=2&ved=2ahUKEwj-vd3S6P6JAxUhTqQEHWmkKiUQM3oECBoQAA",
                                  lastName: lastNameController.text,
                                  phoneNumber: phoneNumberController.text,
                                  message: messageController.text);
                              print(report.firstName);
                              print(report.lastName);
                              print(report.message);
                              print(report.phoneNumber);
                              print(report.imageUrl);
                              print("rrrrrrr");

                              cubit.submitReport(report);
                            }));
                  }
                }, listener: (context, state) {
                  if (state is SubmitReportFailure) {
                    CustomSnackBar.show(
                      context: context,
                      duration: const Duration(milliseconds: 5000),
                      text: state.errorMessage,
                      isGreen: false,
                    );
                  } else if (state is SubmitReportSuccess) {
                    CustomSnackBar.show(
                      context: context,
                      duration: const Duration(milliseconds: 5000),
                      text: LocaleKeys.report_screen_report_an_issue.tr(),
                      isGreen: true,
                    );
                    Navigator.of(context).pushNamed(helpCenterScreen);
                  }
                }))
          ],
        ),
      ),
    );
  }
}
