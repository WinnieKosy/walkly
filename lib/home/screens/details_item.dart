import 'package:flutter/material.dart';
import 'package:walkly/utils/theme/app_text.dart';

class DetailsItem extends StatelessWidget {
  const DetailsItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Apartment for rent ',
              style: AppText.text700.copyWith(
                color: Colors.white,
              ),
            ),
            Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
            ),
            Text(
              ' € 2,250/m ',
              style: AppText.text700.copyWith(
                color: Colors.white,
              ),
            ),
            Text(
              '+ € 350/m',
              style: AppText.text300.copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _DetailRow(
                  icon: 'assets/icons/icon-bedrooms.png',
                  text: '2',
                ),
                _DetailRow(
                  icon: 'assets/icons/icon-living-area.png',
                  text: '110 m\u00b2',
                ),
                _DetailRow(
                  icon: 'assets/icons/icon-bathrooms.png',
                  text: '1',
                ),
                _DetailRow(
                  icon: 'assets/icons/icon-constructionyear.png',
                  text: '2020',
                ),
                _DetailRow(
                  icon: 'assets/icons/icon-parking.png',
                  text: '1',
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 2,
              ),
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Text(
                'EPC:A',
                style: AppText.text300.copyWith(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            )
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.white,
              size: 13,
            ),
            Text(
              'Ruben Servaesstraat 51, 1000 Brussels',
              style: AppText.text300.copyWith(
                color: Colors.white,
                fontSize: 10,
              ),
            )
          ],
        )
      ],
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String icon;
  final String text;
  const _DetailRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          icon,
          height: 17,
          width: 17,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        const SizedBox(
          width: 7,
        ),
      ],
    );
  }
}
