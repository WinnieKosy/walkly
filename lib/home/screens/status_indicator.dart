import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:walkly/home/cubit/home_cubit.dart';

class AnimatedStatusIndicator extends StatelessWidget {
  final bool isActive;
  final bool isPassedIndex;
  final double width;

  const AnimatedStatusIndicator({
    Key? key,
    this.isActive = false,
    this.isPassedIndex = false,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        width: width,
        height: 5.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: LinearProgressIndicator(
            backgroundColor: isPassedIndex ? Colors.white : Colors.black26,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
            value: isActive ? context.read<HomeCubit>().state.progress : 0,
          ),
        ),
      ),
    );
  }
}
