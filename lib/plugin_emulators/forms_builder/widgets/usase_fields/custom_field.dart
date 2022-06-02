import 'package:flutter/material.dart';
import 'package:psr_base/plugin_emulators/forms_builder/widgets/base_fields/form_builder_custom.dart';

enum WidgetType { input, other }

/// u must fill in the field data [T]
class CustomField<T> extends StatelessWidget {
  final WidgetType widgetType;
  final String name;

  /// u can customize the body of the widget by changing [decoration]
  final InputDecoration decoration;

  /// ur initial [data]
  final T data;

  /// when u changed data, [onChanged] called
  final void Function(T? data)? onChanged;
  final String? Function(T? data)? validator;

  /// Define any widget you want to validate in Child
  final Widget Function(StateBuilder<T>) child;
  const CustomField({
    Key? key,
    required this.name,
    required this.data,
    this.onChanged,
    this.validator,
    required this.child,
    this.widgetType = WidgetType.other,
    this.decoration = const InputDecoration(border: InputBorder.none),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderCustom<T>(
      name: name,
      data: data,
      decoration: decoration,
      onChanged: onChanged,
      validator: validator,

      /// when u want change the value
      /// u have too call [state.didChange(new data)] in [childFeild] function
      childFeild: (state) {
        /// if in your widget has no [InputDecorator]
        /// we call [InputDecorator]
        if (widgetType == WidgetType.other) {
          return InputDecorator(
            decoration: state.decoration,
            child: child(state),
          );
        }
        return child(state);
      },
    );
  }
}
