import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/account/view/account_page.dart';
import 'package:ecosecha_flutter/presentation/baskets/view/baskets_page.dart';
import 'package:ecosecha_flutter/presentation/categories/view/categories_page.dart';
import 'package:ecosecha_flutter/presentation/home/bloc/home_bloc.dart';
import 'package:ecosecha_flutter/presentation/order/view/order_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tutorial_coach_mark/tutorial_coach_mark.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(
        userRepository: context.read<UserRepository>(),
        analyticsManager: context.read<AnalyticsManager>(),
      ),
      child: const HomeView(),
    );
  }
}

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late TutorialCoachMark tutorialCoachMark;

  GlobalKey keyOrderTab = GlobalKey();
  GlobalKey keyBasketsTab = GlobalKey();
  GlobalKey keyProductsTab = GlobalKey();

  @override
  void initState() {
    var showCoachmarks = Prefs.getBool(Prefs.showCoachmarksKey);

    if (showCoachmarks ?? true) {
      createTutorial();
      Future.delayed(Duration.zero, showTutorial);
      Prefs.setBool(Prefs.showCoachmarksKey, false);
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedTab = context.select((HomeBloc bloc) => bloc.state.tab);

    return Scaffold(
      body: IndexedStack(
        index: selectedTab.index,
        children: const [OrderPage(), BasketsPage(), CategoriesPage(), AccountPage()],
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _HomeTabButton(
              key: keyOrderTab,
              groupValue: selectedTab,
              value: HomeTab.order,
              icon: const Icon(Icons.checklist_rounded),
            ),
            _HomeTabButton(
              key: keyBasketsTab,
              groupValue: selectedTab,
              value: HomeTab.baskets,
              icon: const Icon(Icons.shopping_basket_rounded),
            ),
            _HomeTabButton(
              key: keyProductsTab,
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

  void showTutorial() {
    tutorialCoachMark.show(context: context);
  }

  void createTutorial() {
    tutorialCoachMark = TutorialCoachMark(
      targets: _createTargets(),
      colorShadow: Colors.green,
      paddingFocus: 10,
      opacityShadow: 0.8,
      hideSkip: true,
    );
  }

  List<TargetFocus> _createTargets() {
    var targets = <TargetFocus>[];

    targets.add(
      TargetFocus(
        identify: 'keyOrderTab',
        keyTarget: keyOrderTab,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'En la pestaña inicial siempre verás tu pedido actual',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'keyBasketsTab',
        keyTarget: keyBasketsTab,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Aquí podrás consultar todas las cestas que tenemos',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
    targets.add(
      TargetFocus(
        identify: 'keyProductsTab',
        keyTarget: keyProductsTab,
        alignSkip: Alignment.bottomRight,
        enableOverlayTab: true,
        enableTargetTab: true,
        contents: [
          TargetContent(
            align: ContentAlign.top,
            builder: (context, controller) {
              return Container(
                child: const Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Además de las cestas podrás añadir productos extra a tus pedidos',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );

    return targets;
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
