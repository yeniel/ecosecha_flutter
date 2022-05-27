part of 'account_bloc.dart';

class AccountState extends Equatable {
  const AccountState({this.user = User.empty, this.orderHistory = const []});

  final User user;
  final List<Order> orderHistory;

  AccountState copyWith({required User user, required List<Order> orderHistory}) {
    return AccountState(user: user, orderHistory: orderHistory);
  }

  @override
  List<Object> get props => [user, orderHistory];
}
