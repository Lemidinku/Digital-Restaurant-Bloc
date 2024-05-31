import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/application/cart/cart_bloc.dart';
import 'package:restaurant/application/order/order_bloc.dart';
import 'package:restaurant/domain/order.dart';

void main() {
  runApp(const OrdersListPage());
}

// class OrderList extends StatelessWidget {
//   const OrderList({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Project',
//       theme: ThemeData(primarySwatch: Colors.deepOrange),
//       home: OrdersListPage(),
//     );
//   }
// }

class OrdersListPage extends StatefulWidget {
  const OrdersListPage({Key? key}) : super(key: key);

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  @override
  Widget build(BuildContext context) {
    // Sample list of orders

    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        switch (state.runtimeType) {
          case OrderLoaded:
            final SuccessState = state as OrderLoaded;
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'OrdersListPage',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepOrange),
                ),
              ),
              body: ListView.builder(
                itemCount: SuccessState.orders.length,
                itemBuilder: (context, index) {
                  return OrderCard(order: SuccessState.orders[index]);
                },
              ),
            );
          default:
            return SizedBox();
        }
      },
    );
  }
}

class OrderCard extends StatefulWidget {
  final Order order;

  const OrderCard({Key? key, required this.order}) : super(key: key);

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),

      elevation: 5, // Add elevation for box shadow
      shadowColor: Colors.grey,
      child: ListTile(
        title: Text(
          'Order: ${widget.order.id}',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('Food: '),
                for (var i = 0; i < widget.order.meals.length; i++)
                  Text(
                    '${widget.order.meals[i]} ${widget.order.meals[i]}${i == widget.order.meals.length - 1 ? '' : ', '}',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
              ],
            ),
            Text('Price: ${widget.order.totalPrice}'),
            Text('Date: 2025/5/2'),
          ],
        ),
        trailing: IconButton(
          icon: Icon(
            widget.order.completed ? Icons.check : Icons.pending,
            color:
                widget.order.completed ? Colors.lightBlue : Colors.deepOrange,
            size: 40.0,
          ),
          onPressed: () {
            // setState(() {
            //   widget.order.isCompleted = !widget.order.completed;
            // });
          },
        ),
      ),
    );
  }
}
