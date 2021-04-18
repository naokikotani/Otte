import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:otte/models/checkout.dart';
import 'package:otte/repositories/checkoutRepository.dart';

final checkoutViewModelProvider = ChangeNotifierProvider(
  (ref) => CheckoutViewModel(),
);

class CheckoutViewModel extends ChangeNotifier {
  CheckoutRepository get _checkoutRepository => const CheckoutRepository();

  Checkout _checkout;

  Checkout get checkout => _checkout;

  Future<void> createCheckout() async {
    try {
      _checkout = await _checkoutRepository.createCheckout();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> addToLineItems(String variantId) async {
    try {
      if (_checkout == null) {
        _checkout = await _checkoutRepository.createCheckout();

      }
      _checkout =
          await _checkoutRepository.addToLineItems(_checkout.id, variantId);
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<void> removeLineItem(String variantId) async {
    try {
      if (_checkout == null) {
        return;
      }
      final targetLineItem = _checkout.lineItems
          .firstWhere((lineItem) => lineItem.variantId == variantId);
      final lineItemId = targetLineItem.id;
      _checkout =
          await _checkoutRepository.removeLineItem(_checkout.id, lineItemId);
      notifyListeners();
    } on Exception catch (e) {
      print(e);
    }
  }
}
