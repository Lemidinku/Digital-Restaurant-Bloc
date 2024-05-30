import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/presentation/admin/addfood.dart';
import 'meal_bloc_test.mocks.dart'; // Import the generated mock class

void main() {
  group('Addpage Widget Tests', () {
    late MockMealBloc mealBloc;

    setUp(() {
      mealBloc = MockMealBloc();
    });

    testWidgets('renders correctly', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<MealBloc>.value(
          value: mealBloc,
          child: const Addpage(),
        ),
      );

      // Verify that the Add Food Item form is displayed
      expect(find.text('Add Food Item'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(5));
    });

    testWidgets('validates form fields', (WidgetTester tester) async {
      await tester.pumpWidget(
        BlocProvider<MealBloc>.value(
          value: mealBloc,
          child: const Addpage(),
        ),
      );

      // Tap the submit button without entering any data

      expect(find.text('Food Name'), findsOneWidget);
      expect(find.text('Food Description'), findsOneWidget);
      expect(find.text('Price'), findsOneWidget);
      expect(find.text('Photo Link'), findsOneWidget);
      expect(find.text('Origin'), findsOneWidget);
      // Verify that validation errors are displayed
    });
  });
}
