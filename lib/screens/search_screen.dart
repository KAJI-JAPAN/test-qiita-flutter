import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:qiita_api_test_app/models/article.dart';
import 'package:http/http.dart' as http; // httpという変数を通して、httpパッケージにアクセス

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Qiita Search'),
      ),
      body: Container(),
    );
  }

  Future<List<Article>> searchQiita(String keyword) async {
    final uri = Uri.http('qiita.com', 'api/v2/items', {
      'query': 'title: $keyword',
      'per_page': '10',
    });
    final String token = dotenv.env['QIITA_ACCESS_TOKEN'] ?? '';
    final http.Response res = await http.get(uri, headers: {
      'Authorization': 'Bearer $token',
    });
    if (res.statusCode == 200) {
      final List<dynamic> body = jsonDecode(res.body);
      return body.map((dynamic json) => Article.fromjson(json)).toList();
    } else {
      return [];
    }
  }
}
