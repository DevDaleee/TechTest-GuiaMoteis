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
  List<MotelModel>? motelsWithDiscount = [];
  String selectedFilter = "";
  int carouselLenght = 0;
  int carouselCurrent = 0;
  final CarouselSliderController _controller = CarouselSliderController();

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

      carouselLenght = motelsWithDiscount!.length;
      carouselCurrent = carouselLenght ~/ 2;

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

  Future<void> _onRefresh() async {
    await fetchMotels();
    await Future.delayed(Duration(seconds: 5));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          RefreshIndicator(
            onRefresh: _onRefresh,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Flex(
                direction: Axis.vertical,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 60,
                    color: Color(0xFFd11621),
                    child: LocationFilter(),
                  ),
                  Expanded(
                    flex: 0,
                    child: Container(
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
                            itemBuilder: (BuildContext context, int index, _) {
                              final motel = motelsWithDiscount![index];
                              final bestPeriod = motel.suites!
                                  .expand((suite) => suite.periods!)
                                  .map((period) {
                                final discountedPrice = period.discount != null
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
                                  imageUrl: motel.logoUrl,
                                  name: motel.name,
                                  location: motel.neighborhood,
                                  prcDiscont: bestPeriod["discount"],
                                  discount: bestPeriod["price"],
                                ),
                              );
                            },
                          ),
                          Container(
                            width: 12,
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
                                  FilterChip(
                                      label: Text("com desconto"),
                                      onSelected: (_) {}),
                                  SizedBox(width: 8),
                                  FilterChip(
                                      label: Text("disponíveis"),
                                      onSelected: (_) {}),
                                  SizedBox(width: 8),
                                  FilterChip(
                                      label: Text("hidro"), onSelected: (_) {}),
                                ],
                              ),
                            ),
                          ),
                          Divider(
                            color: Colors.grey.withAlpha(60),
                          ),
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
                  ),
                ],
              ),
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
    );
  }
}
