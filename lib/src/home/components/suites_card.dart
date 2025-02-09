import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:techtest_guia_motel/models/suite_model.dart';

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
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: MediaQuery.of(context).size.width * 0.78,
      height: widget.suites.periods!.length <= 2
          ? MediaQuery.of(context).size.width * 0.70
          : MediaQuery.of(context).size.width * 0.70,
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
                      width: 295,
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
            padding: widget.suites.periods!.length <= 2
                ? EdgeInsets.fromLTRB(10, 0, 10, 0)
                : EdgeInsets.only(
                    top: 13,
                  ),
            child: Text(
              widget.suites.name ?? 'Suíte sem nome',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: widget.suites.periods!.length <= 2 ? 15 : 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          if (widget.suites.periods!.length <= 2)
            Row(
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
        ],
      ),
    );
  }
}
