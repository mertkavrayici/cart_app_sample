import 'package:flutter/material.dart';

class ShoppingButton extends StatefulWidget {
  final VoidCallback onTap;
  final String text;
  const ShoppingButton({super.key, required this.onTap, required this.text});

  @override
  State<ShoppingButton> createState() => _ShoppingButtonState();
}

class _ShoppingButtonState extends State<ShoppingButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.pink[200]),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 20, bottom: 20, left: 100, right: 100),
          child: Text(
            widget.text,
            style: const TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
