# AnimatedPill Widget Tests Documentation

This document provides detailed information about the test cases for the `AnimatedPill` widget.

## Overview

The test suite verifies various aspects of the `AnimatedPill` widget, including default properties, custom styling, empty text handling, layout properties, and input validation. All tests are located in `animated_pill_test.dart`.

## Test Cases

### 1. Default Properties Test
**Purpose**: Verifies that the widget renders correctly with default properties.

**What it tests**:
- Text display
- Container existence
- Default styling properties:
  - Background color (`0xFF4CAF50`)
  - Text color (`0xFFFFFFFF`)
  - Font size (`9.0`)
  - Border radius (`50.0`)
  - Padding (`EdgeInsets.fromLTRB(8, 2, 8, 3)`)
  - Margin (`EdgeInsets.only(left: 8)`)

### 2. Custom Properties Test
**Purpose**: Ensures that custom styling properties are correctly applied.

**What it tests**:
- Custom background color (`0xFF2196F3`)
- Custom text color (`0xFF000000`)
- Custom font size (`16.0`)
- Custom border radius (`25.0`)
- Proper application of all custom properties
- Widget rendering with custom properties

### 3. Empty Text Test
**Purpose**: Verifies that the widget handles empty text gracefully.

**What it tests**:
- Empty text display
- Container existence with empty text
- Maintenance of proper styling with empty content:
  - Background color
  - Border radius
  - Padding
- Widget stability with empty input

### 4. Padding and Margin Test
**Purpose**: Validates custom layout properties.

**What it tests**:
- Custom padding (`EdgeInsets.fromLTRB(16, 8, 16, 8)`)
- Custom margin (`EdgeInsets.all(12)`)
- Exact measurements of:
  - Left, right, top, and bottom padding
  - Left, right, top, and bottom margin
- Proper application of layout properties

### 5. Invalid Animation Loops Test
**Purpose**: Verifies input validation for animation loops parameter.

**What it tests**:
- Assertion error for invalid value (-2)
- Valid values that should not throw errors:
  - -1 (infinite loops)
  - 0 (no animation)
  - 1 (single loop)
- Input validation behavior

## Running the Tests

To run all tests:
```bash
flutter test test/animated_pill_test.dart
```

## Test Structure
Each test follows a consistent structure:
1. Setup (if required)
2. Widget creation
3. Verification of properties
4. Assertions

## Notes
- Animation is disabled (`animationLoops: 0`) in widget tests to ensure consistent testing
- Each test is independent and does not rely on the state of other tests
- Tests use the `testWidgets` framework for widget testing and `test` for non-widget tests 