import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:restaurant/Infrastructure/repositories/order_repository.dart';
import 'package:restaurant/application/cart/cart_bloc.dart';
import 'package:restaurant/application/order/order_bloc.dart';
import 'package:restaurant/domain/meal.dart';
import 'package:restaurant/presentation/addsubmit.dart';
import 'package:restaurant/presentation/admin/component/editMealform.dart';
import 'package:restaurant/presentation/admin/dashbord.dart';
import 'package:restaurant/presentation/admin/orderlist.dart';
import 'package:restaurant/presentation/bottom_nav.dart';
import 'package:restaurant/presentation/login_page.dart';
import 'package:restaurant/presentation/signup_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'application/auth/auth_bloc.dart';
import 'application/meal/meal_bloc.dart';
import './Infrastructure/repositories/auth_repository.dart';
import './Infrastructure/repositories/meal_repository.dart';
import './presentation/selectedorder.dart';

final _router = GoRouter(initialLocation: "/signup", routes: [
  GoRoute(
    name: "signup",
    path: '/signup',
    builder: (context, state) => SignupPage(),
  ),
  GoRoute(
    name: "login",
    path: '/login',
    builder: (context, state) => LoginPage(),
  ),
  GoRoute(
    name: "entry",
    path: '/entry',
    builder: (context, state) => BottomNav(),
  ),
  GoRoute(
      name: 'selected',
      path: '/selected',
      builder: (context, state) => SelectedOrderPage()),
  GoRoute(
      name: 'submitorder',
      path: '/submitorder',
      builder: (context, state) => SubmitOrderPage()),
  GoRoute(
    name: 'admin',
    path: '/admin',
    builder: (context, state) => AdminHome(title: 'Digital resturant'),
  )
]);

void main() {
  final AuthRepository authRepository =
      AuthRepository(baseUrl: 'http://10.0.2.2:5000');
  final MealRepository mealRepository =
      MealRepository(baseUrl: 'http://10.0.2.2:5000');
  final OrderRepository orderRepository =
      OrderRepository(baseUrl: 'http://10.0.2.2:5000');
  runApp(MyApp(
    authRepository: authRepository,
    mealRepository: mealRepository,
    orderRepository: orderRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final MealRepository mealRepository;
  final OrderRepository orderRepository;

  MyApp(
      {required this.authRepository,
      required this.mealRepository,
      required this.orderRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthBloc(authRepository: authRepository),
        ),
        BlocProvider(
          create: (context) =>
              MealBloc(mealRepository: mealRepository)..add(LoadMeals()),
        ),
        BlocProvider(
            create: (context) =>
                OrderBloc(orderRepository: orderRepository)..add(LoadOrders())),
        BlocProvider(create: (context) => CartBloc()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(239, 108, 0, 1)),
          useMaterial3: true,
        ),
        routerConfig: _router,
        // home: LoginPage(),
        // routes: {
        //   '/entry': (context) => BottomNav(),
        //   '/selected': (context) => SelectedOrderPage(),
        //   '/login': (context) => LoginPage(),
        //   '/signup': (context) => SignupPage(),
        // //   '/admin': (context) => AdminHome(title: 'Digital resturant'),
        // },
      ),
    );
  }
}
