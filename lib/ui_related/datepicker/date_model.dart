// ignore_for_file: deprecated_member_use, invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member

import "package:flutter/material.dart";

import "dart:math" as math;

import "package:flutter/rendering.dart";
import "package:flutter/services.dart";
import 'package:psr_base/common/font_models.dart';
import 'package:shamsi_date/shamsi_date.dart';

class LinearDatePicker extends StatefulWidget {
  final bool showDay;
  final Function(String date) dateChangeListener;

  final String startDate;
  final String endDate;
  final String initialDate;

  final TextStyle? labelStyle;
  final TextStyle? selectedRowStyle;
  final TextStyle? unselectedRowStyle;

  final String yearText;
  final String monthText;
  final String dayText;

  final bool showLabels;
  final double columnWidth;
  final bool isJalali;
  final bool showMonthName;

  const LinearDatePicker({
    Key? key,
    this.startDate = "",
    this.endDate = "",
    this.initialDate = "",
    required this.dateChangeListener,
    this.showDay = true,
    this.labelStyle,
    this.selectedRowStyle,
    this.unselectedRowStyle,
    this.yearText = "سال",
    this.monthText = "ماه",
    this.dayText = "روز",
    this.showLabels = true,
    this.columnWidth = 55.0,
    this.isJalali = false,
    this.showMonthName = false,
  }) : super(key: key);

  @override
  LinearDatePickerState createState() => LinearDatePickerState();
}

class LinearDatePickerState extends State<LinearDatePicker> {
  int? _selectedYear;
  int? _selectedMonth;
  late int _selectedDay;

  int? minYear;
  int? maxYear;

  int minMonth = 01;
  int maxMonth = 12;

  int minDay = 01;
  int maxDay = 31;

