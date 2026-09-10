import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../../../core/constants/app_constants.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/utils/currency_formatter.dart';
import '../../domain/entities/receipt_data.dart';

/// Thermal-style receipt preview for 58mm/80mm narrow receipt paper.
class ReceiptWidget extends StatelessWidget {
  final ReceiptData receipt;
  final bool isDuplicate;

  const ReceiptWidget({
    required this.receipt,
    this.isDuplicate = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 380),
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (isDuplicate) _duplicateBanner(context),
                _buildHeader(context),
                const Divider(height: 24),
                _buildInvoiceInfo(context),
                const SizedBox(height: 12),
                ..._buildItems(context),
                const Divider(height: 24),
                _buildSummary(context),
                if (receipt.buyerTin != null) _buildBuyerTin(),
                const SizedBox(height: 16),
                _buildQrCode(),
                const SizedBox(height: 12),
                _buildFooter(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _duplicateBanner(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        AppConstants.duplicateWatermark,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: AppColors.error,
          fontWeight: FontWeight.bold,
          fontSize: Theme.of(context).textTheme.bodySmall?.fontSize ?? 14,
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          receipt.tradeName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          receipt.businessName,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        const SizedBox(height: 4),
        Text(
          receipt.address,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 8),
        Text(
          'TIN: ${receipt.tin}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        Text(
          'VAT Reg: ${receipt.vatRegNo}',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildInvoiceInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                'Invoice ${receipt.formattedInvoiceNumber}',
                style: Theme.of(context).textTheme.bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w600),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              DateFormat('yyyy-MM-dd HH:mm')
                  .format(receipt.invoiceDate.toLocal()),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          'Cashier: ${receipt.cashierName}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  List<Widget> _buildItems(BuildContext context) {
    final theme = Theme.of(context);
    return receipt.items.map((item) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    item.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(CurrencyFormatter.format(item.grossAmount)),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${item.quantity} × ${CurrencyFormatter.formatNumber(item.unitPrice)}',
                  style: theme.textTheme.bodySmall,
                ),
                Text(
                  'VAT ${(item.vatRate * 100).toStringAsFixed(0)}%',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          ],
        ),
      );
    }).toList();
  }

  Widget _buildSummary(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _summaryRow(context, 'Net total', receipt.netTotal),
        _summaryRow(context, AppConstants.vatLabel, receipt.vatTotal),
        _summaryRow(context, 'Grand total', receipt.grossTotal, isBold: true),
        _summaryRow(context, 'Payment', receipt.paymentMethod, isText: true),
      ],
    );
  }

  Widget _summaryRow(
    BuildContext context,
    String label,
    dynamic value, {
    bool isBold = false,
    bool isText = false,
  }) {
    final theme = Theme.of(context);
    final display = isText
        ? value as String
        : CurrencyFormatter.format(value as double);
    final style = isBold
        ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)
        : theme.textTheme.bodyMedium;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text(display, style: style),
        ],
      ),
    );
  }

  Widget _buildBuyerTin() {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Text(
        'Buyer TIN: ${receipt.buyerTin}',
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _buildQrCode() {
    return Center(
      child: QrImageView(
        data: receipt.qrPayload,
        version: QrVersions.auto,
        size: 150,
        gapless: false,
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Fiscal signature:',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: 4),
        Text(
          receipt.hash,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 8),
        Text(
          'Thank you for your business!',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium
              ?.copyWith(fontWeight: FontWeight.w600),
        ),
        Text(
          'Powered by SmartPOS Ethiopia',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
