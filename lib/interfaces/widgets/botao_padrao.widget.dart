import 'package:flutter/material.dart';

class BotaoPadraoWidget extends StatelessWidget {
  const BotaoPadraoWidget({
    super.key,
    this.onPressed,
    this.cor,
    required this.label,
  });

  final Function()? onPressed;
  final String label;
  final Color? cor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          primary: cor ?? const Color(0xFFFFFFFF),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          shadowColor: Colors.black,
          elevation: 5,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            label,
            style: const TextStyle(color: Color(0xFFFFFFFF), fontSize: 16),
          ),
        ),
      ),
    );
  }
}
