import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Infrastructure/repositories/orderedItems.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/domain/meal.dart';

class SelectedOrderPage extends StatefulWidget {
  @override
  _SelectedOrderPageState createState() => _SelectedOrderPageState();
}

class _SelectedOrderPageState extends State<SelectedOrderPage> {
  @override
  void initState() {
    context.read<MealBloc>().add(CartInitalEvent());
    super.initState();
  }

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
        listenWhen: (previous, current) => current is mealActionState,
        buildWhen: (previous, current) => current is! mealActionState,
        builder: (context, state) {
          switch (state.runtimeType) {
            case CartItems:
              final successState = state as CartItems;
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
                          context
                              .read<MealBloc>()
                              .add(CartRemoveEvent(removedMeals: foodItem));
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
