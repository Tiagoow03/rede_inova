import 'package:flutter/material.dart';

class InputTextoPadrao extends StatefulWidget {
  const InputTextoPadrao({
    super.key,
    required this.controller,
    required this.labelInput,
    required this.hintText,
    this.senha = false,
  });

  final TextEditingController controller;
  final String labelInput;
  final String hintText;
  final bool senha;

  @override
  State<InputTextoPadrao> createState() => _InputTextoPadraoState();
}

class _InputTextoPadraoState extends State<InputTextoPadrao> {
  bool esconderTexto = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.labelInput, style: const TextStyle(fontSize: 14)),
        const SizedBox(height: 4),
        SizedBox(
          height: 50,
          child: TextField(
            controller: widget.controller,
            decoration: InputDecoration(
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                color: Color(0xFF6F6F6F),
                fontSize: 14,
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0x48000000), width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Color(0xFF696969), width: 1.5),
                borderRadius: BorderRadius.circular(10),
              ),
              suffixIcon: widget.senha
                  ? MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => setState(() {
                          esconderTexto = !esconderTexto;
                        }),
                        child: Icon(
                          esconderTexto ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                        ),
                      ),
                    )
                  : null,
            ),
            obscureText: widget.senha ? esconderTexto : false,
          ),
        ),
      ],
    );
  }
}
