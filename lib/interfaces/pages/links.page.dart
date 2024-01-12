import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class LinksPage extends StatefulWidget {
  final String token;

  const LinksPage({super.key, required this.token});

  @override
  _LinksPageState createState() => _LinksPageState();
}

class _LinksPageState extends State<LinksPage> {
  List<dynamic> _links = [];
  bool _isLoading = false;

  Future<void> _fetchLinks() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final response = await http.get(
        Uri.parse(
            'https://coretoolshomologaapi.redeinova.com.br/api/links?guidid=EB8DA9CA-D0FD-4A4E-ADAE-3AB251E98C50'),
        headers: <String, String>{
          'Authorization': 'Bearer ${widget.token}',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        await Future.delayed(const Duration(seconds: 1)); //simular delay de 1 segundo
        setState(() {
          _links = data['links'];
          _isLoading = false;
        });
      } else {
        _mensagemBar('Falha ao carregar os links!');
        setState(() {
          _isLoading = false;
        });
      }
    } catch (e) {
      _mensagemBar('Erro: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _mensagemBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _fetchLinks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Links')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _links.length,
              itemBuilder: (context, index) {
                final link = _links[index];
                return ListTile(
                  title: Text(link['titulo']),
                  subtitle: Text(link['comando']),
                  leading: const Icon(Icons.link),
                  onTap: () {},
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _fetchLinks,
        backgroundColor: const Color(0xFF077EFB),
        child: const Icon(
          Icons.refresh,
          color: Color(0xFFFFFFFF),
        ),
      ),
    );
  }
}
