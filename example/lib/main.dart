import 'package:cool_stepper_plus/cool_stepper_plus.dart';
import 'package:flutter/material.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:ripple_button/ripple_button.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cool Stepper',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title: 'Cool Stepper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  String? selectedRole = 'Writer';
  final TextEditingController _nameCtrl = TextEditingController();
  final TextEditingController _emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final steps = [
      CoolStep(
        title: 'Basic Information',
        subtitle: 'Please fill some of the basic information to get started',
        alignment: Alignment.center,
        content: Form(
          key: _formKey,
          child: Column(
            children: [
              _buildTextField(
                labelText: 'Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                controller: _nameCtrl,
              ),
              _buildTextField(
                labelText: 'Email Address',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email address is required';
                  }
                  return null;
                },
                controller: _emailCtrl,
              ),
            ],
          ),
        ),
        validation: () {
          if (!_formKey.currentState!.validate()) {
            return 'Fill form correctly';
          }
          return null;
        },
      ),
      CoolStep(
        title: 'Select your role',
        subtitle: 'Choose a role that better defines you',
        alignment: Alignment.center,
        content: Container(
          child: Row(
            children: <Widget>[
              _buildSelector(
                context: context,
                name: 'Writer',
              ),
              SizedBox(width: 5.0),
              _buildSelector(
                context: context,
                name: 'Editor',
              ),
            ],
          ),
        ),
      ),
    ];

    void _onFinish() {
      final flush = Flushbar(
        message: 'Steps completed!',
        flushbarStyle: FlushbarStyle.FLOATING,
        margin: EdgeInsets.all(8.0),
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        icon: Icon(
          Icons.check_circle_outline_outlined,
          size: 28.0,
          color: Colors.green,
        ),
        duration: Duration(seconds: 2),
        leftBarIndicatorColor: Colors.green,
      );
      flush.show(context);
    }

    final stepper = CoolStepper(
      showErrorSnackbar: true,
      hasRoundedCorner: true,
      onCompleted: _onFinish,
      contentPadding: EdgeInsets.only(left: 40, right: 40),
      config: CoolStepperConfig(
        finishButton: Container(
          child: RippleButton(
            text: 'Finish',
            type: RippleButtonType.AMBER,
            padding: EdgeInsets.only(right: 16, bottom: 6),
            style: RippleButtonStyle(
              width: 20,
            ),
            onPressed: () => {},
          ),
        ),
        backButton: RippleButton(
          text: 'Back',
          type: RippleButtonType.BLUE_TRANSLUCENT,
          padding: EdgeInsets.only(left: 16, bottom: 6),
          style: RippleButtonStyle(
            width: 24,
          ),
          onPressed: () => {},
        ),
        nextButton: RippleButton(
          text: '\bNext\b',
          type: RippleButtonType.AMBER,
          padding: EdgeInsets.only(right: 16, bottom: 6),
          style: RippleButtonStyle(
            width: 20,
          ),
          onPressed: () => {},
        ),
      ),
      steps: steps,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Container(
        child: stepper,
      ),
    );
  }

  Widget _buildTextField({
    String? labelText,
    FormFieldValidator<String>? validator,
    TextEditingController? controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelText,
        ),
        validator: validator,
        controller: controller,
      ),
    );
  }

  Widget _buildSelector({
    BuildContext? context,
    required String name,
  }) {
    final isActive = name == selectedRole;

    return Expanded(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isActive ? Theme.of(context!).primaryColor : null,
          border: Border.all(
            width: 0,
          ),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: RadioListTile(
          value: name,
          activeColor: Colors.white,
          groupValue: selectedRole,
          onChanged: (String? v) {
            setState(() {
              selectedRole = v;
            });
          },
          title: Text(
            name,
            style: TextStyle(
              color: isActive ? Colors.white : null,
            ),
          ),
        ),
      ),
    );
  }
}
