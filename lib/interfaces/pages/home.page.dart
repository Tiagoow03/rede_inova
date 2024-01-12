import 'package:flutter/material.dart';
import 'package:rede_inova/interfaces/pages/links.page.dart';
import 'package:rede_inova/interfaces/widgets/botao_padrao.widget.dart';

class HomePage extends StatefulWidget {
  final String token;

  const HomePage({super.key, required this.token});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _navegarParaLinksPage(String token) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LinksPage(
          token: token,
        ),
      ),
    );
  }

  void _voltarParaLoginPage() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Bem vindo!',
                style: TextStyle(fontSize: 24),
              ),
              const Text(
                'Escolhar por onde começar:',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              BotaoPadraoWidget(
                label: 'Listar links',
                onPressed: () => _navegarParaLinksPage(widget.token),
                cor: const Color(0xFF077EFB),
              ),
              const SizedBox(height: 16),
              BotaoPadraoWidget(
                label: 'Sair',
                onPressed: () => _voltarParaLoginPage(),
                cor: const Color(0xFF077EFB),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
