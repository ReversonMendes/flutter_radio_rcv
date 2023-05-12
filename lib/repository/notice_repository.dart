import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/failure_model.dart';
import '../models/item_model.dart';

class NoticeRepository {
  static const String _baseUrl = 'https://api.notion.com/v1/';

  final http.Client _client;

  NoticeRepository({http.Client? client}) : _client = client ?? http.Client();

  void dispose() {
    _client.close();
  }

  Future<List<Item>> getItems() async {
    try {
      await dotenv.load(fileName: ".env");
      final url =
          '${_baseUrl}databases/${dotenv.env['NOTION_DATABASE_ID']}/query';
      Map map = {
        'filter': {
          'property': 'Tags',
          'select': {'equals': 'publicado'}
        },
      };

      final response = await _client.post(Uri.parse(url),
          headers: {
            HttpHeaders.authorizationHeader:
                'Bearer ${dotenv.env['NOTION_API_KEY']}',
            'Notion-Version': '2022-02-22',
            "Content-Type": "application/json"
          },
          body: json.encode(map));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as Map<String, dynamic>;
        return (data['results'] as List).map((e) => Item.fromMap(e)).toList()
          ..sort((a, b) => b.date.compareTo(a.date));
      } else {
        throw const Failure(
            message:
                'Algo deu errado,\n verifique a sua conexão com a Internet!');
      }
    } catch (_) {
      throw const Failure(
          message:
              'Algo deu errado,\n verifique a sua conexão com a Internet!');
    }
  }
}
