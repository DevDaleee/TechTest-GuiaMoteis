import 'package:flutter/material.dart';
import 'package:techtest_guia_motel/models/motel_model.dart';
import 'package:techtest_guia_motel/services/moteis.dart';
import 'package:techtest_guia_motel/src/home/components/filter_options.dart';
import 'package:techtest_guia_motel/src/home/components/hotel_card.dart';
import 'package:techtest_guia_motel/src/home/components/location_filter.dart';
import 'package:techtest_guia_motel/src/home/components/promo_card.dart';
import 'package:techtest_guia_motel/src/home/components/tiles.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<MotelModel> motels = [];
  List<MotelModel>? motelsWithDiscount = [];
  String selectedFilter = "";

  @override
  void initState() {
    super.initState();
    fetchMotels().then((_) {
      setState(() {});
    });
  }

  Future<void> fetchMotels() async {
    try {
      motels = await MotelServices.getAllMotels();

      if (motels.isNotEmpty) {
        debugPrint("Total de motéis carregados: ${motels.length}");
      } else {
        debugPrint("Nenhum motel carregado");
      }

      motelsWithDiscount = motels
          .where((motel) =>
              motel.suites?.any((suite) =>
                  suite.periods
                      ?.any((p) => p.discount != null && p.discount! > 0) ??
                  false) ??
              false)
          .toList();

      setState(() {});
    } catch (e) {
      debugPrint("Erro ao carregar motéis: $e");
    }
  }

  void applyFilter(String filter) {
    setState(() {
      selectedFilter = filter;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFd11621),
      ),
      drawer: Drawer(
        surfaceTintColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.zero),
        ),
        backgroundColor: Color(0xFFFFF8F6),
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Center(
                child: LocationFilter(),
              ),
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: motelsWithDiscount!.length,
                itemBuilder: (context, index) {
                  final motel = motelsWithDiscount![index];
                  final discount = motel.suites![index].periods
                      ?.firstWhere((p) => p.discount != null && p.discount! > 0)
                      .discount;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: PromoCard(
                      imageUrl: motel.imageUrl,
                      name: motel.name,
                      location: motel.neighborhood,
                      discount: discount,
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                        label: Row(
                          children: [
                            Icon(
                              Icons.tune,
                              color: Colors.black.withAlpha(
                                150,
                              ),
                            ),
                            Text("filtros"),
                          ],
                        ),
                        onSelected: (_) {}),
                    SizedBox(width: 8),
                    FilterChip(label: Text("com desconto"), onSelected: (_) {}),
                    SizedBox(width: 8),
                    FilterChip(label: Text("disponíveis"), onSelected: (_) {}),
                    SizedBox(width: 8),
                    FilterChip(label: Text("hidro"), onSelected: (_) {}),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: motels.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: HotelCard(
                    filter: "",
                    motel: motels[index],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
