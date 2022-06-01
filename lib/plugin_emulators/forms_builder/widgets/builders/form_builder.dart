import 'package:flutter/foundation.dart';
import "package:flutter/material.dart";
import 'package:psr_base/controllers/shake_controller.dart';
import 'package:psr_base/plugin_emulators/forms_builder/widgets/builders/form_builder_field.dart';
import 'package:psr_base/utils/logger.dart';

class FormBuilder extends StatefulWidget {
  final VoidCallback? onChanged;

  final WillPopCallback? onWillPop;

  final ShakeController? shakeController;

  final Widget child;

  final AutovalidateMode? autovalidateMode;

  final Map<String, dynamic> initialValue;

  final bool skipDisabled;

  final bool enabled;

  final bool autoValidating;

  const FormBuilder({
    final Key? key,
    required this.child,
    this.onChanged,
    this.autovalidateMode,
    this.onWillPop,
    this.initialValue = const <String, dynamic>{},
    this.skipDisabled = false,
    this.enabled = true,
    this.shakeController,
    this.autoValidating = false,
  }) : super(key: key);

  static FormBuilderState? of(BuildContext context) {
    return context.findAncestorStateOfType<FormBuilderState>();
  }

  @override
  FormBuilderState createState() => FormBuilderState();
}

class FormBuilderState extends State<FormBuilder> {
  final _formKey = GlobalKey<FormState>();

  bool get enabled => widget.enabled;

  ShakeController? get shakeController => widget.shakeController;

  bool validating = false;

  final _fields = <String, FormBuilderFieldState>{};

  final _value = <String, dynamic>{};

  Map<String, dynamic> get value => Map<String, dynamic>.unmodifiable(_value);

  Map<String, dynamic> get initialValue => widget.initialValue;

  Map<String, FormBuilderFieldState> get fields => _fields;

  void setInternalFieldValue(String name, dynamic value) {
    setState(() => _value[name] = value);
  }

  void removeInternalFieldValue(String name) {
    setState(() => _value.remove(name));
  }

  void registerField(String name, FormBuilderFieldState field) {
    assert(() {
      if (_fields.containsKey(name)) {
        if (kDebugMode) {
          logger(
            "Warning! Replacing duplicate Field for $name"
            " -- this is OK to ignore as long as the field was intentionally replaced",
          );
        }
      }
      return true;
    }());
    _fields[name] = field;
  }

  void unregisterField(String name, FormBuilderFieldState field) {
    assert(_fields.containsKey(name));
    if (field == _fields[name]) {
      _fields.remove(name);
    } else {
      assert(() {
        logger(
          "Warning! Ignoring Field unregistration for $name"
          " -- this is OK to ignore as long as the field was intentionally replaced",
        );
        return true;
      }());
    }
    _value.remove(name);
  }

  void save() {
    _formKey.currentState!.save();
  }

  void invalidateField({required String name, String? errorText}) {
    fields[name]?.invalidate(errorText ?? "");
  }

  void invalidateFirstField({required String errorText}) {
    fields.values.first.invalidate(errorText);
  }

  bool validate({bool focus = false}) {
    final hasError = !_formKey.currentState!.validate();
    if (hasError) {
      validating = true;
    }

    return !hasError;
  }

  bool saveAndValidate() {
    save();
    return validate();
  }

  void reset() {
    validating = false;
    _formKey.currentState!.reset();
  }

  void patchValue(Map<String, dynamic> val) {
    val.forEach((key, dynamic value) {
      _fields[key]?.didChange(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: widget.autovalidateMode,
      onWillPop: widget.onWillPop,
      onChanged: () {
        if (widget.onChanged != null) {
          (widget.onChanged ?? () {})();
        }
        if (widget.autoValidating) {
          validating = widget.autoValidating;
        }
      },
      child: FocusTraversalGroup(
        policy: WidgetOrderTraversalPolicy(),
        descendantsAreFocusable: true,
        child: widget.child,
      ),
    );
  }
}
