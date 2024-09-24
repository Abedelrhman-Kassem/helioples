import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/widgets/languageWidget.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/CustomButton.dart';
import 'package:negmt_heliopolis/core/widgets/helioplis_logo.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/phone_number_input_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            "assets/screens_background/grocery_itemsback_ground.png",
          ),
          fit: BoxFit.cover,
        ),
        color: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text("Login"),
          centerTitle: false,
          actions: const [
            // TO DO
            // Languagewidget(),
            Gap(20),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HelioplisLogo(),
                const Gap(7),
                Text(
                  "Enter Phone Number",
                  style: Theme.of(context).textTheme.bodyMedium,
                  // style: const TextStyle(
                  //     fontSize: 28, fontWeight: FontWeight.bold),
                ),
                const Gap(10),
                const PhoneNumberInputWidget(),
                const Gap(20),
                const Center(
                  child: Text(
                    'You will receive a verification code',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                const Gap(20),
                CustomButton(
                  text: "Continue",
                  onTap: () {
                    // Navigator.pushNamed(context, verficationScreen);
                  },
                  backgroundColor: MyColors.mainColor,
                  textColor: MyColors.mainScaffoldWhiteColor,
                  verticalPadding: 15,
                  borderRadius: 20,
                ),
                const Gap(10),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: "You don't Have account?",
                          style: TextStyle(
                            fontSize: 17.0,
                            color: Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        TextSpan(
                          text: "Create an account.",
                          style: const TextStyle(
                            fontSize: 17.0,
                            color: Colors.orange,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(context, signUpScreen);
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
//         title: Text("settings"),
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
