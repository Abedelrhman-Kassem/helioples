import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';

class TextFormDate extends StatefulWidget {
  final DateTime initialDate;

  final void Function(DateTime) onDateTimeChanged;
  const TextFormDate({
    super.key,
    required this.initialDate,
    required this.onDateTimeChanged,
  });

  @override
  State<TextFormDate> createState() => _TextFormDateState();
}

class _TextFormDateState extends State<TextFormDate> {
  late final TextEditingController _controller;
  late DateTime _selectedDate;

  String _format(DateTime dt) =>
      '${dt.day.toString().padLeft(2, '0')}/${dt.month.toString().padLeft(2, '0')}/${dt.year}';

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.initialDate;
    _controller = TextEditingController(text: _format(_selectedDate));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onNewDate(DateTime newDate) {
    setState(() {
      _selectedDate = newDate;
      _controller.text = _format(newDate);
    });

    widget.onDateTimeChanged(newDate);
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromRGBO(246, 246, 246, 1),
        iconColor: MyColors.mainColor,
        focusColor: MyColors.mainColor,
        suffixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            'assets/svg_icons/calendar.svg',
            width: 30.w,
            height: 30.h,
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
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      ),
      style: Styles.styles17w500NormalBlack,
      readOnly: true,
      onTap: () {
        showCupertinoModalPopup(
          context: context,
          builder: (BuildContext ctx) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.r),
                topRight: Radius.circular(30.r),
              ),
            ),
            height: MediaQuery.of(context).size.height * 0.3,
            width: MediaQuery.of(context).size.width,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                color: Colors.white,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: CupertinoDatePicker(
                    backgroundColor: Colors.white,
                    onDateTimeChanged: (DateTime newDate) {
                      _onNewDate(newDate);
                    },
                    use24hFormat: true,
                    mode: CupertinoDatePickerMode.date,
                    initialDateTime: _selectedDate,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
