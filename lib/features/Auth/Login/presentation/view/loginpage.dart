import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:gap/gap.dart';
import 'package:negmt_heliopolis/core/constants/constants.dart';
import 'package:negmt_heliopolis/core/utlis/network/api_service.dart';
import 'package:negmt_heliopolis/core/widgets/languageWidget.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/widgets/CustomButton.dart';
import 'package:negmt_heliopolis/core/widgets/helioplis_logo.dart';
import 'package:negmt_heliopolis/core/widgets/loading_button.dart';
import 'package:negmt_heliopolis/features/Auth/Login/data/repo/log_in_repo_imp.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/phone_number_input_widget.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/sign%20in%20cubit/sign_in_cubit.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view_model/sign%20in%20cubit/sign_in_states.dart';
import 'package:negmt_heliopolis/features/Auth/SignUp/presentation/view/widgets/sign_up_custom_button.dart';

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
                BlocProvider(
                  create: (context) =>
                      SignInCubit((LogInRepoImp(apiService: ApiService()))),
                  child: BlocConsumer<SignInCubit,SignInState>(builder: (context ,state )
                  {
                    var cubit = BlocProvider.of<SignInCubit>(context);
                    if(state is SignInLoading )
                    {
                       return const LoadingButton(
                            height: 60,
                            radius: 10,
                          );
                    } else 
                    {
                       return Center(
                            child: SignUpCustomButton(
                              buttonText: "Continue",
                              onPressed: () {
                                cubit.signIn("1145243378", "12345678");
                                //  Navigator.of(context).pushNamed(
                                //   verficationScreen,
                                //   arguments: {
                                //     'phoneNumber': "+201145243378",
                                //   },
                                // );


                              },
                            ),
                          );

                    }
                  }, listener: (context ,state)
                  {
                     if (state is SignInFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(state.errorMessage)));
                        } else if (state is SignInSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Please Enter Validaition code')));
                          Navigator.of(context).pushNamed(
                            verficationScreen,
                            arguments: {
                              'phoneNumber': "1145243378",
                            },
                          );
                        }

                  }
                  ),
                ),
                // CustomButton(
                //   text: "Continue",
                //   onTap: () {
                //     // Navigator.pushNamed(context, verficationScreen);
                //   },
                //   backgroundColor: MyColors.mainColor,
                //   textColor: MyColors.mainScaffoldWhiteColor,
                //   verticalPadding: 15,
                //   borderRadius: 20,
                // ),
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
