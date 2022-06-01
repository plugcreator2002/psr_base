// ignore_for_file: no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psr_base/plugin_emulators/forms_builder/widgets/base_fields/form_builder_input_field.dart';
import 'package:psr_base/ui_related/feilds_title.dart';

class InputField extends StatefulWidget {
  final void Function(String content) onChanged;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final String? label;
  final bool obscureText;
  final bool isPassword;
  final TextInputAction textInputAction;
  final String name;
  final String? data;
  final String? Function(String? data)? validator;
  final String? title;
  final TextInputType keyboardType;
  final List<TextInputFormatter> inputFormatters;
  final InputDecoration? decoration;
  final int? maxLength;
  final String? hintText;
  final TextStyle? style;
  const InputField({
    Key? key,
    required this.onChanged,
    this.prefixIcon,
    this.hintText,
    this.label,
    this.obscureText = false,
    this.isPassword = false,
    this.textInputAction = TextInputAction.done,
    required this.name,
    this.data,
    this.validator,
    this.title,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters = const [],
    this.maxLength,
    this.decoration,
    this.style,
  }) : super(key: key);

  @override
  State<InputField> createState() => _InputFieldState(obscureText);
}

class _InputFieldState extends State<InputField> {
  final controller = TextEditingController();
  bool obscure = false;

  _InputFieldState(bool obscureText) {
    obscure = obscureText;
  }

  Widget? get _suffix {
    if (widget.isPassword) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () => setState(() {
            obscure = !obscure;
          }),
          child: Icon(
            obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
            size: 20,
            color: const Color(0xFF4C4D52),
          ),
        ),
      );
    }

    return null;
  }

  Widget? get _prefix {
    if (widget.prefixIcon != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: InkWell(
          onTap: () => setState(() {
            obscure = !obscure;
          }),
          child: Icon(
            widget.prefixIcon,
            size: 20,
            color: const Color(0xFF4C4D52),
          ),
        ),
      );
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderInputField(
      name: widget.name,
      initialValue: widget.data,
      validator: widget.validator,
      style: widget.style,
      onChanged: (data) => widget.onChanged(data ?? ""),
      decoration: [
        widget.decoration ?? const InputDecoration(),
        InputDecoration(
          counterText: "",
          hintText: widget.hintText,
          focusedErrorBorder: InputBorder.none,
          errorText: null,
          errorMaxLines: null,
          errorStyle: const TextStyle(height: 0, fontSize: 0),
          errorBorder: InputBorder.none,
          prefixIconConstraints: const BoxConstraints(
            maxHeight: 20,
          ),
          suffixIconConstraints: const BoxConstraints(
            maxHeight: 20,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
          hintStyle: const TextStyle(
            color: Color(0xFF4C4D52),
            fontSize: 14,
            fontFamily: "yekan",
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide.none,
          ),
        ),
      ][widget.decoration != null ? 0 : 1],
      builderOnFeild: (shaker, isValid, child) {
        return Column(
          children: [
            if (widget.title != null) ...[
              FieldsTitle(
                name: widget.name,
                title: widget.title,
                isValid: isValid,
                controller: shaker,
              ),
            ],
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: const Color(0xFFF6F6F6),
                  border: Border(
                    bottom: BorderSide(
                      width: 1,
                      color: [
                        Colors.white,
                        const Color(0xFFE84F35),
                      ][isValid ? 0 : 1],
                    ),
                  ),
                ),
                child: [
                  child,
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _prefix,
                      Expanded(child: child),
                      _suffix,
                    ].whereType<Widget>().toList(),
                  )
                ][(_prefix == null && _suffix == null) ? 0 : 1],
              ),
            ),
          ],
        );
      },
    );
  }
}
