<img width=30% height=14% src="https://github.com/user-attachments/assets/24f643c1-f0f0-49c8-a552-6f67fe11fc12">  <img width=30% height=14% src="https://github.com/user-attachments/assets/278558d4-fb4f-4129-8ce9-37e5dd0ec5e0">  <img width=30% height=14% src="https://github.com/user-attachments/assets/8c78c4bf-5ce1-4480-b29c-1594a738ad0a">

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
    childDecoration: const ShimmerChildDecoration(childHeight: 95),
    child: ShimmerPremiumRepo().getDefaultChild, 
    // deafult child, change as you like
  ),
```


## Parameters

```dart
  // set ChildDecoration class as you want
  ChildDecoration(
    // set how many childs you may require
    final int childLength;
    // set child as you would like
    final Widget child;
    // set height of your child
    final double childHeight;
    // set width of your child
    final double? childWidth;
    // set child's background color
    final Color childBackgrounColor;
    // set borderRadius of the child 
    final double childBorderRadius;
    // set borderWidth of the child 
    final double childBorderWidth;
    // set borderColor of the child 
    final Color childBorderColor;
  )
  // set Shimmer's Decoration as you want
  class ShimmerDecoration{
    // 
    final ShimmerListType shimmerListType;
    // set the primary/starting color
    final Color highlightColor;
    // set the secondary color
    final Color secondaryColor;
    // set the duration of your each shimmer animation 
    final Duration duration;
    // set your shimmer when the child's are in vertical order
    verticalList: ShimmerVerticalList(
      // set the item separateHeight
      final double itemSeparateHeight
    )
    // set your shimmer when the child's are in horizontal order
    horizontalList: ShimmerHorizontalList(
      // set the item separateWidth
      final double itemSeparateWidth
    )
    // set your shimmer when the child's are in gridView order
    gridList: ShimmerGridList(
      // set the Grid items total height
      final double screenHeight;
      // set the direction of scrolling
      final Axis scrollDirection;
      // set if you want to reverse the list
      final bool reverse;
      // set the number of child's it shows in each row
      final int crossExisCount;
      // set space between each elemant in each row
      final double crossAxisSpacing;
      // set space between each elemant between each column
      final double mainAxisSpacing;
      // set space aspectRatio of your each child
      final double childAspectRatio;
      // set the clipBehavior
      final Clip clipBehavior;
    )
  }
  
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
