import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/presentation/order/bloc/order_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderPage extends StatelessWidget {
  const OrderPage();

  static Route route() {
    return MaterialPageRoute(builder: (_) => const OrderPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderBloc(repository: context.read<Repository>())..add(const OrderRequestedEvent()),
      child: const OrderView(),
    );
  }
}

class OrderView extends StatelessWidget {
  const OrderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        return Column(
          children: [
            Text(state.order.date),
            if (state.order.items.isNotEmpty)
              Text(state.order.items.first.name),
          ],
        );
      },
    );
  }
}
