// ignore_for_file: avoid_renaming_method_parameters

import "package:flutter/material.dart";
import 'package:psr_base/controllers/shake_controller.dart';
import 'form_builder.dart';

enum OptionsOrientation { horizontal, vertical, wrap }

enum ControlAffinity { leading, trailing }

typedef ValueTransformer<T> = dynamic Function(T value);

class FormBuilderField<T> extends FormField<T?> {
  final String? name;

  final ValueTransformer<T>? valueTransformer;

  final ValueChanged<T?>? onChanged;

  final InputDecoration decoration;

  final VoidCallback? onReset;

  final FocusNode? focusNode;

  const FormBuilderField({
    Key? key,
    FormFieldSetter<T>? onSaved,
    T? initialValue,
    AutovalidateMode autoValidateMode = AutovalidateMode.onUserInteraction,
    bool enabled = true,
    FormFieldValidator<T>? validator,
    required FormFieldBuilder<T?> builder,
    required this.name,
    this.valueTransformer,
    this.onChanged,
    this.decoration = const InputDecoration(),
    this.onReset,
    this.focusNode,
  }) : super(
          key: key,
          onSaved: onSaved,
          initialValue: initialValue,
          autovalidateMode: autoValidateMode,
          enabled: enabled,
          builder: builder,
          validator: validator,
        );

  @override
  FormBuilderFieldState<FormBuilderField<T>, T> createState() {
    return FormBuilderFieldState<FormBuilderField<T>, T>();
  }
}

class FormBuilderFieldState<F extends FormBuilderField<T?>, T>
    extends FormFieldState<T?> {
  String? _customErrorText;

  @override
  F get widget => super.widget as F;

  bool hasInteracted = false;

  FormBuilderState? get formState => _formBuilderState;

  T? get initialValue {
    if (widget.initialValue != null) {
      return widget.initialValue;
    }
    return (_formBuilderState?.initialValue ?? {})[widget.name] as T?;
  }

  FormBuilderState? _formBuilderState;

  @override
  String? get errorText => super.errorText ?? _customErrorText;

  @override
  bool get hasError {
    return super.hasError || decoration.errorText != null || errorText != null;
  }

  bool get isValidate {
    if (validate()) return true;
    if (!_formBuilderState!.validating && !validate()) return true;
    if (_formBuilderState!.validating && validate()) return true;
    return false;
  }

  ShakeController? get shaker => _formBuilderState?.shakeController;

  @override
  bool get isValid {
    return super.isValid && decoration.errorText == null && errorText == null;
  }

  bool _touched = false;

  bool get enabled => widget.enabled && (_formBuilderState?.enabled ?? true);

  FocusNode? _focusNode;

  FocusNode? get effectiveFocusNode => _focusNode;

  @override
  void initState() {
    super.initState();
    if (widget.name != null) {
      _formBuilderState = FormBuilder.of(context);
      _formBuilderState?.registerField(widget.name ?? "", this);

      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode!.addListener(_touchedHandler);

      setValue(initialValue);
    }
  }

  @override
  void dispose() {
    if (widget.name != null) {
      _focusNode!.removeListener(_touchedHandler);
      if (null == widget.focusNode) {
        _focusNode!.dispose();
      }
      if (_formBuilderState != null) {
        _formBuilderState?.unregisterField(widget.name ?? "", this);
      }
    }
    super.dispose();
  }

  @override
  void save() {
    super.save();
    if (widget.name != null) {
      if (_formBuilderState != null) {
        if (enabled || !_formBuilderState!.widget.skipDisabled) {
          _formBuilderState!.setInternalFieldValue(
            widget.name ?? "",
            [
              widget.valueTransformer!(value),
              value
            ][widget.valueTransformer != null ? 0 : 1],
          );
        } else {
          _formBuilderState!.removeInternalFieldValue(widget.name ?? "");
        }
      }
    }
  }

  void _touchedHandler() {
    if (_focusNode!.hasFocus && _touched == false) {
      setState(() => _touched = true);
    }
  }

  @override
  void didChange(T? val) {
    super.didChange(val);
    widget.onChanged?.call(value);
  }

  @override
  void reset() {
    super.reset();
    setValue(initialValue);
    widget.onReset?.call();
  }

  @override
  bool validate({bool clearCustomError = true}) {
    if (clearCustomError) {
      setState(() => _customErrorText = null);
    }
    return super.validate() && !hasError;
  }

  void requestFocus() {
    FocusScope.of(context).requestFocus(effectiveFocusNode);
    Scrollable.ensureVisible(context);
  }

  void invalidate(String errorText) {
    setState(() => _customErrorText = errorText);
    validate(clearCustomError: false);
  }

  InputDecoration get decoration {
    return widget.decoration.copyWith(
      errorText: widget.decoration.errorText ?? errorText,
    );
  }
}
