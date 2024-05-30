import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
// import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/presentation/home.dart'; // Adjust the import to match your file structure

// Mock MealBloc
class MockMealBloc extends MockBloc<MealEvent, MealState> implements MealBloc {}

void main() {
  group('HomePage Widget Tests', () {
    late MockMealBloc mockMealBloc;

    setUp(() {
      mockMealBloc = MockMealBloc();
    });

    tearDown(() {
      mockMealBloc.close();
    });

    testWidgets('displays CircularProgressIndicator when state is MealLoading',
        (WidgetTester tester) async {
      whenListen(
        mockMealBloc,
        Stream.fromIterable([MealLoading()]),
        initialState: MealLoading(),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<MealBloc>.value(
            value: mockMealBloc,
            child: const HomePage(),
          ),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
  });
}
