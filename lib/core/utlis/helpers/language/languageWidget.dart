import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:negmt_heliopolis/core/constants/colors.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language/cubit/locale_cubit.dart';
import 'package:negmt_heliopolis/core/utlis/helpers/language/language_cache_helper.dart';

class Languagewidget extends StatelessWidget {
  const Languagewidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return FutureBuilder<String>(
            future: LanguageCacheHelper().getCachedLanguageCode(),
            builder: (context, snapshot) {
              bool isArabic = snapshot.data == 'ar';

              return Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () {
                      context.read<LocaleCubit>().changeLanguage('ar');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color:
                            isArabic ? MyColors.mainColor : Colors.transparent,
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(20),
                            left: Radius.circular(20)),
                      ),
                      child: Text(
                        'عربي',
                        style: TextStyle(
                          color: isArabic ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<LocaleCubit>().changeLanguage('en');
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color:
                            isArabic ? Colors.transparent : MyColors.mainColor,
                        borderRadius: const BorderRadius.horizontal(
                            right: Radius.circular(20),
                            left: Radius.circular(20)),
                      ),
                      child: Text(
                        'En',
                        style: TextStyle(
                          color: !isArabic ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            });
      },
    );
  }
}
