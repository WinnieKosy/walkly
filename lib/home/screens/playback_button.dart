import 'package:flutter/material.dart';
import 'package:walkly/utils/theme/app_text.dart';

class PlayBackButton extends StatefulWidget {
  const PlayBackButton({Key? key}) : super(key: key);

  @override
  State<PlayBackButton> createState() => _PlayBackButtonState();
}

class _PlayBackButtonState extends State<PlayBackButton> {
  final playBackOptions = ['0.5x', '0.75x', '1x', '1.5x', '2x'];
  bool isHovered = false;
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.none,
      child: Column(
        children: [
          PopupMenuButton(
            position: PopupMenuPosition.under,
            color: Colors.black.withOpacity(0.5),
            itemBuilder: (BuildContext context) {
              return playBackOptions.map((e) {
                return PopupMenuItem(
                  child: Text(
                    e,
                    style: AppText.text300.copyWith(color: Colors.white),
                  ),
                );
              }).toList();
            },
            child: Text(
              '1x',
              style: AppText.text700.copyWith(
                color: Colors.white,
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
