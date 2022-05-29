import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:ecosecha_flutter/presentation/categories/bloc/categories_bloc.dart';
import 'package:ecosecha_flutter/presentation/products/view/products_page.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CategoriesPage extends StatelessWidget {
  const CategoriesPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const CategoriesPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategoriesBloc(repository: context.read<Repository>())..add(const CategoriesRequestedEvent()),
      child: const CategoriesView(),
    );
  }
}

class CategoriesView extends StatelessWidget {
  const CategoriesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BaseView(
      title: Header(title: S.categories.capitalizeSentence),
      body: Expanded(
        child: BlocBuilder<CategoriesBloc, CategoriesState>(
          builder: (context, state) {
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.categories.length,
              itemBuilder: (BuildContext context, int index) => CategoryMenuItemView(category: state.categories[index]),
            );
          },
        ),
      ),
    );
  }
}

class CategoryMenuItemView extends StatelessWidget {
  const CategoryMenuItemView({Key? key, required this.category}) : super(key: key);

  final ProductCategory category;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: FaIcon(_getIconData(category.icon)),
      title: Text(category.name),
      onTap: () => Navigator.of(context).push(ProductsPage.route(category: category)),
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
