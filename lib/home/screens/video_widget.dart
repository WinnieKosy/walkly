import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';
import 'package:walkly/home/cubit/home_cubit.dart';
import 'package:walkly/home/data/video_player_list.dart';
import 'package:walkly/home/data/video_player_model.dart';
import 'package:walkly/home/screens/contact_us.dart';
import 'package:walkly/home/screens/details_item.dart';
import 'package:walkly/home/screens/playback_button.dart';
import 'package:walkly/utils/theme/app_text.dart';
import 'package:walkly/utils/widget/app_button.dart';

class VideoWidget extends StatefulWidget {
  final VideoPlayerModel videoPlayerModel;
  final PageController pageController;
  const VideoWidget({
    Key? key,
    required this.videoPlayerModel,
    required this.pageController,
  }) : super(key: key);

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  void animateToPage(BuildContext context) {
    int currentIndex = context.read<HomeCubit>().state.currentIndex;
    context
        .read<HomeCubit>()
        .videoPlaying(videoPlayerController.value.isPlaying);
    videoPlayerController.addListener(() {
      if (videoPlayerController.value.isCompleted) {
        if (currentIndex + 1 < videoPlayerList.length) {
          widget.pageController.animateToPage(currentIndex + 1,
              duration: const Duration(milliseconds: 1),
              curve: Curves.easeInOut);
        }
      }
      if (videoPlayerController.value.isInitialized) {
        final videoProgress =
            videoPlayerController.value.position.inMilliseconds /
                videoPlayerController.value.duration.inMilliseconds;
        context.read<HomeCubit>().progress(videoProgress);
      }
    });
  }

  void pauseVideo() {
    if (videoPlayerController.value.isPlaying) {
      videoPlayerController.pause();
      context.read<HomeCubit>().videoPlaying(true);
    } else {
      videoPlayerController.play();
      context.read<HomeCubit>().videoPlaying(false);
    }
  }

  void setVolume() {
    if (videoPlayerController.value.volume == 1.0) {
      videoPlayerController.setVolume(0);
    } else {
      videoPlayerController.setVolume(1);
    }
  }

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(videoPlayerList[context.read<HomeCubit>().state.currentIndex]
          .videoUrl),
    )..initialize().then((value) {
        videoPlayerController.play();
        setState(() {});
      });
    chewieController = ChewieController(
      showControls: false,
      videoPlayerController: videoPlayerController,
    );
    setVolume();
    animateToPage(context);
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int currentIndex = context.read<HomeCubit>().state.currentIndex;
    return Stack(
      children: [
        if (videoPlayerController.value.isInitialized)
          SizedBox(
            height: videoPlayerController.value.size.height,
            child: FittedBox(
              fit: BoxFit.none,
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: videoPlayerController.value.size.width,
                child: currentIndex == videoPlayerList.length - 1
                    ? Image.asset(
                        'assets/images/demo-apt.jpg',
                      )
                    : Chewie(
                        controller: chewieController,
                      ),
              ),
            ),
          )
        else
          const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          ),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(color: Color.fromRGBO(0, 0, 0, 0.3)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),
              currentIndex == videoPlayerList.length - 1
                  ? ContactUsImage(
                      videoPlayerController: videoPlayerController,
                      pageController: widget.pageController,
                    )
                  : Image.asset(
                      'assets/images/logo-demo-clips.png',
                      height: 110,
                      width: 110,
                      color: Colors.grey[200],
                      fit: BoxFit.cover,
                    ),
              const Spacer(
                flex: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 35),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.videoPlayerModel.subTitle,
                      style: AppText.text300.copyWith(fontSize: 10),
                    ),
                    Text(
                      widget.videoPlayerModel.title,
                      style: AppText.text600.copyWith(fontSize: 17),
                    ),
                    Text(
                      widget.videoPlayerModel.trailing,
                      maxLines: 2,
                      style: AppText.text300.copyWith(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const DetailsItem(),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Image.asset(
                          'assets/icons/icon-walkly.png',
                          height: 35,
                          width: 35,
                          color: Colors.grey[400],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const Spacer()
            ],
          ),
        ),
        Positioned(
          top: 200,
          right: 0,
          left: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                widget.videoPlayerModel.squareMeter,
                style: AppText.text800.copyWith(
                  fontSize: 80,
                  color: Colors.grey.withOpacity(0.5),
                ),
              ),
              Text(
                widget.videoPlayerModel.meterSymbol,
                style: AppText.text800.copyWith(
                  fontSize: 20,
                  color: Colors.grey.withOpacity(0.5),
                ),
              )
            ],
          ),
        ),
        Positioned(
          top: 40,
          right: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const PlayBackButton(),
              const SizedBox(
                width: 20,
              ),
              AppButton(
                onTap: () {
                  setVolume();
                },
                height: 22,
                width: 22,
                image: Image.asset(
                  videoPlayerController.value.volume == 0.0
                      ? 'assets/icons/sound.png'
                      : 'assets/icons/mute.png',
                  color: Colors.white,
                ),
                color: Colors.transparent,
              ),
              const SizedBox(
                width: 10,
              ),
              AppButton(
                onTap: () {
                  pauseVideo();
                },
                icon: context.read<HomeCubit>().state.isPlaying
                    ? Icons.play_arrow_outlined
                    : Icons.pause,
                color: Colors.transparent,
                iconColor: Colors.white,
                iconSize: 25,
                height: 22,
                width: 22,
              ),
              const SizedBox(
                width: 10,
              ),
              AppButton(
                  onTap: () {},
                  image: Image.asset(
                    'assets/icons/icon-send.png',
                    color: Colors.white,
                  ),
                  height: 22,
                  width: 22,
                  color: Colors.transparent,
                  iconColor: Colors.white,
                  iconSize: 22)
            ],
          ),
        ),
      ],
    );
  }
}
