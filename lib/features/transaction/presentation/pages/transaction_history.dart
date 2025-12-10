import 'package:aorta/features/transaction/presentation/bloc/transaction_bloc.dart';
import 'package:aorta/features/transaction/presentation/widgets/transaction_item.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';

@RoutePage()
class TransactionHistoryPage extends StatelessWidget {
  const TransactionHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: GetIt.instance<TransactionHistoryBloc>()
        ..add(TransactionHistoryInit()),
      child: BlocBuilder<TransactionHistoryBloc, TransactionHistoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Transaction History'),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: _body(context, state),
          );
        },
      ),
    );
  }

  Widget _body(BuildContext context, TransactionHistoryState state) {
    if (state.transactions.isEmpty) {
      return const Center(child: Text('No transactions yet'));
    }
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      itemCount: state.transactions.length,
      itemBuilder: (_, index) {
        return TransactionHistoryItem(transaction: state.transactions[index]);
      },
    );
  }
}
