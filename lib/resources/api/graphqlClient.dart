import 'package:graphql/client.dart';
import 'links.dart';

class ShopifyGraphQLClient {
  const ShopifyGraphQLClient();

  GraphQLClient _generateClient(String uri, String apiToken) {
    final link = HttpLink(uri: uri, headers: <String, String>{
      'X-Shopify-Storefront-Access-Token': apiToken
    });

    final client = GraphQLClient(
      cache: InMemoryCache(),
      link: link,
    );

    return client;
  }

  GraphQLClient get _otteGraphQLClient =>
      _generateClient(otteApiUrl, otteApiToken);

  GraphQLClient get _otteAppGraphQLClient =>
      _generateClient(otteApiUrl, otteApiToken);

  GraphQLClient get graphQLClient => (const bool.fromEnvironment('otte') ||
          const bool.fromEnvironment('dart.vm.product'))
      ? _otteGraphQLClient
      : _otteAppGraphQLClient;
}
