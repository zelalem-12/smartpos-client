import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_text_field.dart';
import '../../domain/entities/category_entity.dart';
import '../../domain/entities/product_entity.dart';

/// Add/edit dialog for a catalog product.
class ProductDialog extends StatefulWidget {
  final List<CategoryEntity> categories;
  final ProductEntity? product;

  const ProductDialog({super.key, required this.categories, this.product});

  @override
  State<ProductDialog> createState() => _ProductDialogState();
}

class _ProductDialogState extends State<ProductDialog> {
  late final TextEditingController _nameController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _barcodeController;
  late final TextEditingController _priceController;
  late final TextEditingController _costController;
  late final TextEditingController _stockController;
  late final TextEditingController _unitController;
  late final TextEditingController _vatController;
  late String? _selectedCategoryId;
  late bool _isActive;

  @override
  void initState() {
    super.initState();
    final product = widget.product;
    _nameController = TextEditingController(text: product?.name ?? '');
    _descriptionController = TextEditingController(
      text: product?.description ?? '',
    );
    _barcodeController = TextEditingController(text: product?.barcode ?? '');
    _priceController = TextEditingController(
      text: product != null ? product.price.toStringAsFixed(2) : '',
    );
    _costController = TextEditingController(
      text: product?.cost?.toStringAsFixed(2) ?? '',
    );
    _stockController = TextEditingController(
      text: product != null ? product.stockQuantity.toString() : '0',
    );
    _unitController = TextEditingController(text: product?.unit ?? 'pc');
    _vatController = TextEditingController(
      text: product != null ? product.vatRate.toStringAsFixed(2) : '0.15',
    );
    _selectedCategoryId =
        product?.categoryId ?? widget.categories.firstOrNull?.id;
    _isActive = product?.isActive ?? true;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _barcodeController.dispose();
    _priceController.dispose();
    _costController.dispose();
    _stockController.dispose();
    _unitController.dispose();
    _vatController.dispose();
    super.dispose();
  }

  ProductEntity? _buildProduct() {
    final price = double.tryParse(_priceController.text.trim());
    final cost = double.tryParse(_costController.text.trim());
    final stock = double.tryParse(_stockController.text.trim());
    final vat = double.tryParse(_vatController.text.trim());

    if (_selectedCategoryId == null ||
        _nameController.text.trim().isEmpty ||
        _barcodeController.text.trim().isEmpty ||
        _unitController.text.trim().isEmpty ||
        price == null) {
      return null;
    }

    return widget.product?.copyWith(
          categoryId: _selectedCategoryId,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          barcode: _barcodeController.text.trim(),
          price: price,
          cost: cost,
          stockQuantity: stock ?? 0,
          unit: _unitController.text.trim(),
          vatRate: vat ?? 0,
          isActive: _isActive,
          updatedAt: DateTime.now(),
        ) ??
        ProductEntity(
          id: '',
          categoryId: _selectedCategoryId!,
          name: _nameController.text.trim(),
          description: _descriptionController.text.trim(),
          barcode: _barcodeController.text.trim(),
          price: price,
          cost: cost,
          stockQuantity: stock ?? 0,
          unit: _unitController.text.trim(),
          vatRate: vat ?? 0,
          isActive: _isActive,
          createdAt: DateTime.now(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.product != null;

    return AlertDialog(
      title: Text(isEditing ? 'Edit Product' : 'Add Product'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _selectedCategoryId,
              decoration: const InputDecoration(labelText: 'Category'),
              items: widget.categories
                  .map(
                    (c) => DropdownMenuItem(value: c.id, child: Text(c.name)),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _selectedCategoryId = value),
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Name',
              controller: _nameController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Description',
              controller: _descriptionController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Barcode',
              controller: _barcodeController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Price',
              controller: _priceController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Cost (optional)',
              controller: _costController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Stock Quantity',
              controller: _stockController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,3}')),
              ],
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'Unit',
              controller: _unitController,
              textInputAction: TextInputAction.next,
            ),
            const SizedBox(height: 12),
            AppTextField(
              label: 'VAT Rate',
              controller: _vatController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
              ],
              textInputAction: TextInputAction.done,
            ),
            if (isEditing) ...[
              const SizedBox(height: 12),
              SwitchListTile(
                value: _isActive,
                onChanged: (value) => setState(() => _isActive = value),
                title: const Text('Active'),
                activeThumbColor: AppColors.accent,
              ),
            ],
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        AppButton(
          label: isEditing ? 'Save' : 'Add',
          onPressed: () {
            final product = _buildProduct();
            if (product != null) {
              Navigator.of(context).pop(product);
            }
          },
        ),
      ],
    );
  }
}
