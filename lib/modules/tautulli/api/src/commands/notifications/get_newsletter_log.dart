part of tautulli_commands;

Future<TautulliNewsletterLogs> _commandGetNewsletterLog(
  Dio client, {
  TautulliNewsletterLogOrderColumn? orderColumn,
  TautulliOrderDirection? orderDirection,
  int? start,
  int? length,
  String? search,
}) async {
  Response response = await client.get(
    '/',
    queryParameters: {
      'cmd': 'get_newsletter_log',
      if (orderColumn != null &&
          orderColumn != TautulliNewsletterLogOrderColumn.NULL)
        'order_column': orderColumn.value,
      if (orderDirection != null &&
          orderDirection != TautulliOrderDirection.NULL)
        'order_dir': orderDirection.value,
      if (start != null) 'start': start,
      if (length != null) 'length': length,
      if (search != null) 'search': search,
    },
  );
  switch ((response.data['response']['result'] as String?)) {
    case 'success':
      return TautulliNewsletterLogs.fromJson(response.data['response']['data']);
    case 'error':
    default:
      throw Exception(response.data['response']['message']);
  }
}