  @override
  initState() {
    super.initState();
    if (widget.isJalali) {
      minYear = Jalali.now().year - 100;
      maxYear = Jalali.now().year;
    } else {
      minYear = Gregorian.now().year - 100;
      maxYear = Gregorian.now().year;
    }
    if (widget.initialDate.isNotEmpty) {
      List<String> initList = widget.initialDate.split("/");
      _selectedYear = int.parse(initList[0]);
      _selectedMonth = int.parse(initList[1]);
      if (widget.showDay) {
        _selectedDay = int.parse(initList[2]);
      } else {
        _selectedDay = widget.isJalali ? Jalali.now().day : Jalali.now().day;
      }
    } else {
      if (widget.isJalali) {
        _selectedYear = Jalali.now().year;
        _selectedMonth = Jalali.now().month;
        _selectedDay = Jalali.now().day;
      } else {
        _selectedYear = Gregorian.now().year;
        _selectedMonth = Gregorian.now().month;
        _selectedDay = Gregorian.now().day;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    maxDay = _getMonthLength(_selectedYear, _selectedMonth);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: [
        const SizedBox(height: 5),
        Visibility(
          visible: widget.showLabels,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Visibility(
                visible: widget.showDay,
                child: SizedBox(
                  width: 125,
                  child: Text(
                    widget.dayText,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xFF4C4D52),
                      fontFamily: FontModels.yekan,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 125,
                child: Text(
                  widget.monthText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF4C4D52),
                    fontFamily: FontModels.yekan,
                  ),
                ),
              ),
              SizedBox(
                width: 125,
                child: Text(
                  widget.yearText,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xFF4C4D52),
                    fontFamily: FontModels.yekan,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Visibility(
              visible: widget.showDay,
              child: NumberPicker.integer(
                listViewWidth: widget.columnWidth,
                initialValue: _selectedDay,
                minValue: _getMinimumDay(),
                maxValue: _getMaximumDay(),
                selectedRowStyle: widget.selectedRowStyle,
                unselectedRowStyle: widget.unselectedRowStyle,
                onChanged: (value) {
                  setState(() {
                    _selectedDay = value as int;
                    if (widget.showDay) {
                      widget.dateChangeListener(
                        "$_selectedYear/$_selectedMonth/$_selectedDay",
                      );
                    } else {
                      widget.dateChangeListener(
                        "$_selectedYear/$_selectedMonth",
                      );
                    }
                  });
                },
              ),
            ),
            NumberPicker.integer(
              listViewWidth: widget.columnWidth,
              initialValue: _selectedMonth!,
              minValue: _getMinimumMonth(),
              maxValue: _getMaximumMonth(),
              selectedRowStyle: widget.selectedRowStyle,
              unselectedRowStyle: widget.unselectedRowStyle,
              isShowMonthName: widget.showMonthName,
              isJalali: widget.isJalali,
              onChanged: (value) {
                setState(() {
                  _selectedMonth = value as int?;
                  if (widget.showDay) {
                    widget.dateChangeListener(
                      "$_selectedYear/$_selectedMonth/$_selectedDay",
                    );
                  } else {
                    widget.dateChangeListener(
                      "$_selectedYear/$_selectedMonth",
                    );
                  }
                });
              },
            ),
            NumberPicker.integer(
              listViewWidth: widget.columnWidth,
              initialValue: _selectedYear!,
              minValue: _getMinimumYear()!,
              maxValue: _getMaximumYear(),
              selectedRowStyle: widget.selectedRowStyle,
              unselectedRowStyle: widget.unselectedRowStyle,
              onChanged: (value) {
                setState(() {
                  _selectedYear = value as int?;
                  if (widget.showDay) {
                    widget.dateChangeListener(
                      "$_selectedYear/$_selectedMonth/$_selectedDay",
                    );
                  } else {
                    widget.dateChangeListener(
                      "$_selectedYear/$_selectedMonth",
                    );
                  }
                });
              },
            ),
          ],
        ),
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop(
                  "$_selectedYear-$_selectedMonth-$_selectedDay",
                );
              },
              child: const Text(
                "ثبت",
                style: TextStyle(
                  fontSize: 15,
                  // fontWeight: FontWeight.w500,
                  color: Color(0xFF4C4D52),
                  fontFamily: FontModels.yekan,
                ),
              ),
            ),
            FlatButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                "لغو",
                style: TextStyle(
                  fontSize: 15,
                  color: Color(0xFF4C4D52),
                  // fontWeight: FontWeight.w500,
                  fontFamily: FontModels.yekan,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 1),
      ],
    );
  }

  _getMonthLength(int? selectedYear, int? selectedMonth) {
    if (widget.isJalali) {
      if (selectedMonth! <= 6) {
        return 31;
      }
      if (selectedMonth > 6 && selectedMonth < 12) {
        return 30;
      }
      if (Jalali(selectedYear!).isLeapYear()) {
        return 30;
      } else {
        return 29;
      }
    } else {
      DateTime firstOfNextMonth;
      if (selectedMonth == 12) {
        firstOfNextMonth = DateTime(selectedYear! + 1, 1, 1, 12);
      } else {
        firstOfNextMonth = DateTime(selectedYear!, selectedMonth! + 1, 1, 12);
      }
      int numberOfDaysInMonth =
          firstOfNextMonth.subtract(const Duration(days: 1)).day;
      return numberOfDaysInMonth;
    }
  }

  int _getMinimumMonth() {
    if (widget.startDate.isNotEmpty) {
      final startList = widget.startDate.split("/");
      int startMonth = int.parse(startList[1]);

      if (_selectedYear == _getMinimumYear()) {
        return startMonth;
      }
    }

    return minMonth;
  }

  int _getMaximumMonth() {
    if (widget.endDate.isNotEmpty) {
      final endList = widget.endDate.split("/");
      int endMonth = int.parse(endList[1]);
      if (_selectedYear == _getMaximumYear()) {
        return endMonth;
      }
    }
    return maxMonth;
  }

  int? _getMinimumYear() {
    if (widget.startDate.isNotEmpty) {
      final startList = widget.startDate.split("/");
      return int.parse(startList[0]);
    }
    return minYear;
  }

  _getMaximumYear() {
    if (widget.endDate.isNotEmpty) {
      final endList = widget.endDate.split("/");
      return int.parse(endList[0]);
    }
    return maxYear;
  }

  int _getMinimumDay() {
    if (widget.startDate.isNotEmpty && widget.showDay) {
      final startList = widget.startDate.split("/");
      int startDay = int.parse(startList[2]);

      if (_selectedYear == _getMinimumYear() &&
          _selectedMonth == _getMinimumMonth()) {
        return startDay;
      }
    }

    return minDay;
  }

  int _getMaximumDay() {
    if (widget.endDate.isNotEmpty && widget.showDay) {
      var endList = widget.endDate.split("/");
      int endDay = int.parse(endList[2]);
      if (_selectedYear == _getMaximumYear() &&
          _selectedMonth == _getMinimumMonth()) {
        return endDay;
      }
    }
    return _getMonthLength(_selectedYear, _selectedMonth);
  }
}

