import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Infrastructure/repositories/orderedItems.dart';
import 'package:restaurant/application/cart/cart_bloc.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/domain/meal.dart';

class SelectedOrderPage extends StatefulWidget {
  @override
  _SelectedOrderPageState createState() => _SelectedOrderPageState();
}

class _SelectedOrderPageState extends State<SelectedOrderPage> {
  @override
  void initState() {
    cartBloc.add(CartInitalEvent());
    super.initState();
  }

  final CartBloc cartBloc = CartBloc();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Orders'),
        backgroundColor: Colors.deepOrange,
      ),
      body: BlocConsumer<MealBloc, MealState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        listenWhen: (previous, current) => current is CartActionState,
        buildWhen: (previous, current) => current is! CartActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartSuccessState:
              final successState = state as CartSuccessState;
              return ListView.builder(
                itemCount: successState.orderedItems.length,
                itemBuilder: (context, index) {
                  final foodItem = successState.orderedItems[index];
                  return Card(
                    margin: EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset(
                        'assets/Pizza.jpg',
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      title: Text(foodItem.name),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Price: \$${foodItem.price.toStringAsFixed(2)}'),
                          // Text('Quantity: ${foodItem.quantity}'),
                          Text('Quantity: 2'),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.clear),
                        onPressed: () {
                          cartBloc.add(CartRemoveEvent(removedMeals: foodItem));
                        },
                      ),
                    ),
                  );
                },
              );
            default:
              return Container(
                child: Center(
                  child: Text('NO Items In the Cart'),
                ),
              );
          }
        },
      ),
    );
  }
}
