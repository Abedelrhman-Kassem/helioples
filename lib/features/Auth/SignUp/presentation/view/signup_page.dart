
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:negmt_heliopolis/core/constants/colors.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language/languageWidget.dart';
import 'package:negmt_heliopolis/core/widgets/CustomButton.dart';
import 'package:negmt_heliopolis/core/widgets/helioplis_logo.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/egypt_code_widget.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/phone_number_input_widget.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: Text("Login".tr(context)),
          actions: const [Languagewidget(), Gap(20)],
        ),
        body: Container(
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    "assets/screens_background/grocery_itemsback_ground.png"),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const HelioplisLogo(),
                  const Gap(7),
                  Text(
                    "Enter Phone Number".tr(context),
                    style: const TextStyle(
                        fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Gap(10),
                  const PhoneNumberInputWidget(),
                  const Gap(20),
                  Center(
                      child: Text(
                    'You will receive a verification code'.tr(context),
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  )),
                  const Gap(20),
                  CustomButton(
                    text: "Continue".tr(context),
                    onTap: () {},
                    backgroundColor: MyColors.mainColor,
                    textColor: MyColors.mainWhiteColor,
                    verticalPadding: 15,
                    borderRadius: 20,
                  ),
                  const Gap(10),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(
                            text: "You don't Have account?".tr(context),
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Color.fromARGB(255, 0, 0, 0),
                            ),
                          ),
                          TextSpan(
                            text: "Create an account.".tr(context),
                            style: const TextStyle(
                              fontSize: 17.0,
                              color: Colors.orange,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (ctx) => const SignupPage(),
                                  ),
                                );
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


// import 'package:flutter_bloc/flutter_bloc.dart';

// class SettingsPage extends StatelessWidget {
//   const SettingsPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("settings".tr(context)),
//       ),
//       body: Center(
//         child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: BlocConsumer<LocaleCubit, ChangeLocaleState>(
//               listener: (context, state) {
//                 Navigator.of(context).pop();
//               },
//               builder: (context, state) {
//                 return DropdownButton<String>(
//                   value: state.locale.languageCode,
//                   icon: const Icon(Icons.keyboard_arrow_down),
//                   items: ['ar', 'en'].map((String items) {
//                     return DropdownMenuItem<String>(
//                       value: items,
//                       child: Text(items),
//                     );
//                   }).toList(),
//                   onChanged: (String? newValue) {
//                     if (newValue != null) {
//                       context.read<LocaleCubit>().changeLanguage(newValue);
//                     }
//                   },
//                 );
//               },
//             )),
//       ),
//     );
//   }
// }
