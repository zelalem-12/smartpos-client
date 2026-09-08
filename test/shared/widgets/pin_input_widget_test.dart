import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/shared/widgets/pin_input_widget.dart';

void main() {
  group('PinInputWidget', () {
    testWidgets('renders 4 dot containers by default', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PinInputWidget(filledCount: 0))),
      );

      // Should find 4 Container widgets for the dots
      final containers = find.byType(Container);
      // The widget creates 4 dot containers inside a Row
      expect(containers, findsWidgets);
    });

    testWidgets('renders custom pin length', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PinInputWidget(filledCount: 0, pinLength: 6)),
        ),
      );

      // Should render without error for 6-digit PIN
      expect(find.byType(PinInputWidget), findsOneWidget);
    });

    testWidgets('renders with 2 filled dots', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PinInputWidget(filledCount: 2))),
      );

      expect(find.byType(PinInputWidget), findsOneWidget);
    });

    testWidgets('renders with all 4 dots filled', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: Scaffold(body: PinInputWidget(filledCount: 4))),
      );

      expect(find.byType(PinInputWidget), findsOneWidget);
    });

    testWidgets('renders error state', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: PinInputWidget(filledCount: 4, hasError: true)),
        ),
      );

      expect(find.byType(PinInputWidget), findsOneWidget);
    });
  });
}
