import 'package:otte/functions/sharedPreference.dart';
import 'package:otte/models/checkout.dart';
import 'package:otte/resources/api/checkoutAPI.dart';

class CheckoutRepository {
  const CheckoutRepository();

  CheckoutAPI get _checkoutAPI => const CheckoutAPI();

  Future<Checkout> createCheckout() async {
    print('aaaaa');
    // checkoutCreate MutationではCustomerとの紐付けができない
    final queryResult = await _checkoutAPI.createCheckout();
    if (!_checkoutAPI.isValidCheckoutCreate(queryResult)) {
      throw Exception('failed to create a checkout');
    }
    final checkout = Checkout.fromQueryResult(
        queryResult.data['checkoutCreate']['checkout']);
    await checkoutIdPref.setPref(checkout.id);

    final customerAccessToken = await customerAccessTokenPref.getPref();
    if (customerAccessToken == null) {
      return checkout;
    }
    final associatedCheckout = await associateCheckoutAndCustomer(checkout.id);
    return associatedCheckout;
  }

  Future<Checkout> associateCheckoutAndCustomer(String checkoutId) async {
    final customerAccessToken = await customerAccessTokenPref.getPref();
    if (customerAccessToken == null) {
      return await getCheckout(checkoutId);
    }
    final queryResult = await _checkoutAPI.associateCustomerCheckout(
        checkoutId, customerAccessToken);
    if (!_checkoutAPI.isValidCheckoutCustomerAssociate(queryResult)) {
      throw Exception('failed to associate customer and checkout');
    }
    // 住所等が更新されている
    final checkout = Checkout.fromQueryResult(
        queryResult.data['checkoutCustomerAssociate']['checkout']);
    return checkout;
  }

  Future<Checkout> getCheckout(String checkoutId) async {
    final queryResult = await _checkoutAPI.getCheckout(checkoutId);
    if (!_checkoutAPI.isValidGetCheckout(queryResult)) {
      throw Exception('failed to get Checkout');
    }
    final checkout = Checkout.fromQueryResult(queryResult.data['node']);
    return checkout;
  }

  // Future<Checkout> restoreCheckout() async {
  //   final checkoutId = await checkoutIdPref.getPref();
  //   if (checkoutId == null) {
  //     final checkout = await createCheckout();
  //     return checkout;
  //   }
  //   try {
  //     final checkout = await getCheckout(checkoutId);

  //     final customerAccessToken = await customerAccessTokenPref.getPref();
  //     if (customerAccessToken == null) {
  //       return checkout;
  //     }
  //     final associatedCheckout =
  //         await associateCheckoutAndCustomer(checkout.id);
  //     return associatedCheckout;
  //   } on Exception catch (e) {
  //     print(e);
  //     return await createCheckout();
  //   }
  // }

  // Future<void> completeCheckout(String checkoutId) async {
  //   await checkoutIdPref.removePref();
  // }

  // Future<Checkout> disassociateCheckoutAndCustomer(String checkoutId) async {
  //   final queryResult =
  //       await _checkoutAPI.disassociateCustomerCheckout(checkoutId);
  //   if (!_checkoutAPI.isValidCheckoutCustomerDisassociate(queryResult)) {
  //     throw Exception('failed to disassociate customer and checkout');
  //   }
  //   final checkout = Checkout.fromQueryResult(
  //       queryResult.data['checkoutCustomerDisassociate']['checkout']);
  //   return checkout;
  // }

  // Future<Checkout> addToLineItems(String checkoutId, String variantId) async {
  //   final lineItems = [
  //     {
  //       'quantity': 1,
  //       'variantId': variantId,
  //     }
  //   ];
  //   final queryResult =
  //       await _checkoutAPI.addToLineItems(checkoutId, lineItems);
  //   if (!_checkoutAPI.isValidCheckoutLineItemsAdd(queryResult)) {
  //     print(queryResult.exception);
  //     throw Exception('failed to add product to lineItems');
  //   }
  //   final checkout = Checkout.fromQueryResult(
  //       queryResult.data['checkoutLineItemsAdd']['checkout']);
  //   return checkout;
  // }

  // Future<Checkout> reduceLineItemQuantity(String checkoutId, String lineItemId,
  //     String variantId, int currentQuantity) async {
  //   if (currentQuantity == 1) {
  //     final checkout = await removeLineItem(checkoutId, lineItemId);
  //     return checkout;
  //   }

  //   final lineItems = [
  //     {
  //       'quantity': currentQuantity - 1,
  //       'variantId': variantId,
  //     }
  //   ];
  //   final queryResult =
  //       await _checkoutAPI.replaceLineItems(checkoutId, lineItems);
  //   if (!_checkoutAPI.isValidCheckoutLineItemsReplace(queryResult)) {
  //     throw Exception('failed to reduce quantity of lineItem');
  //   }
  //   final checkout = Checkout.fromQueryResult(
  //       queryResult.data['checkoutLineItemsReplace']['checkout']);
  //   return checkout;
  // }

  // Future<Checkout> removeLineItem(String checkoutId, String lineItemId) async {
  //   final queryResult =
  //       await _checkoutAPI.removeFromLineItems(checkoutId, [lineItemId]);
  //   if (!_checkoutAPI.isValidCheckoutLineItemsRemove(queryResult)) {
  //     throw Exception('failed to remove lineItem');
  //   }
  //   final checkout = Checkout.fromQueryResult(
  //       queryResult.data['checkoutLineItemsRemove']['checkout']);
  //   return checkout;
  // }
}
