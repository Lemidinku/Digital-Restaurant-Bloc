// Mocks generated by Mockito 5.4.4 from annotations
// in restaurant/test/unit_test/order_bloc_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i4;
import 'package:restaurant/domain/order.dart' as _i2;
import 'package:restaurant/Infrastructure/repositories/order_repository.dart'
    as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeOrder_0 extends _i1.SmartFake implements _i2.Order {
  _FakeOrder_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [OrderRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockOrderRepository extends _i1.Mock implements _i3.OrderRepository {
  MockOrderRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  String get baseUrl => (super.noSuchMethod(
        Invocation.getter(#baseUrl),
        returnValue: _i4.dummyValue<String>(
          this,
          Invocation.getter(#baseUrl),
        ),
      ) as String);

  @override
  _i5.Future<List<_i2.Order>> fetchOrders() => (super.noSuchMethod(
        Invocation.method(
          #fetchOrders,
          [],
        ),
        returnValue: _i5.Future<List<_i2.Order>>.value(<_i2.Order>[]),
      ) as _i5.Future<List<_i2.Order>>);

  @override
  _i5.Future<_i2.Order> addOrder(dynamic order) => (super.noSuchMethod(
        Invocation.method(
          #addOrder,
          [order],
        ),
        returnValue: _i5.Future<_i2.Order>.value(_FakeOrder_0(
          this,
          Invocation.method(
            #addOrder,
            [order],
          ),
        )),
      ) as _i5.Future<_i2.Order>);

  @override
  _i5.Future<_i2.Order> updateOrder({
    required int? id,
    required bool? completed,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateOrder,
          [],
          {
            #id: id,
            #completed: completed,
          },
        ),
        returnValue: _i5.Future<_i2.Order>.value(_FakeOrder_0(
          this,
          Invocation.method(
            #updateOrder,
            [],
            {
              #id: id,
              #completed: completed,
            },
          ),
        )),
      ) as _i5.Future<_i2.Order>);

  @override
  _i5.Future<void> deleteOrder({required int? id}) => (super.noSuchMethod(
        Invocation.method(
          #deleteOrder,
          [],
          {#id: id},
        ),
        returnValue: _i5.Future<void>.value(),
        returnValueForMissingStub: _i5.Future<void>.value(),
      ) as _i5.Future<void>);
}
