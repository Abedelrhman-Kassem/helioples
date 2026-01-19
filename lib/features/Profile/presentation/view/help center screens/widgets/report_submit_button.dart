import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/widgets/custom_getx_snak_bar.dart';
import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';
import 'package:negmt_heliopolis/features/Profile/data/model/report.dart';
import 'package:negmt_heliopolis/features/Profile/data/repo/profile%20repo/profile_repo_imp.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/report%20cubit/report_cubit.dart';
import 'package:negmt_heliopolis/features/Profile/presentation/view_model/report%20cubit/report_states.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class ReportSubmitButton extends StatelessWidget {
  final TextEditingController messageController;
  final String? selectedImagePath;

  const ReportSubmitButton({
    super.key,
    required this.messageController,
    this.selectedImagePath,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReportCubit(ProfileRepoImp(api: ApiService())),
      child: BlocConsumer<ReportCubit, SubmitReportState>(
        builder: (context, state) {
          var cubit = BlocProvider.of<ReportCubit>(context);
          if (state is SubmitReportLoading) {
            return const LoadingButton(height: 60, radius: 10);
          } else {
            return Center(
              child: SignUpCustomButton(
                buttonText: LocaleKeys.report_screen_submit_message.tr(),
                onPressed: () {
                  Report report = Report(
                    message: messageController.text,
                    imageUrl: selectedImagePath,
                  );
                  cubit.submitReport(report);
                },
              ),
            );
          }
        },
        listener: (context, state) {
          if (state is SubmitReportFailure) {
            showCustomGetSnack(isGreen: false, text: state.errorMessage);
          } else if (state is SubmitReportSuccess) {
            showCustomGetSnack(isGreen: true, text: state.status);
            Navigator.of(context).pushNamed(helpCenterScreen);
          }
        },
      ),
    );
  }
}
