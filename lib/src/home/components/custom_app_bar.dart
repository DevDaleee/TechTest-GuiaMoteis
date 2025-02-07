import 'package:flutter/material.dart';
import 'package:techtest_guia_motel/data/provider/home_page_provider.dart';
import 'package:techtest_guia_motel/src/home/components/custom_switcher.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFFd11621),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(22),
          color: Colors.black.withAlpha(30),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomSwitcher(
              chooseScreen: ScreenSwitch.iragora,
              label: 'Ir Agora',
              icon: Icons.flash_on,
            ),
            CustomSwitcher(
              chooseScreen: ScreenSwitch.iroutrodia,
              label: 'Ir outro dia',
              icon: Icons.calendar_today,
            )
          ],
        ),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.search, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
