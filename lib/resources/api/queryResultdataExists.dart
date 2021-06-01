import 'package:graphql_flutter/graphql_flutter.dart';

bool queryResultDataExists(QueryResult queryResult) {
  if (queryResult.hasException) {
    return false;
  }
  if (queryResult.data == null) {
    return false;
  }
  return true;
}
