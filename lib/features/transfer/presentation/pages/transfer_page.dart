import 'package:aorta/core/navigation/auto_router/app_router.gr.dart';
import 'package:aorta/core/theme/components/button/aorta_filled_button.dart';
import 'package:aorta/core/theme/materialtheme/materialtheme.dart';
import 'package:aorta/core/utils/utils.dart';
import 'package:aorta/features/transfer/presentation/bloc/send_money_bloc.dart';
import 'package:auto_route/auto_route.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:pinput/pinput.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

@RoutePage()
class SendMoneyPage extends StatefulWidget {
  final SendMoneyBloc? bloc;
  const SendMoneyPage({super.key,  this.bloc});

  @override
  State<SendMoneyPage> createState() => _SendMoneyPageState();
}

class _SendMoneyPageState extends State<SendMoneyPage> {
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();
  QRViewController? controller;
  Barcode? result;
  double unFormattedValue = 0;
  late final CurrencyTextInputFormatter _formatter =
      CurrencyTextInputFormatter.currency(
        symbol: "€",
        decimalDigits: 2,
        onChange: (e) {},
      );

  late final bloc = widget.bloc??GetIt.instance<SendMoneyBloc>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  Future<void> _showPinModal(BuildContext context) async {

    bloc.add(SendMoneyRequestPin());

    final pin = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: context.getBottomPadding(),
            left: 20,
            right: 20,
            top: 16,
          ),
          child: _PinEntryWidget(),
        );
      },
    );

    if (pin != null && (pin.length == 4 || pin.length == 6)) {
      bloc.add(SendMoneyPinSubmitted(pin: pin));
    } else if (pin != null) {
      // invalid pin length — let bloc handle error if desired
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('PIN must be 4 or 6 digits')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc
        ..add(
          SendMoneyInit(
            availableBalance: 285856.20,
            senderAccount: '234-7011-8406-21',
          ),
        ),
      child: BlocConsumer<SendMoneyBloc, SendMoneyState>(
        listener: (context, state) {
          if (state.status == SendMoneyStatus.success) {
            // Show success screen as a dialog or full-screen
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Success'),
                content: const Text('The transfer completed successfully.'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // close dialog
                      // reset for another transfer
                      context.read<SendMoneyBloc>().add(SendMoneyReset());
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state.status == SendMoneyStatus.failure && state.errorMessage!=null) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Failed'),
                content: Text(state.errorMessage ?? 'Transfer failed'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          } else if (state.status == SendMoneyStatus.queuedOffline && state.errorMessage!=null) {
            showDialog(
              context: context,
              builder: (_) => AlertDialog(
                title: const Text('Transaction Queued'),
                content: Text(
                  "You don't seem to currently have a network connection, your transaction has been queued, and will resume once internet connectivity is available",
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          }
        },
        builder: (context, state) {
          final bloc = context.read<SendMoneyBloc>();
          _recipientController.text = state.recipient;
          _amountController.text = state.amountString;

          return Scaffold(
            backgroundColor: Theme.of(context).colorScheme.background,
            appBar: AppBar(
              leading: BackButton(
                onPressed: () {
                  if (state.scanningQRCode) {
                    bloc.add(SendMoneyEndScanQrCode());
                  } else {}
                },
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: defPadding),
                  child: InkWell(
                    onTap: () {
                      context.router.navigate(TransactionHistoryRoute());
                    },
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedTransactionHistory,
                      size: 20.w,
                    ),
                  ),
                ),
              ],
              title: const Text('Transfer Request'),
              elevation: 0,
              backgroundColor: Colors.transparent,
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 8.h),
                      const Text(
                        'Available Balance',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(height: 8.h),
                      Text(
                        '€${state.availableBalance.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: context.getColorScheme().primary,
                        ),
                      ),
                      SizedBox(height: 12.h),
                      const Text(
                        'Please, enter the receiver\'s bank account number or phone number or scan QR.',
                        style: TextStyle(fontSize: 12),
                      ),
                      SizedBox(height: 22.h),

                      // Sender's account (readonly)
                      Text(
                        'Sender\'s Account No.',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: context.getColorScheme().primary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        readOnly: true,
                        controller: TextEditingController(
                          text: state.senderAccount,
                        ),
                        decoration: InputDecoration(
                          border: UnderlineInputBorder(),
                          suffixIcon: Icon(
                            Icons.check_circle,
                            color: context.getColorScheme().primary,
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

                      // Recipient row - input + QR icon
                      Text(
                        'Recipient',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: context.getColorScheme().primary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                TextFormField(
                                  controller: _recipientController,
                                  keyboardType: TextInputType.phone,
                                  decoration: const InputDecoration(
                                    hintText: 'Phone or account number',
                                    border: UnderlineInputBorder(),
                                  ),
                                  onChanged: (v) =>
                                      bloc.add(SendMoneyUpdateRecipient(v)),
                                ),
                                if (state.recipientError != null)
                                  Text(
                                    state.recipientError!,
                                    style: context
                                        .getTextTheme()
                                        .bodySmall
                                        ?.copyWith(color: Colors.red),
                                  ),
                              ],
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              bloc.add(SendMoneyStartScanQrCode());
                            },
                            icon: const Icon(Icons.qr_code_scanner, size: 28),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.h),

                      // Amount
                      Text(
                        'Amount of Transfer Request',
                        style: TextStyle(
                          fontSize: 13.sp,
                          color: context.getColorScheme().primary,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      TextFormField(
                        key: Key("Amount"),
                        controller: _amountController,
                        inputFormatters: [_formatter],
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          hintText: 'Enter amount',
                          border: UnderlineInputBorder(),
                        ),
                        onChanged: (v) {
                          bloc.add(
                            SendMoneyUpdateAmount(
                              v,
                              _formatter.getUnformattedValue(),
                            ),
                          );
                        },
                      ),

                      SizedBox(height: 30.h),

                      // Send Button
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: AortaFilledButton(
                                key: Key("Send"),
                                text: state.status == SendMoneyStatus.submitting
                                    ? 'Sending...'
                                    : 'Send ${state.amountString}',
                                enabled:
                                    state.status != SendMoneyStatus.submitting,
                                onPressed: () {
                                  // validate quickly then show PIN
                                  if (state.recipient.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Please enter recipient'),
                                      ),
                                    );
                                    return;
                                  }
                                  if ((_formatter.getDouble() ?? 0) <= 0) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Please enter a valid amount',
                                        ),
                                      ),
                                    );
                                    return;
                                  }
                                  if ((_formatter.getDouble() ?? 0) >
                                      state.availableBalance) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text('Not enough balance'),
                                      ),
                                    );
                                    return;
                                  }
                                  _showPinModal(context);
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // status indicator (optional)
                      if (state.status == SendMoneyStatus.submitting) ...[
                        const Center(child: CircularProgressIndicator()),
                        SizedBox(height: 12.h),
                      ],
                    ],
                  ),
                ),
                if (state.scanningQRCode)
                  Positioned.fill(
                    child: GestureDetector(
                      onTap: () {
                        // tap outside to close the overlay
                        bloc.add(SendMoneyEndScanQrCode());
                      },
                      child: Container(
                        color: Colors.black54,
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 24.w),
                          child: SizedBox(
                            width: double.infinity,
                            height: 420.h,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              clipBehavior: Clip.hardEdge,
                              child: Stack(
                                children: [
                                  // QR View fills the card
                                  QRView(
                                    key: GlobalKey(),
                                    onQRViewCreated: _onQRViewCreated,
                                  ),

                                  // Close button
                                  Positioned(
                                    top: 8,
                                    right: 8,
                                    child: IconButton(
                                      onPressed: () {
                                        bloc.add(SendMoneyEndScanQrCode());
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),

                                  // Optional small instruction
                                  Positioned(
                                    bottom: 12,
                                    left: 12,
                                    right: 12,
                                    child: Text(
                                      'Point camera at payer QR code',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    controller = controller;
    controller.scannedDataStream.listen((scanData) {
      debugPrint("scanned data: ${scanData.code}");

      if (isValidNigerianPhone(scanData.code ?? "")) {
        GetIt.instance<SendMoneyBloc>().add(
          SendMoneyScanQrRequested(scanData.code ?? ""),
        );
      } else {
        GetIt.instance<SendMoneyBloc>().add(SendMoneyEndScanQrCode());
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Invalid QR Code')));
      }
    });
  }
}

class _PinEntryWidget extends StatefulWidget {
  @override
  State<_PinEntryWidget> createState() => _PinEntryWidgetState();
}

class _PinEntryWidgetState extends State<_PinEntryWidget> {
  final _pinController = TextEditingController();
  String pin = "";

  @override
  void dispose() {
    _pinController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.getBottomInsets()),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Text(
            'Enter PIN',
            style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text(
            'Enter your 4 or 6 digit PIN to authorize this transfer',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Pinput(
            controller: _pinController,
            obscureText: true,
            obscuringCharacter: "*",
            onChanged: (newValue) {
              setState(() {
                pin = newValue;
              });
            },
            onCompleted: (pin) => {
              if (pin.length == 4) {Navigator.of(context).pop(pin)},
            },
          ),

          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: AortaFilledButton(
                  onPressed: () {
                    final pin = _pinController.text.trim();
                    Navigator.of(context).pop(pin);
                  },
                  enabled: pin.length == 4,
                  text: 'Confirm',
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }
}
