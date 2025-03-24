import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:animated_pill/animated_pill.dart';

void main() {
  testWidgets('Default Properties Test - Verifies basic rendering and default values',
      (WidgetTester tester) async {
    // Build the widget with default properties
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedPill(
            'Test Pill',
            animationLoops: 0, // Disable animation for testing
          ),
        ),
      ),
    );

    // Verify the text is displayed
    expect(find.text('Test Pill'), findsOneWidget);

    // Verify the container exists
    expect(find.byType(Container), findsOneWidget);

    // Verify the container has correct default styling
    final container = tester.widget<Container>(
      find.ancestor(
        of: find.text('Test Pill'),
        matching: find.byType(Container),
      ),
    );

    // Check default background color
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, const Color(0xFF4CAF50));

    // Check default text color
    final text = tester.widget<Text>(find.text('Test Pill'));
    expect(text.style?.color, const Color(0xFFFFFFFF));

    // Check default font size
    expect(text.style?.fontSize, 9.0);

    // Check default border radius
    expect(decoration.borderRadius, BorderRadius.circular(50.0));

    // Check default padding
    expect(container.padding, const EdgeInsets.fromLTRB(8, 2, 8, 3));

    // Check default margin
    expect(container.margin, const EdgeInsets.only(left: 8));
  });

  testWidgets('Custom Properties Test - Verifies custom styling is applied correctly',
      (WidgetTester tester) async {
    // Custom properties
    const customBackgroundColor = Color(0xFF2196F3);
    const customTextColor = Color(0xFF000000);
    const customFontSize = 16.0;
    const customBorderRadius = 25.0;

    // Build the widget with custom properties
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedPill(
            'Custom Pill',
            animationLoops: 0,
            backgroundColor: customBackgroundColor,
            textColor: customTextColor,
            fontSize: customFontSize,
            borderRadius: customBorderRadius,
          ),
        ),
      ),
    );

    // Verify the text is displayed
    expect(find.text('Custom Pill'), findsOneWidget);

    // Verify the container exists
    expect(find.byType(Container), findsOneWidget);

    // Verify the container has correct custom styling
    final container = tester.widget<Container>(
      find.ancestor(
        of: find.text('Custom Pill'),
        matching: find.byType(Container),
      ),
    );

    // Check custom background color
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, customBackgroundColor);

    // Check custom text color
    final text = tester.widget<Text>(find.text('Custom Pill'));
    expect(text.style?.color, customTextColor);

    // Check custom font size
    expect(text.style?.fontSize, customFontSize);

    // Check custom border radius
    expect(decoration.borderRadius, BorderRadius.circular(customBorderRadius));
  });

  testWidgets('Empty Text Test - Verifies widget handles empty text gracefully',
      (WidgetTester tester) async {
    // Build the widget with empty text
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedPill(
            '',
            animationLoops: 0,
          ),
        ),
      ),
    );

    // Verify empty text is displayed (should find exactly one empty Text widget)
    expect(find.text(''), findsOneWidget);

    // Verify the container still exists and maintains minimum size
    final container = tester.widget<Container>(
      find.ancestor(
        of: find.text(''),
        matching: find.byType(Container),
      ),
    );

    // Verify the container still has proper styling
    final decoration = container.decoration as BoxDecoration;
    expect(decoration.color, const Color(0xFF4CAF50));
    expect(decoration.borderRadius, BorderRadius.circular(50.0));
    expect(container.padding, const EdgeInsets.fromLTRB(8, 2, 8, 3));
  });

  testWidgets('Padding and Margin Test - Verifies custom layout properties',
      (WidgetTester tester) async {
    // Custom padding and margin
    const customPadding = EdgeInsets.fromLTRB(16, 8, 16, 8);
    const customMargin = EdgeInsets.all(12);

    // Build the widget with custom padding and margin
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnimatedPill(
            'Test Pill',
            animationLoops: 0,
            padding: customPadding,
            margin: customMargin,
          ),
        ),
      ),
    );

    // Get the container widget
    final container = tester.widget<Container>(
      find.ancestor(
        of: find.text('Test Pill'),
        matching: find.byType(Container),
      ),
    );

    // Verify custom padding is applied
    expect(container.padding, customPadding);

    // Verify custom margin is applied
    expect(container.margin, customMargin);

    // Verify that padding values are correctly set
    expect((container.padding as EdgeInsets).left, 16);
    expect((container.padding as EdgeInsets).top, 8);
    expect((container.padding as EdgeInsets).right, 16);
    expect((container.padding as EdgeInsets).bottom, 8);

    // Verify that margin values are correctly set
    expect((container.margin as EdgeInsets).left, 12);
    expect((container.margin as EdgeInsets).top, 12);
    expect((container.margin as EdgeInsets).right, 12);
    expect((container.margin as EdgeInsets).bottom, 12);
  });

  test('Invalid Animation Loops Test - Verifies assertion error for invalid loops',
      () {
    expect(
      () => AnimatedPill(
        'Test',
        animationLoops: -2,
      ),
      throwsAssertionError,
    );

    // Verify that valid values don't throw
    expect(
      () => AnimatedPill(
        'Test',
        animationLoops: -1,
      ),
      isNot(throwsAssertionError),
    );

    expect(
      () => AnimatedPill(
        'Test',
        animationLoops: 0,
      ),
      isNot(throwsAssertionError),
    );

    expect(
      () => AnimatedPill(
        'Test',
        animationLoops: 1,
      ),
      isNot(throwsAssertionError),
    );
  });
} 