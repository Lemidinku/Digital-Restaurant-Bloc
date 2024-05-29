// ignore_for_file: public_member_api_docs, sort_constructors_first
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
  final Meal meal;

  UpdateMeal({required this.meal});

  @override
  List<Object> get props => [meal];
}

class DeleteMeal extends MealEvent {
  final int mealId;

  DeleteMeal({required this.mealId});

  @override
  List<Object> get props => [mealId];
}

class CartInitalEvent extends MealEvent {}

class CartRemoveEvent extends MealEvent {
  final Meal removedMeals;
  CartRemoveEvent({
    required this.removedMeals,
  });
}

class OrderSelectedButtonEvent extends MealEvent {
  final Meal clickedMeals;

  OrderSelectedButtonEvent({required this.clickedMeals});
}

class OrderSelectedOrderButtonEvent extends MealEvent {}
