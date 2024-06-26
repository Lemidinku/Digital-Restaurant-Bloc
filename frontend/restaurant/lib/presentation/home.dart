import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/Infrastructure/repositories/meal_repository.dart';

import 'package:restaurant/presentation/detail.dart';
import 'package:restaurant/presentation/order_now.dart';
import 'package:restaurant/presentation/widget/rating_stars.dart';
import 'package:restaurant/presentation/widget/built_item_card.dart';
import 'package:restaurant/presentation/widget/meal_col_widget.dart';
import '../application/meal/meal_bloc.dart';
// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Digital Restaurant',
//       theme: ThemeData(
//         primarySwatch: Colors.orange,
//       ),
//       home: const HomePage(),
//     );
//   }
// }

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _RestaurantHomePageState();
}

class _RestaurantHomePageState extends State<HomePage> {
  @override
  void initState() {
    context.read<MealBloc>().add(LoadMeals());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MealBloc, MealState>(
      listenWhen: (previous, current) => current is mealActionState,
      buildWhen: (previous, current) => current is! mealActionState,
      listener: (context, state) {},
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
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 48, vertical: 4),
                    child: SizedBox(
                      height: 40,
                      child: TextField(
                        style: const TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                          hintText: 'Search',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          filled: true,
                          fillColor: const Color.fromARGB(255, 228, 226, 226),
                          contentPadding: const EdgeInsets.all(1),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 160,
                    child: PageView(
                      children: const [
                        FlashOfferCard(
                          title: 'Flash Offer',
                          description:
                              'We are here with the best deserts in Addis.',
                          imagePath: 'assets/kitfo.jpg',
                        ),
                        FlashOfferCard(
                          title: 'Flash Offer',
                          description:
                              'We are here with the best deserts in Addis.',
                          imagePath: 'assets/dorowot.jpg',
                        ),
                        FlashOfferCard(
                          title: 'Flash Offer',
                          description:
                              'We are here with the best deserts in Addis.',
                          imagePath: 'assets/shiro.jpg',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Today\'s Menu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const Text('Today\'s Specials'),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      itemCount: successState.meals.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10.0,
                        crossAxisSpacing: 10.0,
                        childAspectRatio: 0.7,
                      ),
                      itemBuilder: (context, index) {
                        return MealTail(
                          meals: successState.meals[index],
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Center(
                  //   child: ElevatedButton(
                  //     onPressed: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return OrderNowPage();
                  //       }));
                  //     },
                  //     style: ElevatedButton.styleFrom(
                  //       foregroundColor: Colors.white,
                  //       backgroundColor: const Color(0xFFF97350),
                  //       elevation: 0,
                  //       minimumSize: const Size(221, 37),
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(15),
                  //       ),
                  //     ),
                  //     child: const Text('Order Now'),
                  //   ),
                  // ),
                ],
              ),
            );
        }
        return Container();
      },
    );
  }
}
