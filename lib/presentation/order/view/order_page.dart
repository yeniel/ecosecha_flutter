import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/basket_product_list/view/basket_product_list_page.dart';
import 'package:ecosecha_flutter/presentation/order/bloc/order_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_image.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_quantity.dart';
import 'package:flutter/material.dart';
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
      create: (_) => OrderBloc(orderRepository: context.read<OrderRepository>())..add(const OrderInitEvent()),
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

    return BaseView(
      title: Header(title: S.order.capitalizeSentence),
      body: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          return Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
    );
  }
}

class OrderProductsWidget extends StatelessWidget {
  const OrderProductsWidget({Key? key, required this.products}) : super(key: key);

  final List<OrderProduct> products;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: products.length,
      itemBuilder: (BuildContext context, int index) => OrderProductWidget(orderProduct: products[index]),
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

    return GestureDetector(
      child: Container(
        height: 80,
        child: Column(
          children: [
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProductImage.small(imageUrl: orderProduct.product.image),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          orderProduct.product.name,
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
                  ProductQuantity(
                    orderProduct: orderProduct,
                    onPressedAdd: () => {},
                    onPressedSubtract: () => {},
                    onPressedDelete: () => {},
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
      onTap: () {
        if (orderProduct.product.type == ProductType.basket) {
          Navigator.of(context).push(BasketProductListPage.route(basket: orderProduct.product));
        }
      },
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
