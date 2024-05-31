import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/application/meal/meal_bloc.dart';
import 'package:restaurant/domain/meal.dart';

class UpdateFoodPage extends StatefulWidget {
  final Meal meal;

  const UpdateFoodPage({super.key, required this.meal});

  @override
  _UpdateFoodPageState createState() => _UpdateFoodPageState();
}

class _UpdateFoodPageState extends State<UpdateFoodPage> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _foodNameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _photoLinkController;

  @override
  void initState() {
    super.initState();
    _foodNameController = TextEditingController(text: widget.meal.name);
    _descriptionController =
        TextEditingController(text: widget.meal.description);
    _priceController =
        TextEditingController(text: widget.meal.price.toString());
    _photoLinkController = TextEditingController(text: widget.meal.imageUrl);
  }

  @override
  void dispose() {
    _foodNameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _photoLinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Update Food Item',
          style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _foodNameController,
                decoration: const InputDecoration(
                  labelText: 'Food Name',
                  labelStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the food name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  labelText: 'Food Description',
                  labelStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the food description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                  labelText: 'Price',
                  labelStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _photoLinkController,
                decoration: const InputDecoration(
                  labelText: 'Photo Link',
                  labelStyle: TextStyle(
                    color: Colors.red,
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter the photo link';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 30),
              ElevatedButton(
                child: const Text('Update'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final updates = {
                      'name': _foodNameController.text,
                      'description': _descriptionController.text,
                      'price': _priceController.text,
                      'imageUrl': _photoLinkController.text,
                    };
                    BlocProvider.of<MealBloc>(context).add(UpdateMeal(
                      id: widget.meal.id.toString(),
                      updates: updates,
                    ));
                    context.read<MealBloc>().add(LoadMeals());
                    Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
