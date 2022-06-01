import 'package:ecosecha_flutter/data/data.dart';
import 'package:ecosecha_flutter/domain/domain.dart';
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
      create: (_) =>
      ContactBloc(repository: context.read<Repository>())
        ..add(const ContactRequestedEvent()),
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
                    subtitle: Text(state.company.email ?? S.not_defined.capitalizeSentence),
                  ),
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(S.phone.capitalizeSentence),
                    subtitle: Text(state.company.phone ?? S.not_defined.capitalizeSentence),
                  ),
                  ListTile(
                    leading: const Icon(Icons.house_rounded),
                    title: Text(S.address.capitalizeSentence),
                    subtitle: Text(state.company.address ?? S.not_defined.capitalizeSentence),
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
