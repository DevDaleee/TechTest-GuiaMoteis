import 'package:flutter/material.dart';

class LocationFilter extends StatelessWidget {
  const LocationFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(
        Icons.keyboard_arrow_down,
        color: Colors.white,
      ),
      iconAlignment: IconAlignment.end,
      label: Text(
        'Zona Norte',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
