part of 'send_money_bloc.dart';

enum SendMoneyStatus {
  initial,
  entering,
  pinRequested,
  submitting,
  success,
  failure,
  queuedOffline,
}

class SendMoneyState extends Equatable {
  final SendMoneyStatus status;
  final double availableBalance;
  final String senderAccount;
  final String recipient;
  final String? recipientError;
  final num? unformatted;
  final String amountString;
  final String? errorMessage;
  final bool scanningQRCode;

  const SendMoneyState({
    this.status = SendMoneyStatus.initial,
    this.availableBalance = 0.0,
    this.scanningQRCode = false,
    this.senderAccount = '',
    this.recipientError = '',
    this.unformatted ,
    this.recipient = '',
    this.amountString = '',
    this.errorMessage ,
  });

  SendMoneyState copyWith({
    SendMoneyStatus? status,
    double? availableBalance,
    String? senderAccount,
    String? recipient,
    String? recipientError,
    bool? scanningQRCode,
    String? amountString,
    num? unformatted,
    String? errorMessage,
  }) {
    return SendMoneyState(
      status: status ?? this.status,
      scanningQRCode: scanningQRCode ?? this.scanningQRCode,
      availableBalance: availableBalance ?? this.availableBalance,
      senderAccount: senderAccount ?? this.senderAccount,
      recipient: recipient ?? this.recipient,
      unformatted: unformatted ?? this.unformatted,
      recipientError: recipientError ?? this.recipientError,
      amountString: amountString ?? this.amountString,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props =>
      [
        status,
        availableBalance,
        senderAccount,
        recipient,
        recipientError,
        unformatted,
        amountString,
        errorMessage,
        scanningQRCode
      ];
}
