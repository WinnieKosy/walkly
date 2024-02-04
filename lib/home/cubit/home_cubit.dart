import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState());

  void updateIndex(int index) {
    emit(
      state.copyWith(
        currentIndex: index,
      ),
    );
  }

  void videoPlaying(bool isPlaying) {
    emit(
      state.copyWith(isPlaying: isPlaying),
    );
  }

  void progress(double progress) {
    emit(
      state.copyWith(progress: progress),
    );
  }
}
