import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/application/cart/cart_bloc.dart';
import 'package:restaurant/domain/meal.dart';
import 'package:restaurant/Infrastructure/repositories/meal_repository.dart';

import 'cart_bloc_test.mocks.dart';

@GenerateMocks([MealRepository])
void main() {
  group('CartBloc', () {
    late CartBloc cartBloc;
    late MockMealRepository mockMealRepository;

    setUp(() {
      mockMealRepository = MockMealRepository();
      cartBloc = CartBloc();
    });

    tearDown(() {
      cartBloc.close();
    });

    test('initial state is CartInitial', () {
      expect(cartBloc.state, isA<CartInitial>());
    });

    // Create mock meals
    final mockMeals = [
      Meal(
        id: 1,
        name: 'Meal 1',
        description: 'Description 1',
        price: 10.0,
        imageUrl: 'image_url_1',
        types: ['type1'],
        allergy: 'allergy1',
        fasting: false,
        origin: 'origin1',
      ),
      Meal(
        id: 2,
        name: 'Meal 2',
        description: 'Description 2',
        price: 20.0,
        imageUrl: 'image_url_2',
        types: ['type2'],
        allergy: 'allergy2',
        fasting: true,
        origin: 'origin2',
      ),
    ];

    blocTest<CartBloc, CartState>(
      'emits [isA<CartLoaddingState>(), isA<CartSuccessState>()] when CartInitialEvent is added',
      build: () => cartBloc,
      act: (bloc) {
        when(mockMealRepository.fetchMeals())
            .thenAnswer((_) async => mockMeals);
        bloc.add(CartInitalEvent());
      },
      expect: () => [
        isA<CartLoaddingState>(),
        // isA<CartSuccessState>(),
      ],
      // verify: (_) {
      //   verify(mockMealRepository.fetchMeals()).called(1);
      // },
    );
  });
}
