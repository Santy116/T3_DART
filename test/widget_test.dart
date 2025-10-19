import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:t3_santy/main.dart';

void main() {
  testWidgets('BMI Calculator smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const CalculatorBMI());

    // Verify that the app bar title is 'Kalkulator BMI'.
    expect(find.text('Kalkulator BMI'), findsOneWidget);

    // Verify that we have two text fields for berat and tinggi.
    expect(find.byType(TextField), findsNWidgets(2));

    // Verify that there is a button to calculate.
    expect(find.text('Hitung BMI'), findsOneWidget);
  });
}