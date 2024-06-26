part of 'meal_bloc.dart';

abstract class MealEvent extends Equatable {
  const MealEvent();

  @override
  List<Object> get props => [];
}

class LoadMeals extends MealEvent {}

class AddMeal extends MealEvent {
  final Meal meal;

  AddMeal({required this.meal});

  @override
  List<Object> get props => [meal];
}

class UpdateMeal extends MealEvent {
  final String id;
  final Map<String, dynamic> updates;

  UpdateMeal({required this.id, required this.updates});

  @override
  List<Object> get props => [id, updates];
}

class DeleteMeal extends MealEvent {
  final String id;

  DeleteMeal({required this.id});

  @override
  List<Object> get props => [id];
}

class OrderSelectedButtonEvent extends MealEvent {
  final Meal clickedMeals;
  final int quantity;

  OrderSelectedButtonEvent(
      {required this.clickedMeals, required this.quantity});
}

class OrderSelectedOrderButtonEvent extends MealEvent {}
