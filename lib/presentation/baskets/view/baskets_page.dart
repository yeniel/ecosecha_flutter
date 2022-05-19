import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
import 'package:ecosecha_flutter/presentation/baskets/bloc/baskets_bloc.dart';
import 'package:ecosecha_flutter/presentation/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BasketsPage extends StatelessWidget {
  const BasketsPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const BasketsPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BasketsBloc(repository: context.read<Repository>())..add(const BasketsRequestedEvent()),
      child: const BasketsView(),
    );
  }
}

class BasketsView extends StatelessWidget {
  const BasketsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var S = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: BlocBuilder<BasketsBloc, BasketsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).viewPadding.top + 20),
                  Text(S.baskets.capitalizeSentence, style: textTheme.headline4),
                  const SizedBox(height: 8),
                  Expanded(
                    child: GridView.count(
                      childAspectRatio: (0.80),
                      primary: false,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      crossAxisCount: 2,
                      children: <Widget>[
                        for (var basket in state.baskets) BasketView(basket: basket),
                      ],
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

class BasketView extends StatelessWidget {
  const BasketView({Key? key, required this.basket}) : super(key: key);

  final Product basket;

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var textTheme = Theme.of(context).textTheme;

    return GridTile(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: CachedNetworkImage(
              imageUrl: basket.image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Text(
            basket.description,
            style: textTheme.bodyText1,
            overflow: TextOverflow.ellipsis,
            maxLines: 3,
          ),
          const Spacer(),
          Row(
            children: [
              Text(
                '${basket.price}€',
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
