import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtest_guia_motel/data/provider/home_page_provider.dart';

class CustomSwitcher extends StatelessWidget {
  final ScreenSwitch chooseScreen;
  final String label;
  final IconData icon;

  const CustomSwitcher({
    super.key,
    required this.chooseScreen,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final HomePageProvider provider = context.read<HomePageProvider>();
    bool isSelected = provider.chooseScreen == chooseScreen;

    return GestureDetector(
      onTap: () => provider.chooseScreen = chooseScreen,
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (Widget child, Animation<double> animation) {
          final offsetAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
        child: isSelected
            ? Container(
                key: ValueKey(chooseScreen),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  spacing: 3,
                  children: [
                    Icon(
                      icon,
                      color: isSelected ? Color(0xFFd11621) : Colors.white,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              )
            : Container(
                key: ValueKey(chooseScreen),
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: Row(
                  spacing: 3,
                  children: [
                    Icon(
                      icon,
                      color: isSelected ? Color(0xFFd11621) : Colors.white,
                    ),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
