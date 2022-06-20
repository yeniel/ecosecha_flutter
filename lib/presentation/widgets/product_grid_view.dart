import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/basket_product_list/view/basket_product_list_page.dart';
import 'package:ecosecha_flutter/presentation/order/bloc/order_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/grid_text.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_image.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_quantity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({Key? key, required this.orderProducts}) : super(key: key);

  final List<OrderProduct> orderProducts;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      childAspectRatio: (0.75),
      primary: false,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      crossAxisCount: 2,
      padding: EdgeInsets.zero,
      children: <Widget>[
        for (var orderProduct in orderProducts) ProductView(orderProduct: orderProduct),
      ],
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView({Key? key, required this.orderProduct}) : super(key: key);

  final OrderProduct orderProduct;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;
    var product = orderProduct.product;
    var productNameLines = orderProduct.quantity == 0 ? 3 : 2;

    return GestureDetector(
      child: GridTile(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ProductImage(imageUrl: product.image),
            const SizedBox(height: 8),
            GridText(
              product.name,
              style: textTheme.bodyText1,
              overflow: TextOverflow.ellipsis,
              minLines: productNameLines,
              maxLines: productNameLines,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(
                  '${product.price}€',
                  style: textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
                ),
                Text(S.order_price_per_unit_label, style: textTheme.bodyText1),
              ],
            ),
            const Spacer(),
            ProductGridViewButtons(orderProduct: orderProduct),
          ],
        ),
      ),
      onTap: () {
        if (product.type == ProductType.basket) {
          Navigator.of(context).push(BasketProductListPage.route(basket: product));
        }
      },
    );
  }
}

class ProductGridViewButtons extends StatelessWidget {
  const ProductGridViewButtons({Key? key, required this.orderProduct}) : super(key: key);

  final OrderProduct orderProduct;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var bloc = context.read<OrderBloc>();

    if (orderProduct.quantity == 0) {
      return Container(
        height: 40,
        padding: EdgeInsets.zero,
        child: OutlinedButton(
          onPressed: () => bloc.add(AddProductEvent(orderProduct: orderProduct)),
          child: Text(S.add.capitalizeSentence),
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
      );
    } else {
      return Container(
        height: 60,
        child: ProductQuantity(
          orderProduct: orderProduct,
          onPressedAdd: () => bloc.add(AddProductEvent(orderProduct: orderProduct)),
          onPressedSubtract: () => bloc.add(SubtractProductEvent(orderProduct: orderProduct)),
          onPressedDelete: () => bloc.add(DeleteProductEvent(orderProduct: orderProduct)),
        ),
      );
    }
  }
}
