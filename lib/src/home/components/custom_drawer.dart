import 'package:flutter/material.dart';
import 'package:techtest_guia_motel/src/home/components/tiles.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        width: MediaQuery.of(context).size.width * 0.8,
        child: Expanded(
          child: Column(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFFF524c),
                      Color(0xFFFD2D50),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {},
                        child: Row(
                          children: [
                            SizedBox(width: 6),
                            Icon(
                              Icons.check_box_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                            Text(
                              'go fidelidade',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                              ),
                            ),
                            SizedBox(width: 10),
                            Icon(
                              Icons.arrow_right_rounded,
                              color: Colors.white,
                              size: 25,
                            )
                          ],
                        ),
                      ),
                      Text(
                        'Acumule selinhos e troque por reservas\ngrátis. vale em todos os motéis e horários',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  DrawerTile(
                    icon: Icons.person_outline_rounded,
                    text: "Login",
                  ),
                  DrawerTile(
                    icon: Icons.support_outlined,
                    text: "Ajuda",
                  ),
                  DrawerTile(
                    icon: Icons.settings_outlined,
                    text: "Configurações",
                  ),
                  DrawerTile(
                    icon: Icons.bug_report_outlined,
                    text: "Comunicar Problema",
                  ),
                  DrawerTile(
                    icon: Icons.campaign_outlined,
                    text: "Tem um motel? Faça parte",
                  ),
                ],
              )
            ],
          ),
        ),
      );
  }
}