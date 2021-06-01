import 'package:graphql_flutter/graphql_flutter.dart';

import 'graphqlClient.dart';
import 'queryResultDataExists.dart';

class CheckoutAPI {
  const CheckoutAPI();

  GraphQLClient get _client => const ShopifyGraphQLClient().graphQLClient;

  // checkoutを作成する処理
  Future<QueryResult> createCheckout() async {
    final queryOptions = QueryOptions(
      documentNode: gql(_createCheckoutMutation),
      variables: <String, dynamic>{'input': <String, dynamic>{}},
      fetchPolicy: FetchPolicy.noCache,
    );
    final queryResult = await _client.query(queryOptions);
    return queryResult;
  }

  static const String _createCheckoutMutation = '''
    mutation checkoutCreate (\$input: CheckoutCreateInput!){
      checkoutCreate(input: \$input) {
        userErrors {
          message
          field
        }
        checkout {
          $_checkout
        }
      }
    }
  ''';

  // lineitemにアイテムを追加する処理
  Future<QueryResult> addToLineItems(
      String checkoutId, List<Map<String, dynamic>> lineItems) async {
    final queryOptions = QueryOptions(
      documentNode: gql(_addToLineItemsMutation),
      variables: <String, dynamic>{
        'checkoutId': checkoutId,
        'lineItems': lineItems,
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    final queryResult = await _client.query(queryOptions);
    print(queryResult.data);
    return queryResult;
  }

  static const String _addToLineItemsMutation = '''
    mutation checkoutLineItemsAdd (\$checkoutId: ID!, \$lineItems: [CheckoutLineItemInput!]!) {
      checkoutLineItemsAdd(checkoutId: \$checkoutId, lineItems: \$lineItems) {
        userErrors {
          message
          field
        }
        checkout {
          $_checkout
        }
      }
    }
  ''';


  // listitemからitemを削除する
  Future<QueryResult> removeFromLineItems(
      String checkoutId, List<String> lineItemIds) async {
    final queryOptions = QueryOptions(
      documentNode: gql(_removeLineItemsMutation),
      variables: <String, dynamic>{
        'checkoutId': checkoutId,
        'lineItemIds': lineItemIds,
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    final queryResult = await _client.query(queryOptions);
    return queryResult;
  }

  static const String _removeLineItemsMutation = '''
    mutation checkoutLineItemsRemove(\$checkoutId: ID!, \$lineItemIds: [ID!]!) {
      checkoutLineItemsRemove(checkoutId: \$checkoutId, lineItemIds: \$lineItemIds) {
        userErrors {
          message
          field
        }
        checkout {
          $_checkout
        }
      }
    }
  ''';


  Future<QueryResult> associateCustomerCheckout(
      String checkoutId, String customerAccessToken) async {
    final queryOptions = QueryOptions(
      documentNode: gql(_checkoutCustomerAssociate),
      variables: <String, dynamic>{
        'checkoutId': checkoutId,
        'customerAccessToken': customerAccessToken,
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    final queryResult = await _client.query(queryOptions);
    return queryResult;
  }

  Future<QueryResult> disassociateCustomerCheckout(String checkoutId) async {
    final queryOptions = QueryOptions(
      documentNode: gql(_checkoutCustomerDisassociate),
      variables: <String, dynamic>{
        'checkoutId': checkoutId,
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    final queryResult = await _client.query(queryOptions);
    return queryResult;
  }

  Future<QueryResult> getCheckout(String checkoutId) async {
    final queryOptions = QueryOptions(
      documentNode: gql(_getCheckoutQuery),
      variables: <String, dynamic>{
        'checkoutId': checkoutId,
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    final queryResult = await _client.query(queryOptions);
    return queryResult;
  }

  Future<QueryResult> replaceLineItems(
      String checkoutId, List<Map<String, dynamic>> lineItems) async {
    final queryOptions = QueryOptions(
      documentNode: gql(_replaceLineItemsMutation),
      variables: <String, dynamic>{
        'checkoutId': checkoutId,
        'lineItems': lineItems,
      },
      fetchPolicy: FetchPolicy.noCache,
    );
    final queryResult = await _client.query(queryOptions);
    return queryResult;
  }

  bool isValidCheckoutCreate(QueryResult queryResult) {
    if (!queryResultDataExists(queryResult)) {
      return false;
    }
    if (queryResult.data['checkoutCreate'] == null) {
      return false;
    }
    if (queryResult.data['checkoutCreate']['checkout'] == null) {
      return false;
    }
    return true;
  }

  bool isValidGetCheckout(QueryResult queryResult) {
    if (!queryResultDataExists(queryResult)) {
      return false;
    }
    if (queryResult.data['node'] == null) {
      return false;
    }
    if (queryResult.data['node']['id'] == null) {
      return false;
    }
    return true;
  }

  bool isValidCheckoutLineItemsAdd(QueryResult queryResult) {
    if (!queryResultDataExists(queryResult)) {
      return false;
    }
    if (queryResult.data['checkoutLineItemsAdd'] == null) {
      return false;
    }
    if (queryResult.data['checkoutLineItemsAdd']['checkout'] == null) {
      return false;
    }
    return true;
  }

  bool isValidCheckoutLineItemsReplace(QueryResult queryResult) {
    if (!queryResultDataExists(queryResult)) {
      return false;
    }
    if (queryResult.data['checkoutLineItemsReplace'] == null) {
      return false;
    }
    if (queryResult.data['checkoutLineItemsReplace']['checkout'] == null) {
      return false;
    }
    return true;
  }

  bool isValidCheckoutLineItemsRemove(QueryResult queryResult) {
    if (!queryResultDataExists(queryResult)) {
      return false;
    }
    if (queryResult.data['checkoutLineItemsRemove'] == null) {
      return false;
    }
    if (queryResult.data['checkoutLineItemsRemove']['checkout'] == null) {
      return false;
    }
    return true;
  }

  bool isValidCheckoutCustomerAssociate(QueryResult queryResult) {
    if (!queryResultDataExists(queryResult)) {
      return false;
    }
    if (queryResult.data['checkoutCustomerAssociate'] == null) {
      return false;
    }
    if (queryResult.data['checkoutCustomerAssociate']['checkout'] == null) {
      return false;
    }
    return true;
  }

  bool isValidCheckoutCustomerDisassociate(QueryResult queryResult) {
    if (!queryResultDataExists(queryResult)) {
      return false;
    }
    if (queryResult.data['checkoutCustomerDisassociate'] == null) {
      return false;
    }
    if (queryResult.data['checkoutCustomerDisassociate']['checkout'] == null) {
      return false;
    }
    return true;
  }

  static const String _getCheckoutQuery = '''
    query getCheckout(\$checkoutId: ID!) {
      node(id: \$checkoutId){
        ... on Checkout {
          $_checkout
        }
      }
    }
  ''';

  static const String _replaceLineItemsMutation = '''
    mutation checkoutLineItemsReplace(\$lineItems: [CheckoutLineItemInput!]!, \$checkoutId: ID!) {
      checkoutLineItemsReplace(lineItems: \$lineItems, checkoutId: \$checkoutId) {
        userErrors {
          message
          field
        }
        checkout {
          $_checkout
        }
      }
    }
  ''';

  static const String _checkoutCustomerAssociate = '''
    mutation checkoutCustomerAssociateV2(\$checkoutId: ID!, \$customerAccessToken: String!) {
      checkoutCustomerAssociate(checkoutId: \$checkoutId, customerAccessToken: \$customerAccessToken) {
        userErrors {
          field
          message
        }
        checkout {
          $_checkout
        }
      }
    }
  ''';

  static const String _checkoutCustomerDisassociate = '''
    mutation checkoutCustomerDisassociate(\$checkoutId: ID!) {
      checkoutCustomerDisassociate(checkoutId: \$checkoutId) {
        userErrors {
          field
          message
        }
        checkout {
          $_checkout
        }
      }
    }
  ''';

  // ProductとVariantが一対一対応になるようにしている
  static const _checkout = '''
    id
    webUrl
    totalTax
    subtotalPrice
    totalPrice
    shippingAddress {
      address1
      address2
      city
      country
      firstName
      lastName
      phone
      province
      zip
    }
    lineItems (first: 250) {
      edges {
        node {
          id
          title          
          quantity
          variant {
            product {
              $_productNode
            }
          }
        }
      }
    }
  ''';

  static const _productNode = r'''
    id
    availableForSale
    title
    productType
    vendor
    variants(first: 250) {
      pageInfo {
        hasNextPage
        hasPreviousPage
      }
      edges {
        node {
          id
          title
          selectedOptions {
            name
            value
          }
          image {
            src
          }
          price
        }
      }
    }
    images(first: 10) {
      edges {
        node {
          src
        }
      }
    }
    priceRange {
      maxVariantPrice {
        amount
        currencyCode
      }
    }
    metafields(namespace: "global", first: 10) {
      edges {
        node {
          key
          value
          id
        }
      }
    }
    description(truncateAt: 50000)
    descriptionHtml
    tags
  ''';
}
