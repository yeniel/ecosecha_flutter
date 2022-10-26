part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({this.ordersWebUrl = '', this.blogUrl = '', this.version = '0'});

  final String ordersWebUrl;
  final String blogUrl;
  final String version;

  AccountState copyWith({ordersWebUrl, blogUrl, version}) {
    return AccountState(
      ordersWebUrl: ordersWebUrl ?? this.ordersWebUrl,
      blogUrl: blogUrl ?? this.blogUrl,
      version: version ?? this.version,
    );
  }

  @override
  List<Object> get props => [ordersWebUrl, blogUrl, version];
}
