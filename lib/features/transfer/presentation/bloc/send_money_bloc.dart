import 'dart:async';

import 'package:aorta/data/core/aorta_network_call.dart';
import 'package:aorta/data/core/network_info.dart';
import 'package:aorta/data/core/result_handler.dart';
import 'package:aorta/data/repositories/transaction/transaction_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

part 'send_money_event.dart';

part 'send_money_state.dart';

class SendMoneyBloc extends Bloc<SendMoneyEvent, SendMoneyState> {
  final TransactionRepository repository;
  final NetworkInfo networkInfo;

  SendMoneyBloc({required this.repository, required this.networkInfo}) : super(const SendMoneyState()) {
    on<SendMoneyInit>(_onInit);
    on<SendMoneyUpdateRecipient>(_onUpdateRecipient);
    on<SendMoneyScanQrRequested>(_onScanQrRequested);
    on<SendMoneyUpdateAmount>(_onUpdateAmount);
    on<SendMoneyRequestPin>(_onRequestPin);
    on<SendMoneyUpdateBalance>(
      (event, emit) => emit(state.copyWith(availableBalance: event.balance)),
    );
    on<SendMoneyPinSubmitted>(_onPinSubmitted);
    on<SendMoneyEndScanQrCode>((event, emit) {
      _onUpdateScanStatus(false, emit);
    });
    on<SendMoneyStartScanQrCode>((event, emit) {
      _onUpdateScanStatus(true, emit);
    });
    on<SendMoneyReset>(_onReset);
  }

  StreamSubscription? _sub;
  StreamSubscription? _networkSub;

  void listenToBalance() {
    _sub = repository.subscribeToBalance().listen((data) {
      add(SendMoneyUpdateBalance(data.confirmed - data.pending));
    });
  }

  var _syncing = false;
  void listenToNetwork() {
    _networkSub = networkInfo.listen().listen((hasNetwork) async{
      if(hasNetwork && !_syncing){
        _syncing=true;
        await repository.syncPendingTransactions();
        _syncing=false;
      }

    });
  }

  Future<void> _onInit(
    SendMoneyInit event,
    Emitter<SendMoneyState> emit,
  ) async {
    listenToBalance();
    listenToNetwork();
    final balance = (await repository.getBalance()).getRight().toNullable();
    emit(
      state.copyWith(
        status: SendMoneyStatus.entering,
        senderAccount: event.senderAccount,
        availableBalance: (balance?.confirmed??0) - (balance?.pending??0)
      ),
    );
  }

  void _onUpdateRecipient(
    SendMoneyUpdateRecipient event,
    Emitter<SendMoneyState> emit,
  ) {
    final isNumberValid = isValidNigerianPhone(event.recipient);
    emit(
      state.copyWith(
        recipient: event.recipient,
        recipientError: !isNumberValid ? "Enter a valid phone number" : "",
      ),
    );
  }

  void _onUpdateScanStatus(bool status, Emitter<SendMoneyState> emit) {
    emit(state.copyWith(scanningQRCode: status));
  }

  void _onScanQrRequested(
    SendMoneyScanQrRequested event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(state.copyWith(recipient: event.number, scanningQRCode: false));
  }

  void _onUpdateAmount(
    SendMoneyUpdateAmount event,
    Emitter<SendMoneyState> emit,
  ) {
    emit(
      state.copyWith(
        amountString: event.amountString,
        unformatted: event.unformatted,
      ),
    );
  }

  void _onRequestPin(SendMoneyRequestPin event, Emitter<SendMoneyState> emit) {
    emit(state.copyWith(status: SendMoneyStatus.pinRequested));
  }

  Future<void> _onPinSubmitted(
    SendMoneyPinSubmitted event,
    Emitter<SendMoneyState> emit,
  ) async {
    final amount = state.unformatted?.toDouble() ?? 0.0;
    if (state.recipient.isEmpty) {
      emit(
        state.copyWith(
          status: SendMoneyStatus.failure,
          errorMessage: 'Please enter recipient',
        ),
      );
      return;
    }
    if (amount <= 0) {
      emit(
        state.copyWith(
          status: SendMoneyStatus.failure,
          errorMessage: 'Please enter a valid amount',
        ),
      );
      return;
    }

    emit(state.copyWith(status: SendMoneyStatus.submitting, errorMessage: ''));

    await repository
        .sendTransaction(
          transactionId: Uuid().v4(),
          fromAccount: state.senderAccount,
          toRecipient: state.recipient,
          amount: amount,
          pin: event.pin,
        )
        .handleResult(
          onLoading: () async {
            emit(state.copyWith(status: SendMoneyStatus.submitting));
          },
          onLoadingStopped: () async {},
          onServerError: (error) async {
            emit(
              state.copyWith(
                status: SendMoneyStatus.failure,
                errorMessage: error.message,
              ),
            );
          }, onTransactionError: (error) async {

            emit(
              state.copyWith(
                status: SendMoneyStatus.failure,
                errorMessage: error.message,
              ),
            );
          },
          onNoNetwork: (network) async {
            emit(
              state.copyWith(
                status: SendMoneyStatus.queuedOffline,
                errorMessage: NETWORK_ERROR,
              ),
            );
            add(SendMoneyReset());
          },
          onSuccess: (data) async {
            emit(state.copyWith(status: SendMoneyStatus.success));
          },
        );
  }

  void _onReset(SendMoneyReset event, Emitter<SendMoneyState> emit) {
    emit(
      state.copyWith(
        status: SendMoneyStatus.entering,
        unformatted: 0.0,
        amountString: '',
        recipient: '',
        recipientError: '',
        scanningQRCode: false,
      ),
    );
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    _networkSub?.cancel();
    return super.close();
  }
}

bool isValidNigerianPhone(String input) {
  final regex = RegExp(r'^(?:\+234\d{10}|0\d{10})$');
  return regex.hasMatch(input);
}
