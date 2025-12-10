part of 'send_money_bloc.dart';


abstract class SendMoneyEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMoneyInit extends SendMoneyEvent {
  final double availableBalance;
  final String senderAccount;

  SendMoneyInit({
    required this.availableBalance,
    required this.senderAccount,
  });

  @override
  List<Object?> get props => [availableBalance, senderAccount];
}

class SendMoneyUpdateRecipient extends SendMoneyEvent {
  final String recipient;

  SendMoneyUpdateRecipient(this.recipient);

  @override
  List<Object?> get props => [recipient];
}

class SendMoneyScanQrRequested extends SendMoneyEvent {
  final String number;

  SendMoneyScanQrRequested(this.number);
}

class SendMoneyUpdateBalance extends SendMoneyEvent {
  final double balance;

  SendMoneyUpdateBalance(this.balance);
}

class SendMoneyUpdateAmount extends SendMoneyEvent {
  final String amountString;
  final num unformatted;

  SendMoneyUpdateAmount(this.amountString,this.unformatted);

  @override
  List<Object?> get props => [...super.props, amountString, unformatted];
}

class SendMoneyRequestPin extends SendMoneyEvent {}
class SendMoneyStartScanQrCode extends SendMoneyEvent {}
class SendMoneyEndScanQrCode extends SendMoneyEvent {}

class SendMoneyPinSubmitted extends SendMoneyEvent {
  final String pin;

   SendMoneyPinSubmitted({
    required this.pin,
  });

  @override
  List<Object?> get props => [pin];
}

class SendMoneyReset extends SendMoneyEvent {}

