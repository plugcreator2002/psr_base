import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import 'package:psr_base/ui_related/datepicker/date_model.dart';

class DatePickerUi extends StatelessWidget {
  final String? initialDate;
  final bool isJalali;
  const DatePickerUi({
    Key? key,
    this.initialDate,
    this.isJalali = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LinearDatePicker(
      initialDate: (initialDate ?? "").replaceAll("-", "/"),
      showMonthName: true,
      startDate: "1350/01/01",
      endDate: "1450/01/01",
      isJalali: isJalali,
      dateChangeListener: (selectedDate) {
        Navigator.pop(context, selectedDate);
      },
    );
  }
}
