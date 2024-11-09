# Cool Stepper Reloaded

[![Pub Version](https://img.shields.io/pub/v/cool_stepper_plus)](https://pub.dev/packages/cool_stepper_plus)

**Cool Stepper Plus** is a widget that displays a step by step sequence of operations. it could be helpful for a form wizard or onboarding.

This project was forked from [Cool Stepper](https://github.com/emrade/flutter-cool-stepper), since I needed a null-safety package and keep an active development for this great widget. Thanks to emrade and all developers that helped to build such a amazing widget.

## Screenshots


### **Header** enabled and with default button

<img src="https://raw.githubusercontent.com/emrade/flutter-cool-stepper/master/screenshots/1.png" width="150"/>  <img src="https://raw.githubusercontent.com/emrade/flutter-cool-stepper/master/screenshots/2.png" width="150"/>


### **Header** disabled and with custom button [Ripple Button](https://pub.dev/packages/ripple_button)
<img src="https://user-images.githubusercontent.com/6011385/119211643-cdbe0380-ba89-11eb-9520-92e2e369c5d3.png" width="150"/>  <img src="https://user-images.githubusercontent.com/6011385/119211557-38227400-ba89-11eb-9233-142270d1028c.png" width="150"/>

### Example

```
CoolStepper(
   showErrorSnackbar: false,   // If true, snackbar will be show if there is any error at form. If false, no snackbar will be shown
   isHeaderEnabled: false,    // If true, header will be shown. if false, header will be disabled
   onCompleted: () => { // submit information to server },
   steps: List<CoolStep>[
       CoolStep(
        title: "Basic Information",
        subtitle: "Please fill some of the basic information to get started",
        content:  // Add the widget to get basic info here
       ),
       CoolStep(
        title: "Add Your address",
        subtitle: "Please fill your Address",
        content: // Add the widget to get address info here
       ),
       CoolStep(
        title: "Add a profile picture",
        subtitle: "Please add a profile picture if you want",
        content: // Add the widget to get profile pic here
       ),
   ],
);
```

This is a example of validation. The validation expects a function to validate the whole form. It will return a error String or null if everything is right.
```
validation: () {
 if (!_formKey.currentState!.validate()) {
   return 'Fill form correctly';   // Error message to be shown
 }
 return null;
},
```

### CoolStepper Class

| Attribute   | Data type         | Description                                                                |                                     Default Value                                     |
| :---------- | :---------------- | :------------------------------------------------------------------------- | :-----------------------------------------------------------------------------------: |
| onCompleted | Void Function()   | @required - A function that is triggers when all steps have been completed |                                         Null                                         |
| steps       | List<CoolStep>    | @required                                                                  |                                         Null                                          |
| config      | CoolStepperConfig | Helps to customize your stepper                                            | CoolStepperConfig(backText: "BACK", nextText: "NEXT", stepText: "STEP", ofText: "OF") |
| alignment                                            | Alignment |  This will change content aligment, between header (if enabled) and button | Alignment.topCenter |
| isHeaderEnabled          | bool       | Build a header for each step, the default value is true | true |
| showErrorSnackbar          | bool       | Show snackbar with error, if validation fails. Error comes from return from validation function | false |


### CoolStepperConfig Properties

| Attribute         | Data type    | Description                                                                                                                                                                                     |                                Default Value                                |
| :---------------- | :----------- | :---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | :-------------------------------------------------------------------------: |
| backText          | String       | The text that should be displayed for the back button                                                                                                                                           |                                    BACK                                     |
| nextText          | String       | The text that should be displayed for the next button                                                                                                                                           |                                    NEXT                                     |
| finalText         | String       | The text that should be displayed for the next button on the final step                                                                                                                         |                                   FINISH                                    |
| stepText          | String       | The text that describes the progress                                                                                                                                                            |                                    STEP                                     |
| ofText            | String       | The text that describes the progress                                                                                                                                                            |                                     OF                                      |
| headerColor       | Color        | This is the background color of the header                                                                                                                                                      |               Theme.of(context).primaryColor.withOpacity(0.1)               |
| (**DEPRECATED**) iconColor - Use icon instead.         | Color        | This is the color of the icon. **Warning:** This will be removed soon, use icon instead                                                                                                                                                                   |                                Color.black38                                |
| icon              | Icon         | This icon replaces the default icon                                                                                                                                                             |              Icon(Icons.help_outline,size: 18,Colors.black38)               |
| titleTextStyle    | TextStyle    | This is the textStyle for the title text                                                                                                                                                        | TextStyle(fontSize: 16.0,fontWeight: FontWeight.bold,color: Colors.black38) |
| subtitleTextStyle | TextStyle    | This is the textStyle for the subtitle text                                                                                                                                                     |  TextStyle(fontSize: 14.0,fontWeight: FontWeight.w600,color: Colors.black)  |
| backTextList      | List<String> | A List of string that when supplied will override 'backText'. Must be one less than the number of steps since for the first step, the backText won't be visible                                 |                                    null                                     |
| nextTextList      | List<String> | A List of string that when supplied will override 'nextText'Must be one less than the number of steps since the 'finalText' attribute is able to set the value for the final step's next button |                                    null                                     |

## ToDo
- [x] Added TextStyle parameter to customize to Next Button(2.2.0)
- [x] Added TextStyle parameter to customize to Back Button (2.2.0)
- [ ] Added TextStyle parameter to customize to Steps x of N
- [ ] Added Option to change button background color for Next Button
- [ ] Added Option to change button background color for Next Button

Please open an issue if something doesn't work or is not clear enough.

## License

See [LICENSE.md](LICENSE.md)
