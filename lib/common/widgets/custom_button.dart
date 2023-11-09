import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color,
  });

  final String text;
  final Color? color;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white54,
              Colors.orange.shade50,
            ]).createShader(bounds);
      },
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color,
            side: const BorderSide(color: Colors.black26, width: 2),
            minimumSize: const Size(double.infinity, 50)),
        child: Text(
          text,
          style: TextStyle(
              color: color == null ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
