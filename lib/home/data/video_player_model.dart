class VideoPlayerModel {
  final String videoUrl;
  final String title;
  final String subTitle;
  final String trailing;
  final String squareMeter;
  final String meterSymbol;

  VideoPlayerModel({
    required this.squareMeter,
    required this.meterSymbol,
    required this.videoUrl,
    required this.title,
    required this.subTitle,
    required this.trailing,
  });
}
