
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class GraphqlService {

  static final HttpLink httpLink = HttpLink(uri: "http://본인 ip주소:4000/");
  final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
    GraphQLClient(link: httpLink as Link, cache: OptimisticCache(
        dataIdFromObject: typenameDataIdFromObject))
  );
}

final graphqlService = GraphqlService();