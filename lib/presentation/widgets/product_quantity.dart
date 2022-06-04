import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/widgets/elevated_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    Key? key,
    required this.orderProduct,
    required this.onPressedSubtract,
    required this.onPressedAdd,
    required this.onPressedDelete,
  }) : super(key: key);

  final OrderProduct orderProduct;
  final VoidCallback onPressedSubtract;
  final VoidCallback onPressedAdd;
  final VoidCallback onPressedDelete;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          orderProduct.quantity.toString() + S.order_quantity_label,
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
                onPressed: orderProduct.quantity == 1 ? onPressedDelete : onPressedSubtract,
                icon: orderProduct.quantity == 1 ? Icons.delete_forever_rounded : Icons.remove,
                outlined: orderProduct.quantity == 1,
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 56,
              height: 32,
              child: ElevatedIconButton(
                onPressed: onPressedAdd,
                icon: Icons.add,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
