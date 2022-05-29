import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/extensions.dart';
import 'package:ecosecha_flutter/presentation/account/bloc/account_bloc.dart';
import 'package:ecosecha_flutter/presentation/personal_data/view/personal_data_page.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const AccountPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AccountBloc(authRepository: context.read<AuthRepository>()),
      child: const AccountView(),
    );
  }
}

class AccountView extends StatelessWidget {
  const AccountView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BaseView(
      title: Header(title: S.account.capitalizeSentence),
      body: Expanded(
        child: BlocBuilder<AccountBloc, AccountState>(
          builder: (context, state) {
            return ListView(
              padding: EdgeInsets.zero,
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    leading: const Icon(Icons.account_box_rounded),
                    title: Text(S.personal_data.capitalizeSentence),
                    onTap: () => Navigator.of(context).push(PersonalDataPage.route()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.list_alt_rounded),
                    title: Text(S.order_history.capitalizeSentence),
                    // onTap: () => Navigator.of(context).push(OrderHistoryPage.route()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.help_center_rounded),
                    title: Text(S.help.capitalizeSentence),
                    // onTap: () => Navigator.of(context).push(HelpPage.route()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.web),
                    title: Text(S.web.capitalizeSentence),
                    onTap: () {
                      final _url = Uri.parse('https://ecosecha.blogspot.com');

                      launchUrl(_url);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.logout_rounded),
                    title: Text(S.logout.capitalizeSentence),
                    onTap: () => context.read<AccountBloc>().add(const AccountLogoutEvent()),
                  ),
                ],
              ).toList(),
            );
          },
        ),
      ),
    );
  }
}
