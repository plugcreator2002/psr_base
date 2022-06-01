// import "package:flutter/material.dart";
// import 'package:forms_builder/forms_builder/widgets/builders/form_builder_field.dart';

// class GroupedRadio<T> extends StatefulWidget {
//   final List<SingleSelectionModel> options;

//   final T? value;

//   final List<String>? disabled;

//   final OptionsOrientation orientation;

//   final ValueChanged<T?> onChanged;

//   final Color? activeColor;

//   final MaterialTapTargetSize? materialTapTargetSize;

//   final Color? focusColor;

//   final Color? hoverColor;

//   final Axis wrapDirection;

//   final WrapAlignment? wrapAlignment;

//   final double? wrapSpacing;

//   final WrapAlignment wrapRunAlignment;

//   final double? wrapRunSpacing;

//   final WrapCrossAlignment wrapCrossAxisAlignment;

//   final TextDirection? wrapTextDirection;

//   final VerticalDirection wrapVerticalDirection;

//   final Widget? separator;

//   final ControlAffinity controlAffinity;

//   final MainAxisSize mainAxisSize;

//   const GroupedRadio({
//     Key? key,
//     required this.options,
//     required this.orientation,
//     required this.onChanged,
//     this.value,
//     this.disabled,
//     this.activeColor,
//     this.focusColor,
//     this.hoverColor,
//     this.materialTapTargetSize,
//     this.wrapDirection = Axis.horizontal,
//     this.wrapAlignment = WrapAlignment.start,
//     this.wrapSpacing = 0.0,
//     this.wrapRunAlignment = WrapAlignment.start,
//     this.wrapRunSpacing = 0.0,
//     this.wrapCrossAxisAlignment = WrapCrossAlignment.start,
//     this.wrapTextDirection,
//     this.wrapVerticalDirection = VerticalDirection.down,
//     this.separator,
//     this.controlAffinity = ControlAffinity.leading,
//     this.mainAxisSize = MainAxisSize.max,
//   }) : super(key: key);

//   @override
//   GroupedRadioState<T> createState() => GroupedRadioState<T>();
// }

// class GroupedRadioState<T> extends State<GroupedRadio<T?>> {
//   @override
//   Widget build(BuildContext context) {
//     final widgetList = <Widget>[];
//     for (var i = 0; i < widget.options.length; i++) {
//       widgetList.add(item(widget.options[i]));
//     }

//     Widget finalWidget;
//     if (widget.orientation == OptionsOrientation.vertical) {
//       finalWidget = SingleChildScrollView(
//         scrollDirection: Axis.vertical,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: widgetList,
//         ),
//       );
//     } else if (widget.orientation == OptionsOrientation.horizontal) {
//       finalWidget = SingleChildScrollView(
//         scrollDirection: Axis.horizontal,
//         child: Row(
//           children: widgetList.map((item) {
//             return Column(children: <Widget>[item]);
//           }).toList(),
//         ),
//       );
//     } else {
//       finalWidget = SingleChildScrollView(
//         child: Wrap(
//           alignment: widget.wrapAlignment ?? WrapAlignment.spaceBetween,
//           direction: Axis.horizontal,
//           runSpacing: widget.wrapRunSpacing ?? 5,
//           spacing: widget.wrapSpacing ?? 5,
//           textDirection: widget.wrapTextDirection,
//           crossAxisAlignment: widget.wrapCrossAxisAlignment,
//           verticalDirection: widget.wrapVerticalDirection,
//           runAlignment: widget.wrapRunAlignment,
//           children: widgetList,
//         ),
//       );
//     }
//     return finalWidget;
//   }

//   Widget item(SingleSelectionModel item) {
//     final isDisabled = widget.disabled?.contains(item.code) ?? false;
//     final control = Radio<T?>(
//       groupValue: widget.value,
//       focusColor: widget.focusColor,
//       hoverColor: widget.hoverColor,
//       materialTapTargetSize: widget.materialTapTargetSize,
//       value: item.code as T,
//       onChanged: !isDisabled ? (a) => widget.onChanged(a) : null,
//     );

//     final label = GestureDetector(
//       onTap: !isDisabled ? () => widget.onChanged(item.code as T) : null,
//       child: Text(
//         item.label,
//         style: TextStyle(
//           fontSize: 15,
//           color: widget.value == item.code ? Colors.purple : Colors.grey,
//         ),
//       ),
//     );

//     return Row(
//       mainAxisSize: widget.mainAxisSize,
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         if (widget.controlAffinity == ControlAffinity.leading) control,
//         Flexible(child: label),
//         if (widget.controlAffinity == ControlAffinity.trailing) control,
//         if (widget.separator != null) widget.separator!,
//       ],
//     );
//   }
// }
