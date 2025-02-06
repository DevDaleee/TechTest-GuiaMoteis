import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:techtest_guia_motel/models/motel_model.dart';

class HotelCard extends StatelessWidget {
  final String filter;
  final MotelModel motel;

  const HotelCard({super.key, required this.filter, required this.motel});

  @override
  Widget build(BuildContext context) {
    return filter.isEmpty || filter == "Filtros"
        ? Padding(
            padding: const EdgeInsets.all(22.0),
            child: Column(
              children: [
                Row(
                  spacing: 20,
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(35)),
                        child: Image.network(
                          motel.imageUrl ?? '',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                motel.name ?? 'Nome não encontrado',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                motel.neighborhood ??
                                    "Localização não encontrada",
                              ),
                            ],
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.grey,
                              size: 38,
                            ),
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                        shape: BoxShape.rectangle,
                        color: Colors.amber,
                      ),
                    )
                  ],
                ),
                Card(
                  elevation: 0,
                  margin: EdgeInsets.all(11.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Image.network(
                        'https://cdn.houseplansservices.com/product/4eat34je4b4208ebguq0ruoekn/w300x200.jpg?v=2',
                        fit: BoxFit.cover,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Suíte Standard',
                        style: TextStyle(fontSize: 20),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            height: 20,
                            width: 20,
                            'assets/icons/siren.svg',
                          ),
                          Text(
                            'só mais 2 pelo app',
                            style: TextStyle(
                              color: Color(0xFFd11621),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
