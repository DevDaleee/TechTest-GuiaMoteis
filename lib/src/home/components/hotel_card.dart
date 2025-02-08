import 'package:flutter/material.dart';
import 'package:techtest_guia_motel/models/motel_model.dart';
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
    if (filter.isNotEmpty && filter != "Filtros") {
      return const SizedBox.shrink();
    }

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(22.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.network(
                    motel.logoUrl ?? '',
                    width: 50,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 10),
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
                  icon: const Icon(
                    Icons.favorite,
                    color: Colors.grey,
                    size: 38,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Container(
                  width: 60,
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
                const SizedBox(width: 10),
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
                  icon: const Icon(Icons.keyboard_arrow_down_outlined),
                  label: Text(
                    '${motel.reviews} avaliações',
                    style: const TextStyle(color: Colors.black, fontSize: 13),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            if (motel.suites != null && motel.suites!.isNotEmpty)
              ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: 350,
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: motel.suites!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                      ),
                      child: CustomCardSuites(
                        suites: motel.suites![index],
                        suitesLenght: motel.suites!.length,
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
