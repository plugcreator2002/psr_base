// import "package:flutter/material.dart";
// import 'package:forms_builder/components/controllers/shake_controller.dart';
// import 'package:forms_builder/forms_builder/utils/src/form_builder_field.dart';
// import 'package:forms_builder/forms_builder/utils/src/widgets/grouped_radio.dart';
// import 'package:forms_builder/forms_builder/widgets/builders/form_builder_field.dart';

// class FormBuilderRadioGroup<T> extends FormBuilderField<T> {
//   final Color? activeColor;
//   final Color? focusColor;
//   final Color? hoverColor;
//   final List<String>? disabled;
//   final MaterialTapTargetSize? materialTapTargetSize;
//   final Axis wrapDirection;
//   final WrapAlignment wrapAlignment;
//   final double wrapSpacing;
//   final WrapAlignment wrapRunAlignment;
//   final double wrapRunSpacing;
//   final WrapCrossAlignment wrapCrossAxisAlignment;
//   final TextDirection? wrapTextDirection;
//   final VerticalDirection wrapVerticalDirection;
//   final Widget? separator;
//   final ControlAffinity controlAffinity;
//   final OptionsOrientation orientation;
//   final MainAxisSize? mainAxisSize;
//   final List<RadioModel<T>> options;
//   final Widget Function(
//     ShakeController? shaker,
//     bool isValid,
//     Widget child,
//   )? builderOnFeild;

//   FormBuilderRadioGroup({
//     Key? key,
//     required String? name,
//     this.options = const [],
//     this.builderOnFeild,
//     FormFieldValidator<T>? validator,
//     T? initialValue,
//     InputDecoration decoration = const InputDecoration(),
//     ValueChanged<T?>? onChanged,
//     ValueTransformer<T?>? valueTransformer,
//     bool enabled = true,
//     FormFieldSetter<T>? onSaved,
//     AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
//     VoidCallback? onReset,
//     FocusNode? focusNode,
//     this.mainAxisSize = MainAxisSize.min,
//     this.activeColor,
//     this.focusColor,
//     this.hoverColor,
//     this.disabled,
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
//     this.orientation = OptionsOrientation.wrap,
//   }) : super(
//           key: key,
//           initialValue: initialValue,
//           name: name,
//           validator: validator,
//           valueTransformer: valueTransformer,
//           onChanged: onChanged,
//           autoValidateMode: autovalidateMode,
//           onSaved: onSaved,
//           enabled: enabled,
//           onReset: onReset,
//           focusNode: focusNode,
//           decoration: decoration,
//           builder: (fieldState) {
//             final state = fieldState as State<T>;

//             return InputDecorator(
//               decoration: state.decoration,
//               child: GroupedRadio<T>(
//                 orientation: orientation,
//                 mainAxisSize: mainAxisSize ?? MainAxisSize.min,
//                 value: state.value,
//                 options: options,
//                 onChanged: (data) => state.didChange(data),
//                 disabled: disabled,
//                 activeColor: activeColor,
//                 focusColor: focusColor,
//                 materialTapTargetSize: materialTapTargetSize,
//                 hoverColor: hoverColor,
//                 wrapAlignment: wrapAlignment,
//                 wrapCrossAxisAlignment: wrapCrossAxisAlignment,
//                 wrapDirection: wrapDirection,
//                 wrapRunAlignment: wrapRunAlignment,
//                 wrapRunSpacing: wrapRunSpacing,
//                 wrapSpacing: wrapSpacing,
//                 wrapTextDirection: wrapTextDirection,
//                 wrapVerticalDirection: wrapVerticalDirection,
//                 separator: separator,
//                 controlAffinity: controlAffinity,
//               ),
//             );
//           },
//         );

//   State<T> createState() => State<T>();
// }

// class State<T> extends FormBuilderFieldState<FormBuilderRadioGroup<T>, T> {
//   @override
//   Widget build(BuildContext context) {
//     if (widget.builderOnFeild != null) {
//       return widget.builderOnFeild!(
//         shaker,
//         isValid,
//         super.build(context),
//       );
//     }

//     return super.build(context);
//   }
// }
