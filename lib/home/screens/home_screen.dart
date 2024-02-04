import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walkly/home/cubit/home_cubit.dart';
import 'package:walkly/home/data/video_player_list.dart';
import 'package:walkly/utils/layout/responsive_layout.dart';
import 'package:walkly/utils/widget/app_button.dart';

import 'status_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
    this.height,
    this.width,
    this.padding,
  });

  final double? height;

  final double? width;

  final EdgeInsets? padding;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ResponsiveLayout(
        mobileWidget: StatusView(
          padding: widget.padding,
          pageController: pageController,
          isMobile: true,
        ),
        desktopWidget: _WebView(
          pageController: pageController,
        ),
      ),
    );
  }
}

class _WebView extends StatelessWidget {
  final PageController pageController;

  const _WebView({
    Key? key,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SizedBox(
          height: size.height,
          width: size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppButton(
                  icon: Icons.arrow_back_ios,
                  color: state.currentIndex == 0 ? Colors.grey : Colors.white,
                  onTap: () {
                    if (state.currentIndex != 0) {
                      pageController.animateToPage(state.currentIndex - 1,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeInOut);
                    }
                  }),
              const SizedBox(
                width: 20,
              ),
              StatusView(
                pageController: pageController,
              ),
              const SizedBox(
                width: 20,
              ),
              AppButton(
                icon: state.currentIndex == videoPlayerList.length - 1
                    ? Icons.replay
                    : Icons.arrow_forward_ios,
                onTap: () {
                  if (state.currentIndex == videoPlayerList.length - 1) {
                  } else if (state.currentIndex + 1 < videoPlayerList.length) {
                    pageController.animateToPage(state.currentIndex + 1,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.easeInOut);
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
