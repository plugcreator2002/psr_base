// import "package:flutter/material.dart";
// import "package:sanar/common/config/colors.dart";
// import "package:sanar/widgets/form-fields/minors-widgets/button.dart";

// // ignore: must_be_immutable
// class SwitchField extends StatefulWidget {
//   final ThemeDataConfig theme;
//   final String? initialValue;
//   final ValueChanged<String?> onChanged;
//   final SwitchButtonOptions? firstValues;
//   final SwitchButtonOptions? latterValues;

//   const SwitchField({
//     final Key? key,
//     this.initialValue,
//     this.firstValues,
//     this.latterValues,
//     required this.theme,
//     required this.onChanged,
//   }) : super(key: key);
//   @override
//   _SwitchFieldState createState() => _SwitchFieldState(this.initialValue);
// }

// class _SwitchFieldState extends State<SwitchField> {
//   String? status;

//   _SwitchFieldState(initial) {
//     status = initial;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         SwitchButton(
//           theme: widget.theme,
//           options: SwitchButtonOptions(
//             id: widget.latterValues?.id,
//             label: widget.latterValues?.label,
//             status: status == widget.latterValues?.id,
//             callback: (value) {
//               setState(() => status = value);
//               widget.onChanged(value);
//             },
//           ),
//         ),
//         SwitchButton(
//           theme: widget.theme,
//           options: SwitchButtonOptions(
//             id: widget.firstValues?.id,
//             label: widget.firstValues?.label,
//             status: status == widget.firstValues?.id,
//             callback: (value) {
//               setState(() => status = value);
//               widget.onChanged(value);
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
