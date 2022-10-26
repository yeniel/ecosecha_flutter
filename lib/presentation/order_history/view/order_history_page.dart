import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/order_history/bloc/order_history_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class OrderHistoryPage extends StatelessWidget {
  const OrderHistoryPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const OrderHistoryPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OrderHistoryBloc(
        orderRepository: context.read<OrderRepository>(),
        analyticsManager: context.read<AnalyticsManager>(),
      )..add(const OrderHistoryInitEvent()),
      child: const OrderHistoryView(),
    );
  }
}

class OrderHistoryView extends StatelessWidget {
  const OrderHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BaseView(
      title: Header(
        title: S.order_history,
        showBack: true,
        onBack: () => Navigator.of(context).maybePop(),
      ),
      body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
        builder: (context, state) {
          return Expanded(
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: state.orders.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.shopping_basket_rounded),
                  title: Text(state.orders[index].date),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