extension StringExt on int {
  String getMonthName(bool isJalali) {
    if (isJalali) {
      return this.jalaliMonthName;
    } else {
      return this.gregorianMonthName;
    }
  }

  String get jalaliMonthName {
    switch (this) {
      case 1:
        return "فروردین";
      case 2:
        return "اردیبهشت";
      case 3:
        return "خرداد";
      case 4:
        return "تیر";
      case 5:
        return "مرداد";
      case 6:
        return "شهریور";
      case 7:
        return "مهر";
      case 8:
        return "آبان";
      case 9:
        return "آذر";
      case 10:
        return "دی";
      case 11:
        return "بهمن";
      case 12:
        return "اسفند";
      default:
        return "$this";
    }
  }

  String get gregorianMonthName {
    switch (this) {
      case 1:
        return "Jan";
      case 2:
        return "Feb";
      case 3:
        return "March";
      case 4:
        return "April";
      case 5:
        return "May";
      case 6:
        return "June";
      case 7:
        return "July";
      case 8:
        return "August";
      case 9:
        return "Sep";
      case 10:
        return "Oct";
      case 11:
        return "Nov";
      case 12:
        return "Dec";
      default:
        return "$this";
    }
  }
}

///Define a text mapper to transform the text displayed by the picker
typedef String TextMapper(String numberText);

///NumberPicker is a widget designed to pick a number between #minValue and #maxValue
class NumberPicker extends StatelessWidget {
  ///height of every list element for normal number picker
  ///width of every list element for horizontal number picker
  static const double kDefaultItemExtent = 50.0;

  ///width of list view for normal number picker
  ///height of list view for horizontal number picker
  static const double kDefaultListViewCrossAxisSize = 100.0;

  ///constructor for integer number picker
  NumberPicker.integer({
    Key? key,
    required int initialValue,
    required this.minValue,
    required this.maxValue,
    required this.onChanged,
    this.enabled = true,
    this.textMapper,
    this.itemExtent = kDefaultItemExtent,
    this.listViewWidth = kDefaultListViewCrossAxisSize,
    this.step = 1,
    this.scrollDirection = Axis.vertical,
    this.zeroPad = false,
    this.highlightSelectedValue = true,
    this.decoration,
    this.haptics = false,
    this.selectedRowStyle,
    this.unselectedRowStyle,
    this.isShowMonthName = false,
    this.isJalali = false,
  })  : assert(maxValue >= minValue),
        // assert(initialValue >= minValue && initialValue <= maxValue),
        assert(step > 0),
        selectedIntValue = (initialValue < minValue)
            ? minValue
            : ((initialValue > maxValue) ? maxValue : initialValue),
        selectedDecimalValue = -1,
        decimalPlaces = 0,
        intScrollController = ScrollController(
          initialScrollOffset: (initialValue - minValue) ~/ step * itemExtent,
        ),
        decimalScrollController = null,
        listViewHeight = 3 * itemExtent,
        integerItemCount = (maxValue - minValue) ~/ step + 1,
        super(key: key) {
    onChanged(selectedIntValue);
  }

  ///called when selected value changes
  final ValueChanged<num> onChanged;

  ///min value user can pick
  final int minValue;

  ///max value user can pick
  final int maxValue;

  ///build the text of each item on the picker
  final bool enabled;

  ///build the text of each item on the picker
  final TextMapper? textMapper;

