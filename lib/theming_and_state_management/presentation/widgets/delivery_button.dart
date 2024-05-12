import 'package:flutter/material.dart';

import 'package:delivery_app/theming_and_state_management/presentation/theme.dart';

class DeliveryButton extends StatelessWidget {
  const DeliveryButton({Key? key, required this.onTap, this.text, this.padding})
      : super(key: key);

  final VoidCallback onTap;
  final String? text;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: deliveryGradients,
          ),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(14.0),
          child: Text(
            text ?? '',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
