part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({this.ordersWebUrl = '', this.blogUrl = ''});

  final String ordersWebUrl;
  final String blogUrl;

  AccountState copyWith({required ordersWebUrl, required blogUrl}) {
    return AccountState(ordersWebUrl: ordersWebUrl, blogUrl: blogUrl);
  }

  @override
  List<Object> get props => [ordersWebUrl, blogUrl];
}
