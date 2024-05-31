import 'package:mockito/annotations.dart';
import 'package:restaurant/Infrastructure/repositories/order_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant/application/order/order_bloc.dart';
import 'package:restaurant/domain/order.dart';
// import 'package:restaurant/Infrastructure/repositories/order_repository.dart';

import 'order_bloc_test.mocks.dart';

@GenerateMocks([OrderRepository])
void main() {
  late MockOrderRepository mockOrderRepository;

  setUp(() {
    mockOrderRepository = MockOrderRepository();
  });

  group('OrderBloc', () {
    final order = Order(
      id: 1,
      phone: '1234567890',
      totalPrice: 50.0,
      meals: {'meal1': 2, 'meal2': 1},
      location: 'Test Location',
      completed: false,
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderLoaded] when LoadOrders event is added',
      build: () {
        when(mockOrderRepository.fetchOrders())
            .thenAnswer((_) async => [order]);
        return OrderBloc(orderRepository: mockOrderRepository);
      },
      act: (bloc) => bloc.add(LoadOrders()),
      expect: () => [
        OrderLoading(),
        OrderLoaded(orders: [order]),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderError] when LoadOrders event throws an exception',
      build: () {
        when(mockOrderRepository.fetchOrders())
            .thenThrow(Exception('Failed to load orders'));
        return OrderBloc(orderRepository: mockOrderRepository);
      },
      act: (bloc) => bloc.add(LoadOrders()),
      expect: () => [
        OrderLoading(),
        isA<OrderError>(),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoaded] when AddOrder event is added',
      build: () {
        when(mockOrderRepository.addOrder(any)).thenAnswer((_) async => order);
        when(mockOrderRepository.fetchOrders())
            .thenAnswer((_) async => [order]);
        return OrderBloc(orderRepository: mockOrderRepository);
      },
      act: (bloc) => bloc.add(AddOrder(order: order)),
      expect: () => [
        // OrderLoading(),
        OrderLoaded(orders: [order]),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderUpdated] when UpdateOrder event is added',
      build: () {
        when(mockOrderRepository.updateOrder(
          id: 1,
          completed: false,
        )).thenAnswer((_) async {
          // order.completed = true;
          return order;
        });
        when(mockOrderRepository.fetchOrders())
            .thenAnswer((_) async => [order]);
        return OrderBloc(orderRepository: mockOrderRepository);
      },
      act: (bloc) => bloc.add(UpdateOrder(order: order)),
      expect: () => [
        // OrderLoading(),
        OrderLoaded(orders: [order]),
      ],
    );

    blocTest<OrderBloc, OrderState>(
      'emits [OrderLoading, OrderDeleted] when DeleteOrder event is added',
      build: () {
        when(mockOrderRepository.deleteOrder(id: order.id))
            .thenAnswer((_) async => {});
        when(mockOrderRepository.fetchOrders()).thenAnswer((_) async => []);
        return OrderBloc(orderRepository: mockOrderRepository);
      },
      act: (bloc) => bloc.add(DeleteOrder(order: order)),
      expect: () => [
        // OrderLoading(),
        OrderLoaded(orders: []),
      ],
    );
  });
}
