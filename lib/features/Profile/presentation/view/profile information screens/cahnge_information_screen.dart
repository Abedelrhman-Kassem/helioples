import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/helper.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/background_image.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/profile%20cubit/update_profile_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/profile%20cubit/update_profile_states.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view/profile%20information%20screens/widgets/change_info_body.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class CahngeInformationScreen extends StatefulWidget {
  const CahngeInformationScreen({super.key});

  @override
  State<CahngeInformationScreen> createState() =>
      _CahngeInformationScreenState();
}

class _CahngeInformationScreenState extends State<CahngeInformationScreen> {
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayDateController = TextEditingController();
  DateTime initialDate = DateTime(2002, 5, 17);

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    birthdayDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateProfileCubit(
        profileRepo: ProfileRepoImp(api: Get.find<ApiService>()),
      )..getProfile(),
      child: Scaffold(
        body: Stack(
          children: [
            const Positioned.fill(child: BackgroundImage()),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 60.h),
              child: BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
                listener: (context, state) {
                  if (state is FetchProfileSuccess) {
                    firstNameController.text = state.customer.firstName ?? "";
                    lastNameController.text = state.customer.lastName ?? "";
                    if (state.customer.birthdate != null) {
                      try {
                        DateTime date = DateTime.parse(
                          state.customer.birthdate!,
                        );
                        setState(() {
                          initialDate = date;
                        });
                        birthdayDateController.text = DateFormat(
                          'dd/MM/yyyy',
                        ).format(date);
                      } catch (e) {
                        // Ignore
                      }
                    }
                  } else if (state is UpdateProfileSuccess) {
                    showCustomGetSnack(isGreen: true, text: state.message);
                    Navigator.of(context).pop();
                  } else if (state is UpdateProfileFailure) {
                    showCustomGetSnack(
                      isGreen: false,
                      text: state.errorMessage,
                    );
                  } else if (state is FetchProfileFailure) {
                    showCustomGetSnack(
                      isGreen: false,
                      text: state.errorMessage,
                    );
                  }
                },
                builder: (context, state) {
                  bool isLoading = state is FetchProfileLoading;

                  return ChangeInfoBody(
                    isLoading: isLoading,
                    firstNameController: firstNameController,
                    lastNameController: lastNameController,
                    birthdayDateController: birthdayDateController,
                    initialDate: initialDate,
                    state: state,
                    updateButton: builderForUpdateButton(context, state),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget builderForUpdateButton(
    BuildContext context,
    UpdateProfileState state,
  ) {
    if (state is UpdateProfileLoading) {
      return Helper.loadingWidget();
    }
    return SignUpCustomButton(
      buttonText: LocaleKeys.change_information_screen_save.tr(),
      onPressed: state is FetchProfileLoading
          ? () {}
          : () {
              // Parse date back to ISO8601
              try {
                String dateStr = birthdayDateController.text;
                // DatePicker uses M/d/yyyy
                DateTime date = DateFormat('dd/MM/yyyy').parse(dateStr);
                String isoDate = "${date.toIso8601String()}Z";

                context.read<UpdateProfileCubit>().updateProfile(
                  firstName: firstNameController.text,
                  lastName: lastNameController.text,
                  birthdate: isoDate,
                );
              } catch (e) {
                showCustomGetSnack(
                  isGreen: false,
                  text: LocaleKeys.change_information_screen_invalid_date_format
                      .tr(),
                );
              }
            },
    );
  }
}
