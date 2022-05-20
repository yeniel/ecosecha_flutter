import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:ecosecha_flutter/presentation/utils/extensions.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({Key? key, required this.products}) : super(key: key);

  final List<Product> products;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      childAspectRatio: (0.75),
      primary: false,
      crossAxisSpacing: 10,
      mainAxisSpacing: 20,
      crossAxisCount: 2,
      children: <Widget>[
        for (var product in products) ProductView(product: product),
      ],
    );
  }
}

class ProductView extends StatelessWidget {
  const ProductView({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return GridTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ProductImage(imageUrl: product.image),
          const SizedBox(height: 8),
          Text(
            product.name,
            style: textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '${product.price}€',
                style: textTheme.bodyText1?.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(S.order_price_per_unit_label, style: textTheme.bodyText1),
            ],
          ),
          OutlinedButton(
            onPressed: () => {},
            child: Text(S.add.capitalizeSentence),
            style: OutlinedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}