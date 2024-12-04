<img width=30% height=14% src="https://github.com/user-attachments/assets/71cb7a16-e6f0-4fb2-80a4-19301d2819c3">

This is a simple yet highly customizable package for all kind of users.

## Features

- 🛠️ **Smooth Shimmer Animation**: Highlight placeholders with a gradient shimmer effect.
- 🔢 **Customizable**: Configure speed, colors, shapes, and directions of the shimmer.
- ⌨️ **Easy to Use**: Wrap any widget in a shimmer effect with minimal effort.
- 🔐 **Lightweight**: Designed for optimal performance with low overhead.

## Installation

Add the following line to your `pubspec.yaml`:

```dart
dependencies:
  shimmer_premium: ^0.0.8  //Run flutter pub get to install the package.
```

## Usage
Here's a quick example to get started:

```dart
import 'package:shimmer_premium/shimmer_premium.dart';

  ShimmerPremium(
    length: 6,
    onSubmit: (pin) {
      print("Entered OTP: $pin");
    },
  ),
```


## Parameters

```dart
  // set how many field you require **maximum 8**
  final int length;
  // returns the otp-field value if its **valid** 
  final Function(String val) onSubmit;
  // set borderRadius of otp-field
  final double borderRadius;
  // set the width of border while the otp-field is selected
  final double focusBorderWidth;
  // set the color of border while the otp-field is selected
  final Color focusBorderColor;
  // set the color of otp-field background while the otp-field is selected
  final Color focusFillColor;
  // set the idle(initial/unfocuse) boder color of the otp-field. 
  final double unFocusBorderWidth;
  // set the color of border while the otp-field is selected
  final Color unFocusBorderColor;
   // set the color of otp-field background while the otp-field is selected
  final Color unFocusFillColor;
  // set the width of border while the otp-field is empty
  final double errorBorderWidth;
  // set the color of border while the otp-field is selected
  final Color errorBorderColor;
   // set the color of otp-field background while the otp-field is selected
  final Color errorFillColor;
  // set the density of the shadow if u need shadow
  final double shadowElevation;
  // set the color of shadow
  final Color shodowColor;
  // if u want to hide otp text then set this value hideText=true
  final bool hideText;
  // there are 3 types of shape currently 1.OtpFiledShape.underscore 2.OtpFiledShape.square 3. OtpFiledShape.circular
  final OtpFiledShape otpFiledShape;
```

## Example
Check out the full example in the [`example`](https://pub.dev/packages/shimmer_premium/example) folder.

## License
This project is licensed under the MIT License.

## Contributions
Contributions are welcome! Feel free to file issues or submit pull requests to improve the package (https://github.com/jbjason/otp_field_premium)

## Support
For questions or suggestions, contact me via jubayeral040@gmail.com.

Check out the documentation on pub.dev for more details.

### Happy coding! 🚀