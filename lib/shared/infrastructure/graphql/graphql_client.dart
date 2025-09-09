import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:robbie_starter/core/utils/logger.dart';

/// GraphQL client configuration and management
@singleton
class GraphQLClientService {
  GraphQLClientService() {
    _initializeClients();
  }

  late final GraphQLClient _spaceXClient;
  late final GraphQLClient _countriesClient;
  late final GraphQLClient _rickAndMortyClient;

  /// SpaceX GraphQL client
  GraphQLClient get spaceXClient => _spaceXClient;

  /// Countries GraphQL client
  GraphQLClient get countriesClient => _countriesClient;

  /// Rick and Morty GraphQL client
  GraphQLClient get rickAndMortyClient => _rickAndMortyClient;

  void _initializeClients() {
    // SpaceX API client
    _spaceXClient = _createClient(
      endpoint: 'https://api.spacex.land/graphql/',
      clientName: 'SpaceX',
    );

    // Countries API client
    _countriesClient = _createClient(
      endpoint: 'https://countries.trevorblades.com/',
      clientName: 'Countries',
    );

    // Rick and Morty API client
    _rickAndMortyClient = _createClient(
      endpoint: 'https://rickandmortyapi.com/graphql',
      clientName: 'RickAndMorty',
    );
  }

  GraphQLClient _createClient({
    required String endpoint,
    required String clientName,
  }) {
    final httpLink = HttpLink(endpoint);

    final link = Link.from([
      httpLink,
    ]);

    return GraphQLClient(
      link: link,
      cache: GraphQLCache(store: InMemoryStore()),
      defaultPolicies: DefaultPolicies(
        query: Policies(
          fetch: FetchPolicy.cacheAndNetwork,
          error: ErrorPolicy.all,
          cacheReread: CacheRereadPolicy.mergeOptimistic,
        ),
        mutate: Policies(
          fetch: FetchPolicy.networkOnly,
          error: ErrorPolicy.all,
        ),
      ),
    );
  }

  /// Execute a query with error handling
  Future<QueryResult<Object?>> query({
    required GraphQLClient client,
    required String query,
    Map<String, dynamic>? variables,
    String? operationName,
  }) async {
    try {
      final options = QueryOptions(
        document: gql(query),
        variables: variables ?? {},
        operationName: operationName,
      );

      final result = await client.query(options);

      if (result.hasException) {
        Logger.error('GraphQL Query Exception: ${result.exception}');
      }

      return result;
    } catch (e) {
      Logger.error('GraphQL Query Error: $e');
      rethrow;
    }
  }

  /// Execute a mutation with error handling
  Future<QueryResult<Object?>> mutate({
    required GraphQLClient client,
    required String mutation,
    Map<String, dynamic>? variables,
    String? operationName,
  }) async {
    try {
      final options = MutationOptions(
        document: gql(mutation),
        variables: variables ?? {},
        operationName: operationName,
      );

      final result = await client.mutate(options);

      if (result.hasException) {
        Logger.error('GraphQL Mutation Exception: ${result.exception}');
      }

      return result;
    } catch (e) {
      Logger.error('GraphQL Mutation Error: $e');
      rethrow;
    }
  }
}
