import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:psr_base/plugin_emulators/forms_builder/index.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final _stateKey = GlobalKey<FormBuilderState>();
  final shaker = ShakeController();

  String username = "";

  /// Default [InputField]
  // name = field id
  // data = initial data
  // title = if title not be a null, you have title on your field.
  // and shaker just seted for title, if you don't have title, dont need shaker
  // validator = if you want some validator for a field, you must to use [compose]
  Widget _inputField() {
    return InputField(
      name: "username",
      data: username,
      hintText: "",
      title: "شماره ملی خود را وارد کنید",
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      prefixIcon: Icons.credit_card,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: FormValidators.compose([
        FormValidators.required(context),
        FormValidators.creditCard(context),
      ]),
      onChanged: (content) => setState(() {
        username = content;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        key: _stateKey,
        shakeController: shaker,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
          children: [
            _inputField(),
          ],
        ),
      ),
    );
  }
}
