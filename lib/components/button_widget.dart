import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  ButtonWidget(
      {required this.tittleButton,
      required this.onPressed,
      this.isLoading = false});
  final String tittleButton;
  final bool isLoading;
  final Function onPressed;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.isLoading ? Colors.grey : Colors.white,
      borderRadius: const BorderRadius.horizontal(
          left: Radius.circular(5.0), right: Radius.circular(5.0)),
      child: MaterialButton(
        minWidth: double.infinity,
        onPressed: () => {widget.isLoading ? null : widget.onPressed()},
        child: widget.isLoading
            ? MyProgressIndicator()
            : TextTitleButton(widget: widget),
      ),
    );
  }
}

class TextTitleButton extends StatelessWidget {
  const TextTitleButton({
    super.key,
    required this.widget,
  });

  final ButtonWidget widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.tittleButton,
      style: const TextStyle(color: Colors.black),
    );
  }
}

class MyProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
    );
  }
}
