import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:techtest_guia_motel/data/provider/home_page_provider.dart';
import 'package:techtest_guia_motel/models/item_model.dart';
import 'package:techtest_guia_motel/models/suite_model.dart';
import 'package:techtest_guia_motel/services/utils.dart';

class CustomCardSuites extends StatefulWidget {
  final SuiteModel suites;
  final int suitesLenght;

  const CustomCardSuites({
    super.key,
    required this.suites,
    required this.suitesLenght,
  });

  @override
  State<CustomCardSuites> createState() => _CustomCardSuitesState();
}

class _CustomCardSuitesState extends State<CustomCardSuites> {
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
                  padding: const EdgeInsets.fromLTRB(9, 10, 9, 0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(5),
                    child: widget.suites.photos != null &&
                            widget.suites.photos!.isNotEmpty
                        ? Image.network(
                            widget.suites.photos!.first,
                            height: 200,
                            width: 260,
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
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text(
                    widget.suites.name ?? 'Suíte sem nome',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                if (widget.suites.quantity! <= 2)
                  Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/siren.svg',
                          height: 15,
                          width: 15,
                        ),
                        Text(
                          'só mais ${widget.suites.quantity!} pelo app',
                          style: TextStyle(
                            color: Color(0xFFd11621),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          _buildFeatureCard(
            context,
            widget.suites.items!,
          ),
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

  Widget _buildFeatureCard(BuildContext context, List<ItemModel> items) {
    HomePageProvider provider = context.read<HomePageProvider>();

    List<IconData> icons = provider.mapItemsToIcons(items);
    debugPrint(icons.toString());

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 3),
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
            _buildFeatureIcon(icon: icons[0]),
            _buildFeatureIcon(icon: icons[1]),
            _buildFeatureIcon(
                label: 'ver todos', icon: Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureIcon({required IconData icon, String? label}) {
    return label != null
        ? ElevatedButton.icon(
            onPressed: () {},
            style: ButtonStyle(
              fixedSize: WidgetStatePropertyAll(Size(100, 50)),
              elevation: WidgetStatePropertyAll(0),
              backgroundColor: WidgetStatePropertyAll(Colors.transparent),
            ),
            iconAlignment: IconAlignment.end,
            icon: Icon(
              icon,
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
        : Container(
            decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Icon(
                icon,
                size: 25,
                color: Colors.grey.shade600,
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
}
