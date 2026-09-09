import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:smartpos_client/features/settings/presentation/widgets/create_cashier_dialog.dart';

void main() {
  group('CreateCashierDialog', () {
    Widget buildSubject() => MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => ElevatedButton(
            onPressed: () {
              showDialog<CreateCashierResult>(
                context: context,
                builder: (_) => const CreateCashierDialog(),
              );
            },
            child: const Text('Open'),
          ),
        ),
      ),
    );

    testWidgets('fields retain focus while typing a complete username', (
      tester,
    ) async {
      await tester.pumpWidget(buildSubject());
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      final usernameField = find.byKey(
        const ValueKey('createCashierUsernameField'),
      );
      await tester.tap(usernameField);
      await tester.pump();

      for (final value in ['c', 'ca', 'cas', 'cash', 'cashier']) {
        await tester.enterText(usernameField, value);
        await tester.pump();
        expect(tester.testTextInput.isVisible, isTrue);
        expect(FocusManager.instance.primaryFocus?.hasFocus, isTrue);
      }

      expect(find.text('cashier'), findsOneWidget);
    });

    testWidgets('returns result when form is submitted', (tester) async {
      CreateCashierResult? result;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () async {
                  result = await showDialog<CreateCashierResult>(
                    context: context,
                    builder: (_) => const CreateCashierDialog(),
                  );
                },
                child: const Text('Open'),
              ),
            ),
          ),
        ),
      );

      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();

      await tester.enterText(
        find.byKey(const ValueKey('createCashierUsernameField')),
        'cashier01',
      );
      await tester.enterText(
        find.byKey(const ValueKey('createCashierFullNameField')),
        'Chala Kebede',
      );
      await tester.enterText(
        find.byKey(const ValueKey('createCashierPasswordField')),
        '1234',
      );
      await tester.enterText(
        find.byKey(const ValueKey('createCashierConfirmPasswordField')),
        '1234',
      );
      await tester.pump();

      await tester.tap(find.byKey(const ValueKey('createCashierSubmitButton')));
      await tester.pumpAndSettle();

      expect(result, isNotNull);
      expect(result!.username, 'cashier01');
      expect(result!.fullName, 'Chala Kebede');
      expect(result!.password, '1234');
    });
  });
}
