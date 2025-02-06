import 'package:flutter/material.dart';

class FilterOptions extends StatelessWidget {
  final Function(String) onFilterSelected;
  final List<String> filters = [
    "Filtros",
    "Com Desconto",
    "Disponíveis",
    "Hidro"
  ];

  FilterOptions({super.key, required this.onFilterSelected});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: filters
              .map(
                (filter) => GestureDetector(
                  onTap: () => onFilterSelected(filter),
                  child: Chip(label: Text(filter), ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
