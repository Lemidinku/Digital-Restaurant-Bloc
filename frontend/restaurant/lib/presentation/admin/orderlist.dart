import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant/application/order/order_bloc.dart';
import 'package:restaurant/domain/order.dart';

void main() {
  runApp(const OrdersListPage());
}

class OrdersListPage extends StatefulWidget {
  const OrdersListPage({Key? key}) : super(key: key);

  @override
  State<OrdersListPage> createState() => _OrdersListPageState();
}

class _OrdersListPageState extends State<OrdersListPage> {
  void initState() {
    context.read<OrderBloc>().add(LoadOrders());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {},
      builder: (context, state) {
        switch (state.runtimeType) {
          case OrderError:
            final error = state as OrderError;
            return Center(child: Text(error.message));
          case OrderLoaded:
            final SuccessState = state as OrderLoaded;
            print(state.orders[0].meals);
            return Scaffold(
              appBar: AppBar(
                title: const Text(
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

  const OrderCard({super.key, required this.order});

  @override
  _OrderCardState createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      elevation: 5,
      shadowColor: Colors.grey,
      child: ListTile(
        title: Text(
          'Order: ${widget.order.id}',
          style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.deepOrange),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Food: '),
                ...widget.order.meals.entries.map(
                  (entry) => Text(
                    '${entry.key} ${entry.value}${entry == widget.order.meals.entries.last ? '' : ', '}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Text('Price: ${widget.order.totalPrice}'),
            const Text('Date: 2025/5/2'),
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
            setState(() {
              widget.order.isCompleted = !widget.order.completed;
              context.read<OrderBloc>().add(UpdateOrder(
                  id: widget.order.id, completed: !widget.order.completed));
            });
          },
        ),
      ),
    );
  }
}
