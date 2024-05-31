import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/presentation/admin/orderlist.dart';

void main() {
  testWidgets('OrderList renders correctly', (WidgetTester tester) async {
    // Build the OrderList widget.
    await tester.pumpWidget(const OrdersListPage());

    // Verify the app bar title.
    expect(find.text('Orders'), findsOneWidget);
  });

  testWidgets('OrderList displays the list of orders',
      (WidgetTester tester) async {
    // Build the OrderList widget.
    await tester.pumpWidget(const OrdersListPage());

    // Verify the number of OrderCard widgets.

    // Verify some order details.
    expect(find.text('Order: 1'), findsOneWidget);
    expect(find.text('Pizza 3'), findsOneWidget);

    expect(find.text('Order: 2'), findsOneWidget);
    expect(find.text('Fries 1'), findsOneWidget);
  });

  testWidgets('OrderCard completion button toggles state',
      (WidgetTester tester) async {
    // Build the OrderList widget.
    await tester.pumpWidget(const OrdersListPage());

    // Verify initial state of the first order's completion button.
    var firstOrderCompleteButton = find.descendant(
      of: find.byType(OrderCard).first,
      matching: find.byIcon(Icons.pending),
    );
    expect(firstOrderCompleteButton, findsOneWidget);

    // Tap the completion button to mark the order as completed.
    await tester.tap(firstOrderCompleteButton);
    await tester.pump();

    // Verify the completion button state has changed.
    firstOrderCompleteButton = find.descendant(
      of: find.byType(OrderCard).first,
      matching: find.byIcon(Icons.check),
    );
    expect(firstOrderCompleteButton, findsOneWidget);
  });
}
