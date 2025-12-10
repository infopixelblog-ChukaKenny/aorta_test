import 'package:aorta/data/local/db/db/tables/transaction_table.dart';
import 'package:aorta/features/transaction/domain/entity/transaction_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class TransactionHistoryItem extends StatelessWidget {
  final TransactionEntity transaction;

  const TransactionHistoryItem({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    final color = _statusColor(transaction.status);

    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Icon(_icon(transaction.status), color: color, size: 28),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.recipient,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  formatDate(transaction.createdAt),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '€${transaction.amount.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 4.h),
              Text(
                transaction.status.name.toUpperCase(),
                style: TextStyle(fontSize: 12, color: color),
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _icon(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return Icons.check_circle;
      case TransactionStatus.processing:
        return Icons.autorenew;
      case TransactionStatus.pending:
        return Icons.schedule;
      case TransactionStatus.failed:
        return Icons.error;
    }
  }

  Color _statusColor(TransactionStatus status) {
    switch (status) {
      case TransactionStatus.completed:
        return Colors.green;
      case TransactionStatus.processing:
        return Colors.orange;
      case TransactionStatus.pending:
        return Colors.blue;
      case TransactionStatus.failed:
        return Colors.red;
    }
  }
}

String formatDate(DateTime dt) {
  final now = DateTime.now();
  final local = dt.toLocal();

  // same day -> show time
  if (local.year == now.year &&
      local.month == now.month &&
      local.day == now.day) {
    return DateFormat.jm().format(local); // e.g. 3:34 PM
  }

  if (local.year == now.year) {
    return DateFormat("MMM d • h:mm a").format(local);
  }

  return DateFormat("MMM d, yyyy • h:mm a").format(local);
}