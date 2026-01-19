import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:negmt_heliopolis/features/Profile/presentation/view/help%20center%20screens/widgets/report_app_bar.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/help%20center%20screens/widgets/report_image_upload_section.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/help%20center%20screens/widgets/report_message_text_field.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/help%20center%20screens/widgets/report_submit_button.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
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
          LocaleKeys.report_screen_choose_image_source.tr(),
          style: Styles.styles12w600Black.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.camera_alt, color: MyColors.mainColor),
              title: Text(LocaleKeys.report_screen_camera.tr()),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage("Camera");
              },
            ),
            ListTile(
              leading: Icon(Icons.photo, color: MyColors.mainColor),
              title: Text(LocaleKeys.report_screen_gallery.tr()),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage("Gallery");
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsetsDirectional.only(
          start: 16.w,
          end: 16.w,
          top: 60.h,
          bottom: 10.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ReportAppBar(),
            SizedBox(height: 25.h),
            ReportMessageTextField(controller: messageController),
            SizedBox(height: 20.h),
            ReportImageUploadSection(
              selectedImage: _selectedImage,
              onTap: _showImageSourceDialog,
            ),
            SizedBox(height: 20.h),
            ReportSubmitButton(
              messageController: messageController,
              selectedImagePath: _selectedImage?.path,
            ),
          ],
        ),
      ),
    );
  }
}
