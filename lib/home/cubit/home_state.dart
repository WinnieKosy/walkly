part of 'home_cubit.dart';

class HomeState {
  final int currentIndex;
  final bool isPlaying;
  final double progress;

  HomeState({this.currentIndex = 0, this.isPlaying = false, this.progress = 0});

  HomeState copyWith(
      {int? currentIndex,
      bool? isPlaying,
      double? progress,
      VideoPlayerController? videoPlayerController}) {
    return HomeState(
      currentIndex: currentIndex ?? this.currentIndex,
      isPlaying: isPlaying ?? this.isPlaying,
      progress: progress ?? this.progress,
    );
  }
}
