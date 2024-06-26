import 'package:flutter/material.dart';

import 'package:restaurant/domain/meal.dart';

import 'package:restaurant/presentation/detail.dart';
import 'package:restaurant/presentation/widget/rating_stars.dart';

class MealTail extends StatelessWidget {
  final Meal meals;

  const MealTail({
    Key? key,
    required this.meals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      color: const Color.fromARGB(255, 234, 228, 228),
      elevation: 0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            child: SizedBox(
              height: 120,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(15),
                        bottom: Radius.circular(15),
                      ),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => FoodDetailPage(
                              imagePath: 'assets/Pizza.jpg',
                              price: meals.price.toString(),
                              origin: meals.origin,
                              rating: '3',
                              type: meals.types[0],
                              title: meals.name,
                              kind: meals.allergy,
                            ),
                          ));
                        },
                        child: Image.asset(
                          'assets/Pizza.jpg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      meals.name,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      meals.price.toString(),
                      style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const RatingStars(
                  rating: 3,
                  size: 15.0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
