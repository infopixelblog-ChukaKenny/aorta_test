import 'balance_failure_code.dart';

abstract class BalanceFailure {
  final BalanceFailureCode code;
  final String? message;

  const BalanceFailure(this.code, [this.message]);

  @override
  String toString() => 'BalanceFailure(${code.name}): $message';

  // Factory helpers
  factory BalanceFailure.insufficientFunds({
    required double available,
    required double requested,
  }) => InsufficientFunds(available: available, requested: requested);

  factory BalanceFailure.amountTooSmall({
    required double min,
    required double requested,
  }) => AmountTooSmall(min: min, requested: requested);

  factory BalanceFailure.invalidAmount({required double requested}) =>
      InvalidAmount(requested: requested);

  factory BalanceFailure.serverError() =>
      ServerError();

  factory BalanceFailure.unknown([String? message]) =>
      UnknownFailure(message: message);
}

/// Insufficient funds failure
class InsufficientFunds extends BalanceFailure {
  final double available;
  final double requested;

  InsufficientFunds({required this.available, required this.requested})
    : super(
        BalanceFailureCode.insufficientFunds,
        'Insufficient funds: available=$available requested=$requested',
      );
}

/// Amount less than minimum allowed
class AmountTooSmall extends BalanceFailure {
  final double min;
  final double requested;

  AmountTooSmall({required this.min, required this.requested})
    : super(
        BalanceFailureCode.amountTooSmall,
        'Amount too small: min=$min requested=$requested',
      );
}

/// Invalid amount (e.g., negative, NaN), should not happen as UI should validate this,
/// but just adding it here to be safe
class InvalidAmount extends BalanceFailure {
  final double requested;

  InvalidAmount({required this.requested})
    : super(
        BalanceFailureCode.invalidAmount,
        'Invalid amount: requested=$requested',
      );
}

class ServerError extends BalanceFailure {
  ServerError()
    : super(BalanceFailureCode.serverError, 'An unknown server error occured');
}

/// Fallback unknown error
class UnknownFailure extends BalanceFailure {
  UnknownFailure({String? message})
    : super(BalanceFailureCode.unknown, message ?? 'Unknown balance error');
}
