import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/application/meal/meal_bloc.dart'; // Adjust the import path accordingly
import 'package:restaurant/domain/meal.dart'; // Adjust the import path accordingly
import 'package:restaurant/Infrastructure/repositories/meal_repository.dart'; // Adjust the import path accordingly
import 'package:mockito/annotations.dart'; // Import mockito annotations

// Import the generated mock class
import 'meal_bloc_test.mocks.dart';

@GenerateMocks([MealRepository]) // Generate mock class for MealRepository
void main() {
  late MealRepository mealRepository;

  setUp(() {
    mealRepository = MockMealRepository();
  });

  group('MealBloc', () {
    test('initial state is MealInitial', () {
      expect(MealBloc(mealRepository: mealRepository).state,
          equals(MealInitial()));
    });

    blocTest<MealBloc, MealState>(
      'emits [MealLoading, MealLoaded] when LoadMeals event is added',
      build: () {
        when(mealRepository.fetchMeals()).thenAnswer((_) async => []);
        return MealBloc(mealRepository: mealRepository);
      },
      act: (bloc) => bloc.add(LoadMeals()),
      expect: () => [
        MealLoading(),
        MealLoaded(meals: []),
      ],
    );

    blocTest<MealBloc, MealState>(
      'emits [MealLoading, MealAdded] when AddMeal event is added',
      build: () => MealBloc(mealRepository: mealRepository),
      act: (bloc) {
        final meal = Meal(
          id: 1,
          name: 'Test Meal',
          description: 'Test Description',
          price: 10.0,
          imageUrl: 'test.jpg',
          types: ['test'],
          allergy: 'test',
          fasting: false,
          origin: 'test',
        );
        when(mealRepository.addMeal(meal))
            .thenAnswer((_) async => meal); // Return the same instance
        bloc.add(AddMeal(meal: meal));
      },
      expect: () {
        return [
          isA<MealLoading>(), // Matcher for MealLoading state
          isA<MealAdded>(),
        ];
      },
    );

    blocTest<MealBloc, MealState>(
      'emits [MealLoading, MealDeleted] when DeleteMeal event is added',
      build: () => MealBloc(mealRepository: mealRepository),
      act: (bloc) {
        final mealId = '1';
        when(mealRepository.deleteMeal(mealId)).thenAnswer((_) async => {});
        bloc.add(DeleteMeal(id: mealId));
      },
      expect: () {
        return [
          isA<MealLoading>(), // Matcher for MealLoading state
          isA<MealDeleted>(), // Matcher for MealDeleted state
        ];
      },
    );

    blocTest<MealBloc, MealState>(
      'emits [MealLoading, MealUpdated] when UpdateMeal event is added',
      build: () => MealBloc(mealRepository: mealRepository),
      act: (bloc) {
        final mealId = '1';
        final updates = {
          'id': 1,
          'name': 'Test Meal',
          'description': 'Test Description',
          'price': 10.0,
          'imageUrl': 'test.jpg',
          'types': ['test'],
          'allergy': 'test',
          'fasting': false,
          'origin': 'test',
        };
        final updatedMeal = Meal.fromJson({
          ...updates,
          // 'id': mealId
        }); // Assuming id is required in the constructor
        when(mealRepository.updateMeal(mealId, updates))
            .thenAnswer((_) async => updatedMeal);
        bloc.add(UpdateMeal(id: mealId, updates: updates));
      },
      expect: () {
        return [
          isA<MealLoading>(), // Matcher for MealLoading state
          isA<MealAdded>(), // Matcher for MealAdded state
        ];
      },
    );
  });
}
