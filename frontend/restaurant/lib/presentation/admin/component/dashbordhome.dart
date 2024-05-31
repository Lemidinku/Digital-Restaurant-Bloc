import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/domain/meal.dart';
import 'package:restaurant/presentation/admin/component/editMealform.dart';

class AddedFoodsPage extends StatefulWidget {
  @override
  State<AddedFoodsPage> createState() => _AddedFoodsPageState();
}

class _AddedFoodsPageState extends State<AddedFoodsPage> {
  void initState() {
    context.read<MealBloc>().add(LoadMeals());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealBloc, MealState>(
      listenWhen: (previous, current) => current is mealActionState,
      buildWhen: (previous, current) => current is! mealActionState,
      listener: (context, state) {
        if (state is MealSelectedButtonActionState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text('Item selected')));
        }
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case MealLoading:
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          case MealLoaded:
            final successState = state as MealLoaded;
            return Scaffold(
              appBar: AppBar(
                title: const Text(
                  'Added Foods',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
              ),
              body: GridView.count(
                crossAxisCount: 2,
                padding: const EdgeInsets.all(16.0),
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                children: successState.meals.map((food) {
                  return AddedFoodCard(
                    addedFood: food,
                  );
                }).toList(),
              ),
            );
          default:
            return Container();
        }
      },
    );
  }
}

class AddedFoodCard extends StatelessWidget {
  final Meal addedFood;

  const AddedFoodCard({super.key, required this.addedFood});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 400.0,
        child: Card(
          color: Colors.white,
          elevation: 4.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 30.0,
                decoration: const BoxDecoration(
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16.0)),
                ),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(16.0)),
                  child: Image.asset(
                    'assets/Pizza.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 2.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      addedFood.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Price: \$${addedFood.price}',
                      style: const TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return UpdateFoodPage(
                            meal: addedFood,
                          );
                        }));
                      },
                      child: const Text('Edit'),
                    ),
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Delete Food Item'),
                              content: const Text(
                                  'Are you sure you want to delete this item?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    context.read<MealBloc>().add(DeleteMeal(
                                        id: addedFood.id.toString()));
                                    context.read<MealBloc>().add(LoadMeals());
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Delete'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
