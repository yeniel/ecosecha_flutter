part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({this.orderHistory = const []});

  final List<Order> orderHistory;

  AccountState copyWith({required List<Order> orderHistory}) {
    return AccountState(orderHistory: orderHistory);
  }

  @override
  List<Object> get props => [orderHistory];
}