  ///indicates how many decimal places to show
  /// e.g. 0=>[1,2,3...], 1=>[1.0, 1.1, 1.2...]  2=>[1.00, 1.01, 1.02...]
  final int decimalPlaces;

  ///height of every list element in pixels
  final double itemExtent;

  ///height of list view in pixels
  final double listViewHeight;

  ///width of list view in pixels
  final double? listViewWidth;

  ///ScrollController used for integer list
  final ScrollController intScrollController;

  ///ScrollController used for decimal list
  final ScrollController? decimalScrollController;

  ///Currently selected integer value
  final int selectedIntValue;

  ///Currently selected decimal value
  final int selectedDecimalValue;

  ///If currently selected value should be highlighted
  final bool highlightSelectedValue;

  ///Decoration to apply to central box where the selected value is placed
  final Decoration? decoration;

  ///Step between elements. Only for integer datePicker
  ///Examples:
  /// if step is 100 the following elements may be 100, 200, 300...
  /// if min=0, max=6, step=3, then items will be 0, 3 and 6
  /// if min=0, max=5, step=3, then items will be 0 and 3.
  final int step;

  /// Direction of scrolling
  final Axis scrollDirection;

  ///Pads displayed integer values up to the length of maxValue
  final bool zeroPad;

  ///Amount of items
  final int integerItemCount;

  ///Whether to trigger haptic pulses or not
  final bool haptics;

  ///Set selected numbers font color
  final TextStyle? selectedRowStyle;

  ///Set unselected numbers font color
  final TextStyle? unselectedRowStyle;

  //Show month name instead of month int place in the year
  final bool? isShowMonthName;

  //isJalali for get the month right name
  final bool? isJalali;

  /// Used to animate integer number picker to new selected value
  void animateInt(int valueToSelect) {
    int diff = valueToSelect - minValue;
    int index = diff ~/ step;
    animateIntToIndex(index);
  }

  /// Used to animate integer number picker to new selected index
  void animateIntToIndex(int index) {
    _animate(intScrollController, index * itemExtent);
  }

  /// Used to animate decimal part of double value to new selected value
  void animateDecimal(int decimalValue) {
    _animate(decimalScrollController!, decimalValue * itemExtent);
  }

  /// Used to animate decimal number picker to selected value
  void animateDecimalAndInteger(double valueToSelect) {
    animateInt(valueToSelect.floor());
    animateDecimal(((valueToSelect - valueToSelect.floorToDouble()) *
            math.pow(10, decimalPlaces))
        .round());
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);

