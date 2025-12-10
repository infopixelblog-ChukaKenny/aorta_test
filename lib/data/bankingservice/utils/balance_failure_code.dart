enum BalanceFailureCode {
  insufficientFunds,
  amountTooSmall,
  invalidAmount,
  serverError,
  unknown,
}

extension BalanceFailureCodeX on BalanceFailureCode {

  String get name => toString().split('.').last;

  int get numeric {
    switch (this) {
      case BalanceFailureCode.insufficientFunds:
        return 1001;
      case BalanceFailureCode.amountTooSmall:
        return 1002;
      case BalanceFailureCode.invalidAmount:
        return 1003;
      case BalanceFailureCode.unknown:
      return 1999;
      case BalanceFailureCode.serverError:
       return 1004;
    }
  }
}
