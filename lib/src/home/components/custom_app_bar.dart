import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtest_guia_motel/data/provider/home_page_provider.dart';
import 'package:techtest_guia_motel/src/home/components/custom_switcher.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 10,
      backgroundColor: Color(0xFFd11621),
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      title: Consumer<HomePageProvider>(
        builder: (context, provider, _) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            color: Colors.black.withAlpha(30),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomSwitcher(
                selected: ScreenSwitch.IRAGORA,
                label: 'Ir Agora',
                icon: Icons.flash_on,
              ),
              CustomSwitcher(
                selected: ScreenSwitch.IROUTRODIA,
                label: 'Ir outro dia',
                icon: Icons.calendar_today,
              )
            ],
          ),
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
}
