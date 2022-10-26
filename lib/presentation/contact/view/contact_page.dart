import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/contact/bloc/contact_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ContactPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ContactBloc(
        companyRepository: context.read<CompanyRepository>(),
        analyticsManager: context.read<AnalyticsManager>(),
      )..add(const ContactInitEvent()),
      child: const ContactView(),
    );
  }
}

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;
    var bloc = context.read<ContactBloc>();

    return BaseView(
      title: Header(
        title: S.contact,
        showBack: true,
        onBack: () => Navigator.of(context).maybePop(),
      ),
      body: BlocBuilder<ContactBloc, ContactState>(
        builder: (context, state) {
          return Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    leading: const Icon(Icons.email),
                    title: Text(S.email),
                    subtitle: Text(state.company.email),
                    onTap: () async {
                      bloc.add(const ContactEmailTapEvent());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(S.phone),
                    subtitle: Text(state.company.phone),
                    onTap: () async {
                      bloc.add(const ContactPhoneTapEvent());
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.house_rounded),
                    title: Text(S.address),
                    subtitle: Text(state.company.address),
                    onTap: () async {
                      bloc.add(const AddressTapEvent());
                    },
                  ),
                ],
              ).toList(),
            ),
          );
        },
      ),
    );
  }
}
