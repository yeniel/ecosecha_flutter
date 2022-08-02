part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({this.ordersWebUrl = '', this.blogUrl = ''});

  final String ordersWebUrl;
  final String blogUrl;

  AccountState copyWith({ordersWebUrl, blogUrl}) {
    return AccountState(ordersWebUrl: ordersWebUrl ?? this.ordersWebUrl, blogUrl: blogUrl ?? this.blogUrl);
  }

  @override
  List<Object> get props => [ordersWebUrl, blogUrl];
}
