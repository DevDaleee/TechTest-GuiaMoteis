import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:techtest_guia_motel/models/motel_model.dart';
import 'package:techtest_guia_motel/services/moteis.dart';
import 'package:techtest_guia_motel/src/home/components/custom_app_bar.dart';
import 'package:techtest_guia_motel/src/home/components/custom_drawer.dart';
import 'package:techtest_guia_motel/src/home/components/hotel_card.dart';
import 'package:techtest_guia_motel/src/home/components/location_filter.dart';
import 'package:techtest_guia_motel/src/home/components/promo_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<MotelModel> motels = [];
  List<MotelModel> filteredMotels = [];
  List<MotelModel>? motelsWithDiscount = [];
  String selectedFilter = "todos";
  int carouselLenght = 0;
  int carouselCurrent = 0;
  final CarouselSliderController _controller = CarouselSliderController();

  @override
  void initState() {
    super.initState();
    fetchMotels().then((_) {
      setState(() {
        applyFilter('todos');
      });
    });
  }

  Future<void> fetchMotels() async {
    try {
      List<MotelModel> fetchedMotels = await MotelServices.getAllMotels();

      if (fetchedMotels.isNotEmpty) {
        debugPrint("Total de motéis carregados: ${fetchedMotels.length}");
      } else {
        debugPrint("Nenhum motel carregado");
      }

      List<MotelModel> discountMotels = fetchedMotels
          .where((motel) =>
              motel.suites?.any((suite) =>
                  suite.periods
                      ?.any((p) => p.discount != null && p.discount! > 0) ??
                  false) ??
              false)
          .toList();

      setState(() {
        motels = fetchedMotels;
        motelsWithDiscount = discountMotels;
        applyFilter('todos');
      });
    } catch (e) {
      debugPrint("Erro ao carregar motéis: $e");
    }
  }

  void applyFilter(String filter) {
    debugPrint("Aplicando filtro: $filter");

    List<MotelModel> tempList = [];

    if (filter == "com desconto") {
      tempList = motelsWithDiscount ?? [];
    } else if (filter == "disponíveis") {
      tempList = motels.where((motel) {
        return motel.suites != null &&
            motel.suites!.isNotEmpty &&
            motel.suites!
                .any((suite) => suite.quantity != null && suite.quantity! > 0);
      }).toList();
    } else {
      tempList = List.from(motels);
    }

    debugPrint(
        "Motéis filtrados (${tempList.length}): ${tempList.map((e) => e.name).toList()}");

    setState(() {
      selectedFilter = filter;
      filteredMotels = tempList;
    });
  }

  Future<void> _onRefresh() async {
    await fetchMotels().then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white.withAlpha(500),
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Expanded(
        child: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              padding: EdgeInsets.only(top: 70),
              child: RefreshIndicator(
                onRefresh: _onRefresh,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: Column(
                          children: [
                            CarouselSlider.builder(
                              carouselController: _controller,
                              options: CarouselOptions(
                                height: 200,
                                viewportFraction: 4,
                                enableInfiniteScroll: false,
                                onPageChanged: (index, reason) {
                                  setState(() {
                                    carouselCurrent = index;
                                  });
                                },
                              ),
                              itemCount: motelsWithDiscount!.length,
                              itemBuilder:
                                  (BuildContext context, int index, _) {
                                final motel = motelsWithDiscount![index];
                                final bestPeriod = motel.suites!
                                    .expand((suite) => suite.periods!)
                                    .map((period) {
                                  final discountedPrice =
                                      period.discount != null
                                          ? period.price! - period.discount!
                                          : period.price;
                                  return {
                                    "price": discountedPrice,
                                    "originalPrice": period.price,
                                    "discount": period.discount ?? 0,
                                  };
                                }).reduce((curr, next) =>
                                        curr["price"]! < next["price"]!
                                            ? curr
                                            : next);

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10.0),
                                  child: PromoCard(
                                    imageUrl: motel.suites!.last.photos!.first,
                                    name: motel.name,
                                    location: motel.neighborhood,
                                    prcDiscont: bestPeriod["discount"],
                                    discount: bestPeriod["price"],
                                  ),
                                );
                              },
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 12,
                              margin: EdgeInsets.symmetric(
                                  vertical: 8, horizontal: 4),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black.withAlpha(
                                  carouselLenght == carouselCurrent ? 900 : 400,
                                ),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  spacing: 8,
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
                                      onSelected: (_) {},
                                    ),
                                    FilterChip(
                                      label: Text("com desconto"),
                                      selected:
                                          selectedFilter == 'com desconto',
                                      onSelected: (_) =>
                                          applyFilter("com desconto"),
                                    ),
                                    FilterChip(
                                      label: Text("disponíveis"),
                                      selected: selectedFilter == 'disponíveis',
                                      onSelected: (_) =>
                                          applyFilter("disponíveis"),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Divider(
                              color: Colors.grey.withAlpha(60),
                            ),
                            //TODO CONSERTAR O RENDER DESSE CARA AQ, TÁ FALTANDO ESPAÇO
                            Column(
                              children: [
                                Expanded(
                                  flex: 0,
                                  child: filteredMotels.isEmpty
                                      ? Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Center(
                                            child: Text(
                                              'Nenhum motel encontrado para este filtro.',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        )
                                      : ListView.builder(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          itemCount: filteredMotels.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 8.0,
                                                horizontal: 16.0,
                                              ),
                                              child: HotelCard(
                                                filter: selectedFilter,
                                                motel: filteredMotels[index],
                                              ),
                                            );
                                          },
                                        ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 60,
                color: Color(0xFFd11621),
                child: LocationFilter(),
              ),
            ),
            Positioned(
              bottom: 20,
              left: MediaQuery.of(context).size.width * 0.36,
              right: MediaQuery.of(context).size.width * 0.36,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_outlined, color: Colors.red),
                    SizedBox(width: 5),
                    Text(
                      'Mapa',
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
