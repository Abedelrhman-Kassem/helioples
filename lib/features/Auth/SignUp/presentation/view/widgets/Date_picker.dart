import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:negmt_heliopolis/core/utlis/theming/colors.dart';
import 'package:negmt_heliopolis/core/utlis/theming/styles.dart';


class DatePicker extends StatefulWidget {
  final String labelText;
  //final void Function(DateTime) onDateSelected;
  final String? Function(String?)? validator;
  final DateTime? initialDate ; 

  const DatePicker({
    super.key,
    required this.labelText,
    //required this.onDateSelected,
    this.validator,
    this.initialDate,
  });

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  final TextEditingController _dateController = TextEditingController();
  late String selectedDate;

  @override
  void initState() {
    super.initState();
     selectedDate = widget.initialDate != null ? DateFormat('M/d/yyyy').format(widget.initialDate!) : '';
     _dateController.text = selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _selectDate();
      },
      child: AbsorbPointer(
        absorbing: true,
        child: SizedBox(
          child: TextFormField(
            
            controller: _dateController,
            validator: widget.validator,
            decoration: InputDecoration(
              filled: true,
              fillColor: const Color.fromRGBO(246, 246, 246, 1), 
              iconColor: MyColors.mainColor,
              focusColor: MyColors.mainColor,
              hintText: widget.labelText,
              suffixIcon: Padding(
                padding: const EdgeInsets.all(12.0), 
                child: SvgPicture.asset(
                  'assets/svg_icons/calendar.svg', 

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
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime initialDate = widget.initialDate ?? DateTime.now(); 
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color.fromRGBO(0, 126, 143, 1),
            onPrimary: Colors.white,
            surface: Colors.white,
          ),
        ),
        child: child ?? Container(),
      ),
    );
    if (picked != null) {
      setState(() {
        _dateController.text = DateFormat('M/d/yyyy').format(picked);
        //widget.onDateSelected(picked);
      });
    }
  }
}
