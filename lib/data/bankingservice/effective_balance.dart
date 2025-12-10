import 'package:equatable/equatable.dart';

class EffectiveBalance extends Equatable {
  final double confirmed;
  final double pending;

  const EffectiveBalance({
    required this.confirmed,
    required this.pending,
  });

  double get available => confirmed - pending;

  @override
  List<Object> get props => [confirmed, pending];

  EffectiveBalance copyWith({
    double? confirmed,
    double? pending,
  }) {
    return EffectiveBalance(
      confirmed: confirmed ?? this.confirmed,
      pending: pending ?? this.pending,
    );
  }

}

