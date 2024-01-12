import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:rede_inova/interfaces/pages/home.page.dart';
import 'dart:convert';
import 'package:rede_inova/interfaces/pages/links.page.dart';
import 'package:rede_inova/interfaces/widgets/botao_padrao.widget.dart';
import 'package:rede_inova/interfaces/widgets/input_texto_padrao.widget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  bool esconderTexto = true;

  Future<void> _login() async {
    final String login = _loginController.text.trim();
    final String senha = _senhaController.text.trim();

    try {
      final response = await http.post(
        Uri.parse('https://coretoolshomologaapi.redeinova.com.br/api/auth'),
        body: jsonEncode({'login': login, 'senha': senha}),
        headers: <String, String>{'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        _loginController.clear();
        _senhaController.clear();
        _navegarParaHomePage(data['signature']);
      } else {
        _mensagemBar('Falha no login. Verifique suas credenciais!');
      }
    } catch (e) {
      _mensagemBar('Erro: $e');
    }
  }

  void _mensagemBar(String mensagem) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(mensagem),
      ),
    );
  }

  void _navegarParaHomePage(String token) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
          token: token,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/img.png', width: 100),
              const SizedBox(height: 48),
              InputTextoPadrao(
                controller: _senhaController,
                labelInput: 'Login',
                hintText: 'Digite o nome de usuário',
              ),
              const SizedBox(height: 16),
              InputTextoPadrao(
                controller: _senhaController,
                labelInput: 'Senha',
                hintText: 'Digite a senha',
                senha: true,
              ),
              const SizedBox(height: 32),
              BotaoPadraoWidget(label: 'Entrar', onPressed: _login, cor: const Color(0xFF077EFB)),
            ],
          ),
        ),
      ),
    );
  }
}
