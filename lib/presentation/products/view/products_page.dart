import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/products/bloc/products_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  static Route route({ProductCategory? category}) {
    return MaterialPageRoute(
      builder: (context) => BlocProvider(
        create: (context) => ProductsBloc(
          productsRepository: context.read<ProductsRepository>(),
          category: category,
        )..add(const ProductsInitEvent()),
        child: const ProductsPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const ProductsView();
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        return BaseView(
          title: Header(
            title: state.category.name.capitalizeSentence,
            showBack: true,
            onBack: () => Navigator.of(context).maybePop(),
          ),
          body: Expanded(
            child: ProductGridView(products: state.products),
          ),
        );
      },
    );
  }
}
