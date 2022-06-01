// import "package:flutter/material.dart";
// import 'package:forms_builder/components/controllers/shake_controller.dart';
// import 'package:forms_builder/forms_builder/utils/src/fields/form_builder_radio_group.dart';
// import 'package:forms_builder/forms_builder/utils/src/form_builder_field.dart';
// import 'package:forms_builder/forms_builder/utils/src/widgets/grouped_radio.dart';
// import 'package:forms_builder/forms_builder/widgets/feilds_title.dart';

// class RadioField<T> extends StatelessWidget {
//   final String? name;
//   final FormFieldValidator<T>? validator;
//   final OptionsOrientation orientation;
//   final void Function(T? value)? onChanged;
//   final List<RadioModel<T>> items;
//   final FieldsTitle? feildTitle;
//   final T? data;
//   final Widget Function(
//     ShakeController? shaker,
//     bool isValid,
//     Widget child,
//   )? builderOnFeild;

//   const RadioField({
//     Key? key,
//     required this.name,
//     this.onChanged,
//     this.validator,
//     this.data,
//     required this.items,
//     this.orientation = OptionsOrientation.wrap,
//     this.feildTitle,
//     this.builderOnFeild,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return FormBuilderRadioGroup<T>(
//       validator: validator,
//       name: name,
//       initialValue: data,
//       orientation: orientation,
//       onChanged: onChanged ?? (value) {},
//       options: items,
//       decoration: const InputDecoration(
//         border: InputBorder.none,
//         errorText: null,
//         errorStyle: TextStyle(
//           fontSize: 0,
//           height: 0,
//         ),
//       ),
//       builderOnFeild: (shaker, isValid, child) {
//         if (builderOnFeild != null) {
//           return builderOnFeild!(shaker, isValid, child);
//         }
//         return Column(
//           children: [
//             if (feildTitle != null) ...[
//               // FieldsTitle(
//               //   name: name,
//               //   title: feildTitle?.title,
//               //   isValid: isValid,
//               //   controller: shaker,
//               // ),
//             ],
//             child,
//           ],
//         );
//       },
//     );
//   }
// }
