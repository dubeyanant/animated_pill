# Animated Pill

A Flutter widget that creates an animated pill-shaped container with customizable appearance and animation properties. Perfect for displaying tags, labels, or badges with smooth animations.

## Features

- 🎨 Customizable appearance (colors, size, border radius)
- ⚡ Smooth animation with configurable duration
- 🔄 Configurable animation loops (infinite, specific count, or no animation)
- 📱 Responsive design that adapts to text content
- 🎯 Built-in pause duration between animations

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  animated_pill: ^1.0.0
```

## Usage

Here's a simple example of how to use the AnimatedPill widget:

```dart
import 'package:animated_pill/animated_pill.dart';

// Basic usage
AnimatedPill(
  text: 'New Feature',
  backgroundColor: Colors.green,
  textColor: Colors.white,
)

// Customized appearance
AnimatedPill(
  text: 'Limited Time Offer!',
  backgroundColor: Colors.orange,
  textColor: Colors.white,
  fontSize: 14.0,
  borderRadius: 20.0,
  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
)

// Customized animation
AnimatedPill(
  text: 'Flash Sale',
  animationLoops: 3, // Will animate 3 times
  animationDuration: Duration(milliseconds: 800),
  pauseDuration: Duration(milliseconds: 1000),
)
```

## Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `text` | `String` | Required | The text to display in the pill |
| `animationLoops` | `int` | -1 | Number of animation loops (-1 for infinite, 0 for no animation) |
| `backgroundColor` | `Color` | `Color(0xFF4CAF50)` | Background color of the pill |
| `textColor` | `Color` | `Color(0xFFFFFFFF)` | Color of the text |
| `fontSize` | `double` | 9.0 | Size of the text |
| `animationDuration` | `Duration` | 1000ms | Duration of each animation cycle |
| `pauseDuration` | `Duration` | 800ms | Duration to pause between animations |
| `padding` | `EdgeInsets` | `EdgeInsets.fromLTRB(8, 2, 8, 3)` | Padding around the text |
| `margin` | `EdgeInsets` | `EdgeInsets.only(left: 8)` | Margin around the pill |
| `borderRadius` | `double` | 50.0 | Border radius of the pill |

## Animation Behavior

The widget supports different animation modes through the `animationLoops` parameter:

- `-1`: Infinite animation loops (default)
- `0`: No animation, just shows the widget
- `n > 0`: Animates n times
- `n < -1`: Not allowed (throws assertion error)

## Testing

Comprehensive test cases are available in the `test` directory. The test suite includes:

- Default properties validation
- Custom styling verification
- Empty text handling
- Layout properties testing
- Animation loops validation

For detailed information about the test cases, please refer to [test/test_documentation.md](test/test_documentation.md).

To run the tests:
```bash
flutter test test/animated_pill_test.dart
```

## Example Screenshots

![pill](https://github.com/user-attachments/assets/437bd15d-ed96-4d8b-bf0b-b9a30a7a62c0)

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
