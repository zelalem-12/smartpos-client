import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/shared/widgets/app_button.dart';

void main() {
  group('AppButton', () {
    testWidgets('renders label text', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppButton(label: 'Activate')),
        ),
      );

      expect(find.text('Activate'), findsOneWidget);
    });

    testWidgets('calls onPressed when tapped', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(label: 'Activate', onPressed: () => tapped = true),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      expect(tapped, isTrue);
    });

    testWidgets('does not call onPressed when disabled (null callback)', (
      tester,
    ) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppButton(label: 'Disabled')),
        ),
      );

      // Button should render but have no callback
      final button = tester.widget<ElevatedButton>(find.byType(ElevatedButton));
      expect(button.onPressed, isNull);
    });

    testWidgets('shows CircularProgressIndicator when loading', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: AppButton(label: 'Loading', isLoading: true)),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Loading'), findsNothing);
    });

    testWidgets('shows icon when provided', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Print',
              icon: Icons.print,
              onPressed: () {},
            ),
          ),
        ),
      );

      expect(find.byIcon(Icons.print), findsOneWidget);
      expect(find.text('Print'), findsOneWidget);
    });

    testWidgets('does not call onPressed when loading', (tester) async {
      var tapped = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AppButton(
              label: 'Loading',
              isLoading: true,
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );

      await tester.tap(find.byType(AppButton));
      expect(tapped, isFalse);
    });
  });
}
