import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:ecosecha_flutter/presentation/basket_product_list/bloc/basket_product_list_bloc.dart';
import 'package:ecosecha_flutter/presentation/utils/extensions.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BasketProductListPage extends StatelessWidget {
  const BasketProductListPage({Key? key}) : super(key: key);

  static Route route({Product? basket}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => BasketProductListBloc(
          repository: context.read<Repository>(),
          basket: basket,
        )..add(const BasketProductListRequestedEvent()),
        child: const BasketProductListPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const BasketProductListView();
  }
}

class BasketProductListView extends StatelessWidget {
  const BasketProductListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: BlocBuilder<BasketProductListBloc, BasketProductListState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
                  Header(
                    title: state.basket.name.capitalizeSentence,
                    showBack: true,
                    onBack: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.products.length,
                      itemBuilder: (BuildContext context, int index) =>
                          BasketProductView(basketProduct: state.products[index]),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class BasketProductView extends StatelessWidget {
  const BasketProductView({Key? key, required this.basketProduct}) : super(key: key);

  final BasketProduct basketProduct;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            ProductImage.small(imageUrl: basketProduct.product.image),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.carrot, size: 24),
                    const SizedBox(width: 8),
                    Text(basketProduct.name),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const FaIcon(FontAwesomeIcons.truck, size: 24),
                    const SizedBox(width: 8),
                    Text(basketProduct.origin),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
