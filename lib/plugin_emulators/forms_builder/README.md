#### forms builder plugin it's for create forms with any fields with cool validation

#### import this line
    import 'package:psr_base/plugin_emulators/forms_builder/index.dart';

#### form fields shaker controller
    final shaker = ShakeController();

#### form key
    final _stateKey = GlobalKey<FormBuilderState>();

#### initial values
    String username = "";

#### forms body
    FormBuilder(
        key: _stateKey,
        shakeController: shaker,
        autovalidateMode: AutovalidateMode.disabled,
        child: Column(
            children: [
                InputField(
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
                )
            ],
        ),
    ),

#### enywhere you want validate the fields with shaker -> call this
    final isValids = await shaker.validateShaker(_stateKey);
    if (isValids == true) {}

#### enywhere you want just validate the fields without shaker -> call this
    final isValids = _stateKey.currentState?.validate();
    if (isValids == true) {}