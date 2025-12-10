import 'dart:async';

import 'package:aorta/data/repositories/transaction/transaction_repository.dart';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionHistoryBloc
    extends Bloc<TransactionEvent, TransactionHistoryState> {
  final TransactionRepository repository;
  StreamSubscription? _sub;

  TransactionHistoryBloc({required this.repository})
      : super(TransactionHistoryState.initial()) {
    on<TransactionHistoryInit>(_onInit);
    on<TransactionHistoryUpdated>(_onUpdated);
  }

  void _onUpdated(
      TransactionHistoryUpdated event,
      Emitter<TransactionHistoryState> emit,
      ) {
    emit(
      state.copyWith(
        transactions: event.transactions,
      ),
    );
  }

  void _onInit(
      TransactionHistoryInit event,
      Emitter<TransactionHistoryState> emit,
      ) {

    _sub?.cancel();
    _sub = repository.subscribeToTransactions().listen(
          (txs) {
        add(TransactionHistoryUpdated(txs));
      },
    );
  }


  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}

