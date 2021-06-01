import 'package:graphql_flutter/graphql_flutter.dart';
import 'graphqlClient.dart';

class ProductAPI {
  const ProductAPI();

  GraphQLClient get _client => const ShopifyGraphQLClient().graphQLClient;

  Future<QueryResult> getProducts(int amount) async {
    final queryOptions = QueryOptions(documentNode: gql(query(amount)));
    final queryResult = await _client.query(queryOptions);
    return queryResult;
  }

  static String query(int amount) => '''
query {
  products(first:5) {
    edges {
      node {
        id
        title
        variants(first:5) {
          edges {
            node {
              id
              title
              price
              image {
                src
              }
            }
          }
        }
      }
    }
  }
}
  ''';
}
