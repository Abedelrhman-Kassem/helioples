import 'package:flutter/material.dart';

import 'package:gap/gap.dart';
import 'package:negmt_heliopolis/core/models/language/app_localizations.dart';
import 'package:negmt_heliopolis/core/widgets/helioplis_logo.dart';
import 'package:negmt_heliopolis/features/Auth/Login/presentation/view/widgets/egypt_code_widget.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          title: const Text("Login"),
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
                    style: Theme.of(context).textTheme.bodyMedium,
                    // style: const TextStyle(
                    //     fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                  const Gap(10),
                  Row(
                    children: [
                      const EgyptionCodeWidget(),
                      const Gap(13),
                      Expanded(
                        child: TextField(
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            fillColor: const Color.fromRGBO(239, 239, 239, 1),
                            filled: true,
                            border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.black87, width: 10),
                                borderRadius: BorderRadius.circular(30)),
                            labelText: 'Phone Number',
                          ),
                        ),
                      ),
                    ],
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
