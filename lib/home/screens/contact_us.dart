import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:walkly/home/cubit/home_cubit.dart';
import 'package:walkly/home/data/video_player_list.dart';
import 'package:walkly/utils/theme/app_text.dart';
import 'package:walkly/utils/widget/app_button.dart';

class ContactUsImage extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final PageController pageController;
  const ContactUsImage(
      {Key? key,
      required this.videoPlayerController,
      required this.pageController})
      : super(key: key);

  @override
  State<ContactUsImage> createState() => _ContactUsImageState();
}

class _ContactUsImageState extends State<ContactUsImage> {
  @override
  Widget build(BuildContext context) {
    final currentIndex = context.read<HomeCubit>().state.currentIndex;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 80,
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 60),
          margin: const EdgeInsets.symmetric(horizontal: 35),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Colors.white.withOpacity(0.9),
          ),
          child: Column(
            children: [
              Text(
                'contact us',
                style:
                    AppText.text700.copyWith(color: Colors.black, fontSize: 22),
              ),
              const SizedBox(
                height: 15,
              ),
              Image.asset(
                'assets/images/logo-demo-contact.png',
                height: 100,
                width: 100,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 15,
              ),
              const _ContactUsRow(
                icon: 'assets/icons/icon-email.png',
                text: 'john.doe@jlagency.com',
              ),
              const _ContactUsRow(
                icon: 'assets/icons/icon-phone.png',
                text: '+32 485 88 89 04',
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        AppButton(
          onTap: () {
            context.read<HomeCubit>().updateIndex(0);
            widget.videoPlayerController.play();
            if (widget.videoPlayerController.value.isInitialized) {
              widget.pageController.animateToPage(currentIndex + 1,
                  duration: const Duration(milliseconds: 1),
                  curve: Curves.easeInOut);
            }
          },
          color: Colors.black.withOpacity(0.5),
          icon: Icons.replay,
          iconColor: Colors.white,
        )
      ],
    );
  }
}

class _ContactUsRow extends StatelessWidget {
  final String icon;
  final String text;
  const _ContactUsRow({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              icon,
              height: 17,
              width: 17,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text,
              style: const TextStyle(color: Colors.black, fontSize: 12),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
