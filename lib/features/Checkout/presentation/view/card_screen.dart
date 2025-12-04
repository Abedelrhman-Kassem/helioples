import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';
import 'package:negmt_heliopolis/core/widgets/button_widget.dart';
import 'package:negmt_heliopolis/core/widgets/radio_animated_widget.dart';
import 'package:negmt_heliopolis/core/widgets/return_arrow.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view/widgets/card_text_field.dart';
import 'package:negmt_heliopolis/features/Checkout/presentation/view_model/card_cubit/card_cubit.dart';
import 'package:negmt_heliopolis/generated/locale_keys.g.dart';

class StarEditingController extends TextEditingController {
  @override
  String get text {
    return '*' * super.text.length;
  }
}

class CardScreen extends StatefulWidget {
  const CardScreen({super.key});

  @override
  State<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  var formKey = GlobalKey<FormState>();
  late TextEditingController cvvController;

  @override
  void initState() {
    cvvController = StarEditingController();
    super.initState();
  }

  @override
  void dispose() {
    cvvController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CardCubit(),
      child: BlocConsumer<CardCubit, CardState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cardCubit = BlocProvider.of<CardCubit>(context);

          return Scaffold(
            appBar: AppBar(
              leading: returnArrow(
                context: context,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              title: Text(
                LocaleKeys.card_screen_add_card.tr(),
                style: Styles.styles16w700interFamily,
              ),
            ),
            body: Padding(
              padding: EdgeInsets.all(20.0.r),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/screens_background/Large 1.png',
                        width: double.infinity,
                      ),
                      SizedBox(height: 40.h),
                      cardTextField(
                        controller: cardCubit.cardNumberController,
                        text: LocaleKeys.card_screen_card_number.tr(),
                        type: TextInputType.number,
                        maxLength: 19,
                        onChanged: (value) {
                          if (value.length > cardCubit.oldCardNumLength) {
                            if (value.replaceAll(' ', '').length % 4 == 0 &&
                                value.length != 19) {
                              cardCubit.cardNumberController.text += ' ';
                            }
                          }
                          cardCubit.oldCardNumLength = value.length;
                        },
                      ),
                      SizedBox(height: 20.h),
                      cardTextField(
                        controller: cardCubit.cardNameController,
                        text: LocaleKeys.card_screen_name_on_card.tr(),
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(
                            child: cardTextField(
                              controller: cardCubit.cardExpDateController,
                              text: LocaleKeys.card_screen_expiration_date.tr(),
                            ),
                          ),
                          SizedBox(width: 20.h),
                          Expanded(
                            child: cardTextField(
                              controller: cvvController,
                              text: LocaleKeys.card_screen_cvv.tr(),
                              maxLength: 3,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h),
                      const SaveCardContainer(),
                      SizedBox(height: 50.h),
                      buttonWidget(
                        color: MyColors.mainColor,
                        borderRadius: 37.r,
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: Text(
                          LocaleKeys.card_screen_add_card.tr(),
                          style: Styles.styles17w500NormalWhite,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class SaveCardContainer extends StatefulWidget {
  const SaveCardContainer({super.key});

  @override
  State<SaveCardContainer> createState() => _SaveCardContainerState();
}

class _SaveCardContainerState extends State<SaveCardContainer> {
  bool saveCard = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          saveCard = !saveCard;
        });
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          radioAnimatedWidget(saveCard),
          SizedBox(width: 10.w),
          Text(
            LocaleKeys.card_screen_save_card_to_use_later.tr(),
            style: Styles.styles13w400interFamily,
          ),
        ],
      ),
    );
  }
}
