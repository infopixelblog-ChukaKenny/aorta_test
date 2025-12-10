// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:aorta/features/transaction/presentation/pages/transaction_history.dart'
    as _i2;
import 'package:aorta/features/transfer/presentation/bloc/send_money_bloc.dart'
    as _i5;
import 'package:aorta/features/transfer/presentation/pages/transfer_page.dart'
    as _i1;
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:flutter/material.dart' as _i4;

/// generated route for
/// [_i1.SendMoneyPage]
class SendMoneyRoute extends _i3.PageRouteInfo<SendMoneyRouteArgs> {
  SendMoneyRoute({
    _i4.Key? key,
    _i5.SendMoneyBloc? bloc,
    List<_i3.PageRouteInfo>? children,
  }) : super(
         SendMoneyRoute.name,
         args: SendMoneyRouteArgs(key: key, bloc: bloc),
         initialChildren: children,
       );

  static const String name = 'SendMoneyRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SendMoneyRouteArgs>(
        orElse: () => const SendMoneyRouteArgs(),
      );
      return _i1.SendMoneyPage(key: args.key, bloc: args.bloc);
    },
  );
}

class SendMoneyRouteArgs {
  const SendMoneyRouteArgs({this.key, this.bloc});

  final _i4.Key? key;

  final _i5.SendMoneyBloc? bloc;

  @override
  String toString() {
    return 'SendMoneyRouteArgs{key: $key, bloc: $bloc}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SendMoneyRouteArgs) return false;
    return key == other.key && bloc == other.bloc;
  }

  @override
  int get hashCode => key.hashCode ^ bloc.hashCode;
}

/// generated route for
/// [_i2.TransactionHistoryPage]
class TransactionHistoryRoute extends _i3.PageRouteInfo<void> {
  const TransactionHistoryRoute({List<_i3.PageRouteInfo>? children})
    : super(TransactionHistoryRoute.name, initialChildren: children);

  static const String name = 'TransactionHistoryRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.TransactionHistoryPage();
    },
  );
}
