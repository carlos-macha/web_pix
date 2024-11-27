import 'package:flutter/material.dart';

class TextFields extends StatefulWidget {
  const TextFields({super.key, required this.text, required this.onChanged});
  final text;
  final ValueChanged<String> onChanged;

  @override
  State<TextFields> createState() => _TextFieldsState();
}

class _TextFieldsState extends State<TextFields> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (texto) {
        setState(
          () {
            widget.onChanged(texto);
          },
        );
      },
      maxLines: 1,
      minLines: 1,
      scrollController: ScrollController(),
      style: TextStyle(
        color: Color(0xFFE0E0E0),
      ),
      cursorColor: Color(0xFFE0E0E0),
      decoration: InputDecoration(
        labelText: widget.text,
        labelStyle: TextStyle(
          color: Color.fromARGB(113, 224, 224, 224),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: Color(0xFFE0E0E0),
              width: 2), // Cor da linha quando em foco
        ),
      ),
    );
  }
}
