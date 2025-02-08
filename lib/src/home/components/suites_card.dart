import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtest_guia_motel/models/suite_model.dart';
import 'package:techtest_guia_motel/services/utils.dart';

class CustomCardSuites extends StatelessWidget {
  final SuiteModel suites;
  final int suitesLenght;

  const CustomCardSuites({
    super.key,
    required this.suites,
    required this.suitesLenght,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 3,
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 9),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: suites.photos != null && suites.photos!.isNotEmpty
                        ? Image.network(
                            suites.photos!.first,
                            height: 200,
                            width: 285,
                            fit: BoxFit.cover,
                          )
                        : Container(
                            height: 200,
                            width: 285,
                            color: Colors.grey[300],
                            child: Icon(Icons.image_not_supported, size: 50),
                          ),
                  ),
                ),
                Text(
                  suites.name ?? 'Suíte sem nome',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (suitesLenght <= 2)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/siren.svg',
                        height: 20,
                        width: 20,
                      ),
                      const Text(
                        'só mais 2 pelo app',
                        style: TextStyle(
                          color: Color(0xFFd11621),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
          _buildFeatureCard(Icons.wifi),
          //TODO CONSERTAR ESSA MERDA AQUI VSFF EU TE ODEIO CARD DE MERDA
          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: suites.periods!.length,
          //   itemBuilder: (_, index) {
          //     return _buildTimeAndPriceCard(
          //       suites.periods![index].formattedTime!,
          //       suites.periods![index].totalPrice!,
          //     );
          //   },
          // ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard(IconData icon) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(9),
      ),
      child: SizedBox(
        width: 300,
        height: 50,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: _buildFeatureIcon(icon: icon),
        ),
      ),
    );
  }

  Widget _buildTimeAndPriceCard(String time, double price) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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

  Widget _buildFeatureIcon({required IconData icon, String? label}) {
    return label != null
        ? GestureDetector(
            onTap: () {},
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const Text(
                  'ver\ntodos',
                  textAlign: TextAlign.end,
                  style: TextStyle(fontSize: 12),
                ),
                Icon(icon),
              ],
            ),
          )
        : Icon(icon, size: 28);
  }
}
