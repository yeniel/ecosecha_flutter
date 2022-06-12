import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/widgets/elevated_icon_button.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_quantity/bloc/product_quantity_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    Key? key,
    required this.orderProduct,
  }) : super(key: key);

  final OrderProduct orderProduct;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductQuantityBloc(orderProduct: orderProduct, orderRepository: context.read<OrderRepository>()),
      child: const ProductQuantityView(),
    );
  }
}

class ProductQuantityView extends StatelessWidget {
  const ProductQuantityView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;
    var bloc = context.read<ProductQuantityBloc>();

    return BlocBuilder<ProductQuantityBloc, ProductQuantityState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              state.orderProduct.quantity.toString() + S.order_quantity_label,
              style: textTheme.headline6?.copyWith(fontWeight: FontWeight.bold, color: Colors.brown),
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
                    onPressed: state.orderProduct.quantity == 1
                        ? () => bloc.add(DeleteProductEvent(orderProduct: state.orderProduct))
                        : () => SubtractProductEvent(orderProduct: state.orderProduct),
                    icon: state.orderProduct.quantity == 1 ? Icons.delete_forever_rounded : Icons.remove,
                    outlined: state.orderProduct.quantity == 1,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  width: 56,
                  height: 32,
                  child: ElevatedIconButton(
                    onPressed: () => bloc.add(AddProductEvent(orderProduct: state.orderProduct)),
                    icon: Icons.add,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
