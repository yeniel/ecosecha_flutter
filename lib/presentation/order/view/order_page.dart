import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/basket_product_list/view/basket_product_list_page.dart';
import 'package:ecosecha_flutter/presentation/order/bloc/order_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/dialog_builder.dart';
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
      create: (_) => OrderBloc(
        orderRepository: context.read<OrderRepository>(),
        userRepository: context.read<UserRepository>(),
        companyRepository: context.read<CompanyRepository>(),
        analyticsManager: context.read<AnalyticsManager>(),
      )..add(const OrderInitEvent()),
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
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state.pageStatus == OrderPageStatus.loading) {
            DialogBuilder(context).showLoadingIndicator(context: context, text: S.loading_indicator);
          } else if (state.pageStatus == OrderPageStatus.loaded) {
            DialogBuilder(context).hideOpenDialog();
          } else if (state.pageStatus == OrderPageStatus.confirmError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(content: Text(S.confirm_order_error)),
              );
          }
        },
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
                Expanded(
                  child: OrderProductsWidget(
                    products: state.order.products,
                    minimumAmount: state.minimumAmount,
                  ),
                ),
                TotalAmount(totalAmount: state.totalAmount),
                OrderActionButtons(state: state),
              ],
            ),
          );
        },
      ),
    );
  }
}

class OrderProductsWidget extends StatelessWidget {
  const OrderProductsWidget({Key? key, required this.products, required this.minimumAmount}) : super(key: key);

  final List<OrderProduct> products;
  final int minimumAmount;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    if (products.isEmpty) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.remove_shopping_cart_rounded, size: 64),
          const SizedBox(height: 8),
          Text(
            S.minimum_amount(minimumAmount),
            style: textTheme.headline6,
            textAlign: TextAlign.center,
          ),
        ],
      );
    }
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
    var bloc = context.read<OrderBloc>();

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
                    onPressedAdd: () => bloc.add(AddProductEvent(orderProduct: orderProduct)),
                    onPressedSubtract: () => bloc.add(SubtractProductEvent(orderProduct: orderProduct)),
                    onPressedDelete: () => bloc.add(DeleteProductEvent(orderProduct: orderProduct)),
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

class TotalAmount extends StatelessWidget {
  const TotalAmount({Key? key, required this.totalAmount}) : super(key: key);

  final double totalAmount;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var S = AppLocalizations.of(context)!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(S.total.capitalizeSentence, style: textTheme.headline5?.copyWith(fontWeight: FontWeight.bold)),
        const Spacer(),
        Text('${totalAmount.toString()} €', style: textTheme.headline5?.copyWith(fontWeight: FontWeight.bold))
      ],
    );
  }
}

class OrderActionButtons extends StatelessWidget {
  const OrderActionButtons({Key? key, required this.state}) : super(key: key);

  final OrderState state;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var bloc = context.read<OrderBloc>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        OutlinedButton(
          onPressed: state.canConfirm ? () => bloc.add(const CancelOrderEvent()) : null,
          child: Text(S.cancel_order.capitalizeSentence),
        ),
        ElevatedButton(
          onPressed: state.canCancel ? () => bloc.add(const ConfirmOrderEvent()) : null,
          child: Text(S.confirm.capitalizeSentence),
        ),
        if (state.error.isNotEmpty)
          WarningMessage(error: state.error),
      ],
    );
  }
}

class WarningMessage extends StatelessWidget {
  const WarningMessage({Key? key, required this.error}) : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    return Container(
      decoration: BoxDecoration(
        color: Colors.amberAccent,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline_rounded),
            ),
            Expanded(child: Text(error, style: textTheme.subtitle1)),
          ],
        ),
      ),
    );
  }
}

