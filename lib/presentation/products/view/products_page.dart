import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:ecosecha_flutter/presentation/products/bloc/products_bloc.dart';
import 'package:ecosecha_flutter/presentation/utils/extensions.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ProductsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductsBloc(repository: context.read<Repository>())..add(const ProductsRequestedEvent()),
      child: const ProductsView(),
    );
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
              const ProductsHeader(),
              const SizedBox(height: 8),
              Expanded(
                child: BlocBuilder<ProductsBloc, ProductsState>(
                  builder: (context, state) {
                    if (state.selectedCategory == null) {
                      return ListView.builder(
                        itemCount: state.categories.length,
                        itemBuilder: (BuildContext context, int index) =>
                            CategoryMenuItemView(productCategory: state.categories[index]),
                      );
                    } else {
                      return ProductGridView(products: state.products);
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductsHeader extends StatelessWidget {
  const ProductsHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var S = AppLocalizations.of(context)!;

    return BlocBuilder<ProductsBloc, ProductsState>(
      builder: (context, state) {
        var title = S.categories;

        if (state.selectedCategory != null) {
          title = state.selectedCategory!.name;
        }

        return Row(
          children: [
            if (state.selectedCategory != null)
              IconButton(
                onPressed: () => context.read<ProductsBloc>().add(const BackToCategoriesEvent()),
                icon: const Icon(Icons.arrow_back_ios, size: 32),
              ),
            Text(title.capitalizeFirstOfEach, style: textTheme.headline4),
          ],
        );
      },
    );
  }
}

class CategoryMenuItemView extends StatelessWidget {
  const CategoryMenuItemView({Key? key, required this.productCategory}) : super(key: key);

  final ProductCategory productCategory;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(_getIconData(productCategory.icon)),
      title: Text(productCategory.name),
      onTap: () => context.read<ProductsBloc>().add(CategorySelectedEvent(selectedCategory: productCategory)),
    );
  }

  IconData _getIconData(String categoryIcon) {
    switch (categoryIcon) {
      case 'fruit':
        return FontAwesomeIcons.solidLemon;
      case 'rice':
        return FontAwesomeIcons.bowlRice;
      case 'canned':
        return FontAwesomeIcons.circleStop;
      case 'breakfast':
        return FontAwesomeIcons.mugSaucer;
      case 'cold_meat':
        return FontAwesomeIcons.bacon;
      case 'egg':
        return FontAwesomeIcons.egg;
      case 'legume':
        return FontAwesomeIcons.wheatAwn;
      case 'bread':
        return FontAwesomeIcons.breadSlice;
      case 'vegetable':
        return FontAwesomeIcons.carrot;
      default:
        return FontAwesomeIcons.carrot;
    }
  }
}
