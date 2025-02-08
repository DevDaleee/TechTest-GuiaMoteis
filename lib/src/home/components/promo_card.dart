import 'package:animated_emoji/emoji.dart';
import 'package:animated_emoji/emojis.g.dart';
import 'package:flutter/material.dart';
import 'package:techtest_guia_motel/services/utils.dart';

class PromoCard extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final String? location;
  final double? discount;
  final double? prcDiscont;

  const PromoCard({
    super.key,
    this.imageUrl,
    this.name,
    this.location,
    this.discount,
    this.prcDiscont,
  });

  @override
  Widget build(BuildContext context) {
    UtilsServices utils = UtilsServices();
    return SizedBox(
      height: 220,
      width: MediaQuery.of(context).size.width * 0.99,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              SizedBox(
                height: 170,
                width: 170,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.network(
                    imageUrl ??
                        'https://thumbs.dreamstime.com/b/quarto-de-hotel-com-cama-de-rainha-8369412.jpg',
                    height: 210,
                    width: 150,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          const AnimatedEmoji(
                            AnimatedEmojis.fire,
                            size: 20,
                            repeat: false,
                          ),
                          const SizedBox(width: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name ?? "Nome não informado",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: name != null ? 16 : 14,
                                ),
                              ),
                              Text(
                                location ?? "Localização não informada",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              discount != null
                                  ? '${prcDiscont!.toStringAsFixed(prcDiscont! % 1 == 0 ? 0 : 1)}% de desconto'
                                  : 'Desconto não informado',
                              style: TextStyle(
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Divider(),
                            Text(
                              'a partir de ${utils.priceToCurrency(discount!)}',
                              style: TextStyle(
                                  fontSize: 12, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.center,
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.045,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF1aba8e),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                            iconAlignment: IconAlignment.end,
                            icon: Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.white,
                            ),
                            label: const Text(
                              'reservar',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