    return _integerListView(context, themeData);
  }

  Widget _integerListView(BuildContext context, ThemeData themeData) {
    var listItemCount = integerItemCount + 2;

    return Listener(
      onPointerUp: (event) {
        if (intScrollController.position.activity is HoldScrollActivity) {
          animateInt(selectedIntValue);
        }
      },
      child: NotificationListener(
        onNotification: _onIntegerNotification,
        child: SizedBox(
          height: listViewHeight,
          width: 125,
          child: Stack(
            children: <Widget>[
              ListView.builder(
                scrollDirection: scrollDirection,
                controller: intScrollController,
                itemExtent: itemExtent,
                itemCount: listItemCount,
                cacheExtent: _calculateCacheExtent(listItemCount),
                physics: enabled
                    ? const ClampingScrollPhysics()
                    : const NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  final int value = _intValueFromIndex(index);

                  bool isExtra = index == 0 || index == listItemCount - 1;

                  bool choice = value == selectedIntValue;

                  if (isExtra) return const SizedBox();

                  return Center(
                    child: Text(
                      getDisplayedValue(value),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: choice ? 16 : 13,
                        fontWeight: FontWeight.w500,
                        fontFamily: FontModels.yekan,
                        color: [
                          const Color(0xFF4A6572),
                          const Color(0xFF4C4D52),
                        ][choice ? 0 : 1],
                      ),
                    ),
                  );
                },
              ),
              _NumberPickerSelectedItemDecoration(
                axis: scrollDirection,
                itemExtent: itemExtent,
                decoration: decoration,
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDisplayedValue(int value) {
    if (isShowMonthName!) {
      return value.getMonthName(isJalali!);
    } else {
      final String text;
      if (zeroPad) {
        text = value.toString().padLeft(maxValue.toString().length, "0");
      } else {
        text = value.toString();
      }
      return textMapper != null ? textMapper!(text) : text;
    }
  }

  int _intValueFromIndex(int index) {
    index--;
    index %= integerItemCount;
    return minValue + index * step;
  }

  bool _onIntegerNotification(Notification notification) {
    if (notification is ScrollNotification) {
      int intIndexOfMiddleElement =
          (notification.metrics.pixels / itemExtent).round();
      intIndexOfMiddleElement =
          intIndexOfMiddleElement.clamp(0, integerItemCount - 1);
      int intValueInTheMiddle = _intValueFromIndex(intIndexOfMiddleElement + 1);
      intValueInTheMiddle = _normalizeIntegerMiddleValue(intValueInTheMiddle);

      if (_userStoppedScrolling(notification, intScrollController)) {
        //center selected value
        animateIntToIndex(intIndexOfMiddleElement);
      }

      //update selection
      if (intValueInTheMiddle != selectedIntValue) {
        num newValue;
        if (decimalPlaces == 0) {
          //return integer value
          newValue = (intValueInTheMiddle);
        } else {
          if (intValueInTheMiddle == maxValue) {
            //if new value is maxValue, then return that value and ignore decimal
            newValue = (intValueInTheMiddle.toDouble());
            animateDecimal(0);
          } else {
            //return integer+decimal
            double decimalPart = _toDecimal(selectedDecimalValue);
            newValue = ((intValueInTheMiddle + decimalPart).toDouble());
          }
        }
        if (haptics) {
          HapticFeedback.selectionClick();
        }
        onChanged(newValue);
      }
    }
    return true;
  }

  ///There was a bug, when if there was small integer range, e.g. from 1 to 5,
  ///When user scrolled to the top, whole listview got displayed.
  ///To prevent this we are calculating cacheExtent by our own so it gets smaller if number of items is smaller
  double _calculateCacheExtent(int itemCount) {
    double cacheExtent = 250.0; //default cache extent
    if ((itemCount - 2) * kDefaultItemExtent <= cacheExtent) {
      cacheExtent = ((itemCount - 3) * kDefaultItemExtent);
    }
    return cacheExtent;
  }

  ///When overscroll occurs on iOS,
  ///we can end up with value not in the range between [minValue] and [maxValue]
  ///To avoid going out of range, we change values out of range to border values.
  int _normalizeMiddleValue(int valueInTheMiddle, int min, int max) {
    return math.max(math.min(valueInTheMiddle, max), min);
  }

  int _normalizeIntegerMiddleValue(int integerValueInTheMiddle) {
    //make sure that max is a multiple of step
    int max = (maxValue ~/ step) * step;
    return _normalizeMiddleValue(integerValueInTheMiddle, minValue, max);
  }

  ///indicates if user has stopped scrolling so we can center value in the middle
  bool _userStoppedScrolling(
    Notification notification,
    ScrollController scrollController,
  ) {
    return notification is UserScrollNotification &&
        notification.direction == ScrollDirection.idle &&
        scrollController.position.activity is! HoldScrollActivity;
  }

  ///converts integer indicator of decimal value to double
  ///e.g. decimalPlaces = 1, value = 4  >>> result = 0.4
  ///     decimalPlaces = 2, value = 12 >>> result = 0.12
  double _toDecimal(int decimalValueAsInteger) {
    return double.parse((decimalValueAsInteger * math.pow(10, -decimalPlaces))
        .toStringAsFixed(decimalPlaces));
  }

  ///scroll to selected value
  _animate(ScrollController scrollController, double value) {
    scrollController.animateTo(
      value,
      duration: const Duration(seconds: 1),
      curve: const ElasticOutCurve(),
    );
  }
}

class _NumberPickerSelectedItemDecoration extends StatelessWidget {
  final Axis axis;
  final double itemExtent;
  final Decoration? decoration;

  const _NumberPickerSelectedItemDecoration({
    Key? key,
    required this.axis,
    required this.itemExtent,
    required this.decoration,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IgnorePointer(
        child: Container(
          width: isVertical ? double.infinity : itemExtent,
          height: isVertical ? itemExtent : double.infinity,
          decoration: decoration,
        ),
      ),
    );
  }

  bool get isVertical => axis == Axis.vertical;
}

///Returns AlertDialog as a Widget so it is designed to be used in showDialog method
class NumberPickerDialog extends StatefulWidget {
  final int minValue;
  final int maxValue;
  final int initialIntegerValue;
  final double initialDoubleValue;
  final int decimalPlaces;
  final Widget? title;
  final EdgeInsets? titlePadding;
  final Widget confirmWidget;
  final Widget cancelWidget;
  final int step;
  final bool infiniteLoop;
  final bool zeroPad;
  final bool highlightSelectedValue;
  final Decoration? decoration;
  final TextMapper? textMapper;
  final bool haptics;

  final bool isShowMonthName;
  final bool isJalali;

  ///constructor for integer values
  const NumberPickerDialog.integer({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.initialIntegerValue,
    this.title,
    this.titlePadding,
    this.step = 1,
    this.infiniteLoop = false,
    this.zeroPad = false,
    this.highlightSelectedValue = true,
    this.decoration,
    this.textMapper,
    this.haptics = false,
    Widget? confirmWidget,
    Widget? cancelWidget,
    this.isShowMonthName = false,
    this.isJalali = false,
  })  : confirmWidget = confirmWidget ?? const Text("OK"),
        cancelWidget = cancelWidget ?? const Text("CANCEL"),
        decimalPlaces = 0,
        initialDoubleValue = -1.0,
        super(key: key);

  ///constructor for decimal values
  const NumberPickerDialog.decimal({
    Key? key,
    required this.minValue,
    required this.maxValue,
    required this.initialDoubleValue,
    this.decimalPlaces = 1,
    this.title,
    this.titlePadding,
    this.highlightSelectedValue = true,
    this.decoration,
    this.textMapper,
    this.haptics = false,
    Widget? confirmWidget,
    Widget? cancelWidget,
    this.isShowMonthName = false,
    this.isJalali = false,
  })  : confirmWidget = confirmWidget ?? const Text("OK"),
        cancelWidget = cancelWidget ?? const Text("CANCEL"),
        initialIntegerValue = -1,
        step = 1,
        infiniteLoop = false,
        zeroPad = false,
        super(key: key);

  @override
  State<NumberPickerDialog> createState() {
    // ignore: no_logic_in_create_state
    return _NumberPickerDialogControllerState(
      initialIntegerValue,
      initialDoubleValue,
    );
  }
}

class _NumberPickerDialogControllerState extends State<NumberPickerDialog> {
  int selectedIntValue;
  double selectedDoubleValue;

  _NumberPickerDialogControllerState(
    this.selectedIntValue,
    this.selectedDoubleValue,
  );

  void _handleValueChanged(num value) {
    if (value is int) {
      setState(() => selectedIntValue = value);
    } else {
      setState(() => selectedDoubleValue = value as double);
    }
  }

  NumberPicker _buildNumberPicker() {
    return NumberPicker.integer(
      initialValue: selectedIntValue,
      minValue: widget.minValue,
      maxValue: widget.maxValue,
      step: widget.step,
      zeroPad: widget.zeroPad,
      highlightSelectedValue: widget.highlightSelectedValue,
      decoration: widget.decoration,
      onChanged: _handleValueChanged,
      textMapper: widget.textMapper,
      haptics: widget.haptics,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.title,
      titlePadding: widget.titlePadding,
      content: _buildNumberPicker(),
      actions: [
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: widget.cancelWidget,
        ),
        FlatButton(
          child: widget.confirmWidget,
          onPressed: () {
            Navigator.of(context).pop(
              widget.decimalPlaces > 0 ? selectedDoubleValue : selectedIntValue,
            );
          },
        ),
      ],
    );
  }
}
