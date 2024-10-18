//import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/cupertino.dart';

import 'package:cust_date_picker/main.dart'; // Update this with your app's main import

void main() {
  testWidgets('Date & Time Picker button test', (WidgetTester tester) async {
    // Build the app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that the "Select Date & Time" button is present.
    expect(find.text('Select Date & Time'), findsOneWidget);

    // Tap the "Select Date & Time" button and trigger a frame.
    await tester.tap(find.text('Select Date & Time'));
    await tester.pump();

    // Verify that the Cupertino picker shows up. This checks for at least one child
    // in the CupertinoPicker (this could be the date picker or the time picker).
    expect(find.byType(CupertinoPicker), findsWidgets);

    // You could optionally simulate interaction with the picker here by selecting
    // a date or time, but WidgetTester can't simulate all gestures.
    
    // Close the dialog by tapping the "Confirm" button (if it exists).
    await tester.tap(find.text('Confirm'));
    await tester.pump();
  });
}
