import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/application/order/order_bloc.dart';
import 'package:restaurant/presentation/addsubmit.dart';

class MockOrderBloc extends MockBloc<OrderEvent, OrderState>
    implements OrderBloc {}

void main() {
  group('SubmitOrderPage Widget Tests', () {
    late MockOrderBloc mockOrderBloc;

    setUp(() {
      mockOrderBloc = MockOrderBloc();
    });

    testWidgets('displays form fields and submit button correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<OrderBloc>(
            create: (context) => mockOrderBloc,
            child: SubmitOrderPage(),
          ),
        ),
      );

      // Check if the phone number field is displayed correctly
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.text('Phone Number'), findsOneWidget);
      expect(find.text('Location'), findsOneWidget);

      // Check if the submit button is displayed correctly
      expect(
          find.widgetWithText(ElevatedButton, 'Submit Order'), findsOneWidget);
    });

    testWidgets('validates empty form fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<OrderBloc>(
            create: (context) => mockOrderBloc,
            child: SubmitOrderPage(),
          ),
        ),
      );

      // Tap the submit button without filling the form
      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit Order'));
      await tester.pump();

      // Check for validation messages
      expect(find.text('Please enter your phone number'), findsOneWidget);
      expect(find.text('Please enter your location'), findsOneWidget);
    });

    testWidgets('submits order when form is filled correctly',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<OrderBloc>(
            create: (context) => mockOrderBloc,
            child: SubmitOrderPage(),
          ),
        ),
      );

      // Enter valid data into the form fields
      await tester.enterText(find.byType(TextFormField).at(0), '1234567890');
      await tester.enterText(find.byType(TextFormField).at(1), 'Test Location');

      // Tap the submit button
      await tester.tap(find.widgetWithText(ElevatedButton, 'Submit Order'));
      await tester.pump();

      // Verify that no validation messages are shown
      expect(find.text('Please enter your phone number'), findsNothing);
      expect(find.text('Please enter your location'), findsNothing);

      // Check for the snackbar message indicating successful submission
      expect(
          find.text(
              'Order submitted successfully! Phone: 1234567890, Location: Test Location'),
          findsOneWidget);
    });
  });
}
