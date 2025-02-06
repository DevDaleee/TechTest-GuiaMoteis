import 'package:flutter/material.dart';

class LocationFilter extends StatelessWidget {
  const LocationFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: OutlinedButton.icon(
        onPressed: () {},
        style: ButtonStyle(),
        icon: Icon(Icons.arrow_drop_down),
        iconAlignment: IconAlignment.end,
        label: Text(
          'Zona Norte',
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
