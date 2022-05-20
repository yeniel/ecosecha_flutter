import 'package:ecosecha_flutter/presentation/account/view/account_page.dart';
import 'package:ecosecha_flutter/presentation/baskets/view/baskets_page.dart';
import 'package:ecosecha_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:ecosecha_flutter/presentation/order/view/order_page.dart';
import 'package:ecosecha_flutter/presentation/products/view/products_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeBloc bloc) => bloc.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [OrderPage(), BasketsPage(), ProductsPage(), AccountPage()],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.order,
              icon: const Icon(Icons.checklist_rounded),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.baskets,
              icon: const Icon(Icons.shopping_basket_rounded),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.products,
              icon: const Icon(Icons.add_shopping_cart_rounded),
            ),
            _HomeTabButton(
              groupValue: selectedTab,
              value: HomeTab.account,
              icon: const Icon(Icons.manage_accounts_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeTabButton extends StatelessWidget {
  const _HomeTabButton({
    Key? key,
    required this.groupValue,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final HomeTab groupValue;
  final HomeTab value;
  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.read<HomeBloc>().add(HomeSetTabEvent(value)),
      iconSize: 32,
      color: groupValue != value ? null : Theme.of(context).colorScheme.secondary,
      icon: icon,
    );
  }
}
