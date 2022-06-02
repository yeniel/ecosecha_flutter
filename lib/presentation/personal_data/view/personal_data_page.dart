import 'package:data/data.dart';
import 'package:domain/domain.dart';
import 'package:ecosecha_flutter/presentation/personal_data/bloc/personal_data_bloc.dart';
import 'package:ecosecha_flutter/presentation/widgets/base_view.dart';
import 'package:ecosecha_flutter/presentation/widgets/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PersonalDataPage extends StatelessWidget {
  const PersonalDataPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(builder: (_) => const PersonalDataPage());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PersonalDataBloc(repository: context.read<Repository>())..add(const PersonalDataRequestedEvent()),
      child: const PersonalDataView(),
    );
  }
}

class PersonalDataView extends StatelessWidget {
  const PersonalDataView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var S = AppLocalizations.of(context)!;

    return BaseView(
      title: Header(
        title: S.personal_data.capitalizeSentence,
        showBack: true,
        onBack: () => Navigator.of(context).maybePop(),
      ),
      body: BlocBuilder<PersonalDataBloc, PersonalDataState>(
        builder: (context, state) {
          return Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: ListTile.divideTiles(
                context: context,
                tiles: [
                  ListTile(
                    leading: const Icon(Icons.account_circle_rounded),
                    title: Text(S.user.capitalizeSentence),
                    subtitle: Text(state.user.id.toString()),
                  ),
                  ListTile(
                    leading: const Icon(Icons.account_box_rounded),
                    title: Text(S.name.capitalizeSentence),
                    subtitle: Text(state.user.name ?? S.not_defined.capitalizeSentence),
                  ),
                  ListTile(
                    leading: const Icon(Icons.email_rounded),
                    title: Text(S.email.capitalizeSentence),
                    subtitle: Text(state.user.email ?? S.not_defined.capitalizeSentence),
                  ),
                  ListTile(
                    leading: const FaIcon(FontAwesomeIcons.truck, size: 24),
                    title: Text(S.delivery_group.capitalizeSentence),
                    subtitle: Text(state.user.deliveryGroup),
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
