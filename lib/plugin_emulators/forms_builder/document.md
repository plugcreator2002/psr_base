# import this line and you can use forms_builder
import 'package:psr_base/plugin_emulators/forms_builder/index.dart';

# Form Fields Shaker Controller
final shaker = ShakeController();

# Form key
final _stateKey = GlobalKey<FormBuilderState>();

# Initial Values
String username = "";
String password = "";

FormBuilder(
    key: _stateKey,
    shakeController: shaker,
    autovalidateMode: AutovalidateMode.disabled,
    child: Column(
        children: [
            <!-- Default [InputField] -->
            <!-- name = field id -->
            <!-- data = initial data -->
            <!-- title = if title not be a null, you have title on your field.
            and shaker just seted for title, if you don't have title, dont need shaker -->
            <!-- validator = if you want some validator for a field, you must to use [compose] -->

            InputField(
                name: "username",
                data: username,
                hintText: "",
                title: "شماره ملی خود را وارد کنید",
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                prefixIcon: Icons.credit_card,
                inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly
                ],
                validator: FormValidators.compose([
                    FormValidators.required(context),
                    FormValidators.creditCard(context),
                ]),
                onChanged: (content) => setState(() {
                    username = content;
                }),
            ),
        ],
    ),
),

# enywhere you want validate the fields with shaker -> call this
final isValids = await shaker.validateShaker(_stateKey);
if (isValids == true) {}

# enywhere you want just validate the fields without shaker -> call this
final isValids = _stateKey.currentState?.validate();
if (isValids == true) {}