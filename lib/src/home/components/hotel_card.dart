import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techtest_guia_motel/data/provider/home_page_provider.dart';
import 'package:techtest_guia_motel/models/category_item_models.dart';
import 'package:techtest_guia_motel/models/motel_model.dart';
import 'package:techtest_guia_motel/services/utils.dart';
import 'package:techtest_guia_motel/src/home/components/suites_card.dart';

class HotelCard extends StatelessWidget {
  final String filter;
  final MotelModel motel;

  const HotelCard({
    super.key,
    required this.filter,
    required this.motel,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<HomePageProvider>(
      builder: (context, provider, _) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(
                    motel.logoUrl ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      motel.name ?? 'Nome não encontrado',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(motel.neighborhood ?? "Localização não encontrada"),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.favorite,
                  color: provider.favorite == true ? Colors.red : Colors.grey,
                  size: 38,
                ),
                onPressed: () {
                  provider.favorite = !provider.favorite;
                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 55,
                height: 23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: Colors.amber.shade700,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.star, color: Colors.amber.shade700, size: 18),
                    const SizedBox(width: 3),
                    Text(
                      '${motel.rate}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton.icon(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                iconAlignment: IconAlignment.end,
                icon: const Icon(
                  Icons.keyboard_arrow_down_outlined,
                  color: Colors.black,
                ),
                label: Text(
                  '${motel.reviews} avaliações',
                  style: const TextStyle(color: Colors.black, fontSize: 13),
                ),
              ),
            ],
          ),
          if (motel.suites != null && motel.suites!.isNotEmpty)
            ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height * 0.65,
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: motel.suites!.length,
                itemBuilder: (context, suiteIndex) {
                  final suite = motel.suites![suiteIndex];

                  bool matchesCategoryFilter() {
                    switch (filter) {
                      case 'hidro':
                        return suite.categoryItems!.any((category) =>
                            category.name!.toLowerCase().contains('hidro'));
                      case 'piscina':
                        return suite.categoryItems!.any((category) =>
                            category.name!.toLowerCase().contains('piscina'));
                      default:
                        return true;
                    }
                  }

                  if (filter == "disponíveis" &&
                      (suite.quantity == null || suite.quantity! <= 0)) {
                    return SizedBox.shrink();
                  }

                  if (filter == "com desconto" &&
                      !suite.periods!.any((period) =>
                          period.discount != null && period.discount! > 0)) {
                    return SizedBox.shrink();
                  }

                  if (!matchesCategoryFilter()) {
                    return SizedBox.shrink();
                  }

                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.78,
                    child: SingleChildScrollView(
                      physics: NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          CustomCardSuites(
                            suites: suite,
                            suitesLenght: motel.suites!.length,
                          ),
                          _buildFeatureCard(context, suite.categoryItems!),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: suite.periods!.length,
                            itemBuilder: (context, periodIndex) {
                              return _buildTimeAndPriceCard(
                                context,
                                suite.periods![periodIndex].formattedTime!,
                                suite.periods![periodIndex].price!,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(
      BuildContext context, List<CategoryItemModel> items) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
      width: MediaQuery.of(context).size.width * 0.73,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: SizedBox(
        width: 280,
        height: 60,
        child: Row(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildFeatureIcon(
              iconUrl: items[0].iconUrl!,
            ),
            _buildFeatureIcon(iconUrl: items[1].iconUrl!),
            ElevatedButton.icon(
              onPressed: () {},
              style: ButtonStyle(
                fixedSize: WidgetStatePropertyAll(Size(100, 50)),
                elevation: WidgetStatePropertyAll(0),
                backgroundColor: WidgetStatePropertyAll(Colors.transparent),
              ),
              iconAlignment: IconAlignment.end,
              icon: Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey.shade600,
              ),
              label: Text(
                'ver\ntodos',
                maxLines: 2,
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon({required String iconUrl}) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.all(Radius.circular(8))),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 30,
            minHeight: 30,
          ),
          child: Image.network(
            scale: 1,
            iconUrl,
            color: Colors.grey.shade600,
          ),
        ),
      ),
    );
  }

  Widget _buildTimeAndPriceCard(
      BuildContext context, String time, double price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      width: MediaQuery.of(context).size.width * 0.73,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: SizedBox(
        width: 300,
        height: 70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _buildTimeAndPrice(time: time, price: price),
        ),
      ),
    );
  }

  Widget _buildTimeAndPrice({required String time, required double price}) {
    UtilsServices utils = UtilsServices();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
              style: const TextStyle(fontSize: 17),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 9.0),
              child: Text(
                utils.priceToCurrency(price),
                style: const TextStyle(fontSize: 17),
              ),
            ),
          ],
        ),
        Icon(
          Icons.arrow_forward_ios,
          color: Colors.grey.shade500,
        ),
      ],
    );
  }
}
