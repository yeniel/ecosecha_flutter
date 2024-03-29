import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/order/bloc/order_bloc.dart';
import 'package:ecosecha_flutter/presentation/products/bloc/products_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:ecosecha_flutter/presentation/widgets/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ProductsPage extends StatelessWidget {
  ProductsPage({Key? key, required ProductCategory category})
      : _category = category,
        super(key: key);

  final ProductCategory _category;

  static Route route({required ProductCategory category}) {
    return MaterialPageRoute(builder: (_) => ProductsPage(category: category));
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductsBloc(
            productsRepository: context.read<ProductsRepository>(),
            orderRepository: context.read<OrderRepository>(),
            category: _category,
          )..add(const ProductsInitEvent()),
        ),
        BlocProvider(
          create: (_) => OrderBloc(
            orderRepository: context.read<OrderRepository>(),
            userRepository: context.read<UserRepository>(),
            companyRepository: context.read<CompanyRepository>(),
            authRepository: context.read<AuthRepository>(),
            analyticsManager: context.read<AnalyticsManager>(),
          )..add(const OrderInitEvent()),
        ),
      ],
      child: const ProductsView(),
    );
  }
}

class ProductsView extends StatelessWidget {
  const ProductsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BlocConsumer<OrderBloc, OrderState>(
      listener: (context, state) {
        switch (state.pageStatus) {
          case OrderPageStatus.canNotChangeError:
            {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(content: Text(S.can_not_change_order_error)),
                );
            }
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return BlocBuilder<ProductsBloc, ProductsState>(
          builder: (context, state) {
            return BaseView(
              title: Header(
                title: state.category.name.capitalizeSentence,
                showBack: true,
                onBack: () => Navigator.of(context).maybePop(),
              ),
              body: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      onChanged: (query) => context.read<ProductsBloc>().add(ProductsSearchEvent(query: query)),
                      decoration: InputDecoration(
                        labelText: S.search,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: ProductGridView(orderProducts: state.orderProducts),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
