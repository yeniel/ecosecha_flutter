import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:ecosecha_flutter/presentation/order/bloc/order_bloc.dart';
import 'package:ecosecha_flutter/presentation/utils/extensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    var textTheme = Theme.of(context).textTheme;
    var S = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: BlocBuilder<OrderBloc, OrderState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
                  Text(S.order.capitalizeSentence, style: textTheme.headline4),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(S.order_delivery_address_label, style: textTheme.subtitle1),
                      Text(state.order.deliveryGroup, style: textTheme.subtitle1?.copyWith(color: Colors.green)),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(S.order_delivery_date_label, style: textTheme.subtitle1),
                      Text(state.order.date, style: textTheme.subtitle1?.copyWith(color: Colors.green)),
                    ],
                  ),
                  const Divider(),
                  OrderItemsWidget(items: state.order.items),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderItemsWidget extends StatelessWidget {
  const OrderItemsWidget({Key? key, required this.items}) : super(key: key);

  final List<OrderItem> items;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var item in items) OrderItemWidget(item: item),
        ],
      ),
    );
  }
}

class OrderItemWidget extends StatelessWidget {
  const OrderItemWidget({Key? key, required this.item}) : super(key: key);

  final OrderItem item;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: textTheme.bodyText1),
                  const SizedBox(height: 8),
                  Text('${item.price}€', style: textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  item.quantity.toString() + S.order_quantity_label,
                  style: textTheme.headline5?.copyWith(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.right,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.remove_circle_rounded,
                        color: Colors.orange,
                      ),
                    ),
                    IconButton(
                      onPressed: () => {},
                      icon: const Icon(
                        Icons.add_circle_rounded,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
        const Divider(),
      ],
    );
  }
}
