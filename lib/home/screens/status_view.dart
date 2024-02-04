import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walkly/home/cubit/home_cubit.dart';
import 'package:walkly/home/data/video_player_list.dart';
import 'package:walkly/home/screens/status_indicator.dart';
import 'package:walkly/home/screens/video_widget.dart';

class StatusView extends StatefulWidget {
  const StatusView({
    super.key,
    this.padding,
    this.isMobile = false,
    required this.pageController,
  });

  final EdgeInsets? padding;
  final PageController pageController;

  final bool isMobile;

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    double pageWidth = widget.isMobile ? size.width : 380;
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SafeArea(
          bottom: false,
          child: SizedBox(
            width: pageWidth,
            height: widget.isMobile ? size.height : null,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  width: pageWidth,
                ),
                GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    final RenderBox box = context.findRenderObject() as RenderBox;
                    final localOffset = box.globalToLocal(details.globalPosition);
                    final dx = localOffset.dx;
                    if (dx > box.size.width / 2) {
                      if (state.currentIndex + 1 < videoPlayerList.length) {
                        widget.pageController.animateToPage(
                          state.currentIndex + 1,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeInOut,
                        );
                      }
                    } else {
                      if (state.currentIndex != 0) {
                        widget.pageController.animateToPage(
                          state.currentIndex - 1,
                          duration: const Duration(milliseconds: 1),
                          curve: Curves.easeInOut,
                        );
                      }
                    }
                  },
                  child: PageView.builder(
                    controller: widget.pageController,
                    physics: const NeverScrollableScrollPhysics(),
                    onPageChanged: (index) {
                      context.read<HomeCubit>().updateIndex(index);
                    },
                    itemCount: videoPlayerList.length,
                    itemBuilder: (context, index) {
                      return VideoWidget(
                        videoPlayerModel: videoPlayerList[index],
                        pageController: widget.pageController,
                      );
                    },
                  ),
                ),
                Positioned(
                  top: 10,
                  width: pageWidth,
                  child: Row(
                    children: List.generate(
                      videoPlayerList.length,
                      (index) {
                        return Expanded(
                          child: AnimatedStatusIndicator(
                            width: pageWidth / videoPlayerList.length,
                            isPassedIndex: state.currentIndex > index,
                            isActive: state.currentIndex == index,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
