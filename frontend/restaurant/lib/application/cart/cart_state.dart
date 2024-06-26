part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

abstract class CartActionState extends CartState {}

final class CartInitial extends CartState {}

class CartLoaddingState extends CartState {}

class CartSuccessState extends CartState {
  final Map<Meal, int> orders;
  CartSuccessState({
    required this.orders,
  });
}
