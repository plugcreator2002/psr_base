import "package:flutter/material.dart";
import "package:flutter/services.dart";
import 'package:psr_base/controllers/shake_controller.dart';
import 'package:psr_base/plugin_emulators/forms_builder/widgets/builders/form_builder_field.dart';

class FormBuilderInputField extends FormBuilderField<String> {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final TextStyle? style;
  final TextAlign textAlign;
  final bool autofocus;
  final bool obscureText;
  final int? maxLines;
  final int? minLines;
  static const int noMaxLength = -1;
  final int? maxLength;
  final MaxLengthEnforcement? maxLengthEnforcement;
  final VoidCallback? onEditingComplete;
  final ValueChanged<String?>? onSubmitted;
  final List<TextInputFormatter>? inputFormatters;
  final Brightness? keyboardAppearance;
  final EdgeInsets scrollPadding;
  final GestureTapCallback? onTap;
  final InputCounterWidgetBuilder? buildCounter;
  final ScrollPhysics? scrollPhysics;
  final ScrollController? scrollController;
  final String obscuringCharacter;
  final Widget Function(
    ShakeController? shaker,
    bool isValid,
    Widget child,
  )? builderOnFeild;

  FormBuilderInputField({
    Key? key,
    required String name,
    FormFieldValidator<String>? validator,
    String? initialValue,
    bool readOnly = false,
    InputDecoration decoration = const InputDecoration(),
    ValueChanged<String?>? onChanged,
    ValueTransformer<String?>? valueTransformer,
    bool enabled = true,
    FormFieldSetter<String>? onSaved,
    AutovalidateMode autovalidateMode = AutovalidateMode.disabled,
    VoidCallback? onReset,
    FocusNode? focusNode,
    this.builderOnFeild,
    this.maxLines = 1,
    this.obscureText = false,
    this.obscuringCharacter = "•",
    this.scrollPadding = const EdgeInsets.all(20.0),
    this.maxLengthEnforcement,
    this.textAlign = TextAlign.start,
    this.autofocus = false,
    this.keyboardType,
    this.style,
    this.controller,
    this.textInputAction,
    this.maxLength,
    this.onEditingComplete,
    this.onSubmitted,
    this.inputFormatters,
    this.keyboardAppearance,
    this.buildCounter,
    this.minLines,
    this.onTap,
    this.scrollController,
    this.scrollPhysics,
  }) : super(
          key: key,
          initialValue: controller != null ? controller.text : initialValue,
          name: name,
          validator: validator,
          valueTransformer: valueTransformer,
          onChanged: onChanged,
          autoValidateMode: autovalidateMode,
          onSaved: onSaved,
          enabled: enabled,
          onReset: onReset,
          decoration: decoration,
          focusNode: focusNode,
          builder: (fieldState) {
            final state = fieldState as FieldState;

            return Center(
              child: TextField(
                controller: state._effectiveController,
                focusNode: state.effectiveFocusNode,
                decoration: state.decoration,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                style: style,
                textAlign: textAlign,
                autofocus: autofocus,
                readOnly: readOnly,
                obscureText: obscureText,
                maxLines: maxLines,
                minLines: minLines,
                maxLength: maxLength,
                onTap: onTap,
                onEditingComplete: onEditingComplete,
                onSubmitted: onSubmitted,
                inputFormatters: inputFormatters,
                enabled: state.enabled,
                scrollPadding: scrollPadding,
                keyboardAppearance: keyboardAppearance,
                buildCounter: buildCounter,
                scrollController: scrollController,
                obscuringCharacter: obscuringCharacter,
                scrollPhysics: scrollPhysics,
              ),
            );
          },
        );

  @override
  FieldState createState() => FieldState();
}

class FieldState extends FormBuilderFieldState<FormBuilderInputField, String> {
  TextEditingController? get _effectiveController {
    return widget.controller ?? _controller;
  }

  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = widget.controller;
    _controller ??= TextEditingController(text: initialValue);

    if (_controller != null) {
      _controller?.addListener(_handleControllerChanged);
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_handleControllerChanged);
    if (null == widget.controller) {
      _controller?.dispose();
    }
    super.dispose();
  }

  @override
  void reset() {
    super.reset();
    _effectiveController?.text = initialValue ?? "";
  }

  @override
  void didChange(String? value) {
    super.didChange(value);
    if (_effectiveController?.text != value) {
      setState(() {
        _effectiveController?.text = value!;
      });
    }
  }

  void _handleControllerChanged() {
    if (_effectiveController?.text != value) {
      didChange(_effectiveController?.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.builderOnFeild != null) {
      return widget.builderOnFeild!(
        shaker,
        isValid,
        super.build(context),
      );
    }

    return Container(
      constraints: const BoxConstraints(minHeight: 30),
      child: super.build(context),
    );
  }
}
