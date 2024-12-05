<img width=30% height=14% src=" ">

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
  shimmer_premium: ^0.0.1  //Run flutter pub get to install the package.
```

## Usage
Here's a quick example to get started:

```dart
import 'package:shimmer_premium/shimmer_premium.dart';

  ShimmerPremium(
    length: 10,
    childDecoration: const ShimmerChildDecoration(childHeight: 95),
    shimmerListType: ShimmerListType.verticalList,
    // deafult child, change as you like
    child: ShimmerPremiumRepo().getDefaultChild, 
  ),
```


## Parameters

```dart
  // set how many childs you may require
  final int length;
  // set child as you would like
  final Widget child;
  // set height of your child
  final double itemHeight;
  // set width of your child
  final double? itemWidth;
  // set the primary/starting color
  final Color highlightColor;
  // set the secondary color
  final Color secondaryColor;
  // set the height when scrollDirection=Axis.vertical & Width scrollDirection=Axis.horizontal
  final double itemSeparateHeightWidth;
  // set the scroll direction as you like when scrollDirection=Axis.vertical/Axis.horizontal
  final Axis scrollDirection;
  // set the duration of your each shimmer animation 
  final Duration duration;
```

## Example
Check out the full example in the [`example`](https://pub.dev/packages/shimmer_premium/example) folder.

## License
This project is licensed under the MIT License.

## Contributions
Contributions are welcome! Feel free to file issues or submit pull requests to improve the package (https://github.com/jbjason/shimmer_premium)

## Support
For questions or suggestions, contact me via jubayeral040@gmail.com.

Check out the documentation on pub.dev for more details.

### Happy coding! 🚀