import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant/presentation/admin/addfood.dart';
import 'package:restaurant/presentation/admin/component/dashbordhome.dart';
import 'package:restaurant/presentation/admin/orderlist.dart';
import 'package:restaurant/presentation/admin/dashbord.dart';

void main() {
  group('AdminHome Widget Tests', () {
    testWidgets('renders correctly and navigates through drawer items',
        (WidgetTester tester) async {
      await tester.pumpWidget(
          const MaterialApp(home: AdminHome(title: 'Digital restaurant')));

      // Verify that the initial screen is the Dashboard
      expect(find.text('Digital restaurant'), findsOneWidget);
      expect(find.byType(AddedFoodsPage), findsOneWidget);

      // Open the drawer
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Tap on "Add Food" list tile
      await tester.tap(find.text('Add Food'));
      await tester.pumpAndSettle();

      // Verify that the AddFoodPage is displayed
      expect(find.byType(AddFoodPage), findsOneWidget);

      // Open the drawer again
      await tester.tap(find.byTooltip('Open navigation menu'));
      await tester.pumpAndSettle();

      // Tap on "Order List" list tile
      await tester.tap(find.text('Order List'));
      await tester.pumpAndSettle();

      // Verify that the OrderList is displayed
      expect(find.byType(OrderList), findsOneWidget);
    });
  });
}
