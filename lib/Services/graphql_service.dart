
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {

  static final HttpLink httpLink = HttpLink(uri: "http://14.40.12.135:4000/");
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(link: httpLink as Link, cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject))
  );
}

final graphqlService = GraphqlService();