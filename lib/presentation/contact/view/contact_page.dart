import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/contact/bloc/contact_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const ContactPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      ContactBloc(companyRepository: context.read<CompanyRepository>())
        ..add(const ContactInitEvent()),
      child: const ContactView(),
    );
  }
}

class ContactView extends StatelessWidget {
  const ContactView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BaseView(
      title: Header(
        title: S.contact.capitalizeSentence,
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
                    title: Text(S.email.capitalizeSentence),
                    subtitle: Text(state.company.email),
                    onTap: () async {
                      var emailUri = Uri.parse('mailto:${state.company.email}');

                      await launchUrl(emailUri);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(S.phone.capitalizeSentence),
                    subtitle: Text(state.company.phone),
                    onTap: () async {
                      var phoneUri = Uri.parse('tel:${state.company.phone}');

                      await launchUrl(phoneUri);
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.house_rounded),
                    title: Text(S.address.capitalizeSentence),
                    subtitle: Text(state.company.address),
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
