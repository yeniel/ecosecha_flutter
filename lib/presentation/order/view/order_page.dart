import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:ecosecha_flutter/presentation/order/bloc/order_bloc.dart';
import 'package:ecosecha_flutter/presentation/utils/extensions.dart';
import 'package:ecosecha_flutter/presentation/widgets/elevated_icon_button.dart';
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
                  const SizedBox(height: 8),
                  const Divider(),
                  Expanded(child: OrderProductsWidget(products: state.order.products)),
                  TotalPrice(totalPrice: state.totalPrice),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class OrderProductsWidget extends StatelessWidget {
  const OrderProductsWidget({Key? key, required this.products}) : super(key: key);

  final List<OrderProduct> products;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (var product in products) OrderProductWidget(orderProduct: product),
        ],
      ),
    );
  }
}

class OrderProductWidget extends StatelessWidget {
  const OrderProductWidget({Key? key, required this.orderProduct}) : super(key: key);

  final OrderProduct orderProduct;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return Container(
      height: 80,
      child: Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 64,
                  child: CachedNetworkImage(
                    imageUrl: orderProduct.product.image,
                    placeholder: (context, url) => const CircularProgressIndicator(),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        orderProduct.product.description,
                        style: textTheme.bodyText1,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          Text(
                            '${orderProduct.product.price}€',
                            style: textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          Text(S.order_price_per_unit_label, style: textTheme.bodyText1),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      orderProduct.quantity.toString() + S.order_quantity_label,
                      style: textTheme.headline6?.copyWith(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.right,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          width: 56,
                          height: 32,
                          child: ElevatedIconButton(
                            onPressed: () => {},
                            icon: Icons.remove,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          width: 56,
                          height: 32,
                          child: ElevatedIconButton(
                            onPressed: () => {},
                            icon: Icons.add,
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

class TotalPrice extends StatelessWidget {
  const TotalPrice({Key? key, required this.totalPrice}) : super(key: key);

  final double totalPrice;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var S = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(S.total.capitalizeSentence, style: textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
        const Spacer(),
        Text('${totalPrice.toString()} €', style: textTheme.headline5?.copyWith(fontWeight: FontWeight.bold))
      ],
    );
  }
}
