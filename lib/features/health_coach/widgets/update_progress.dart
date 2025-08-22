import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';

class UpdateProgressIndicatorContainer extends StatefulWidget {
  final String text;
  final int maxProgress;
  final Function(int) onProgressChanged;

  const UpdateProgressIndicatorContainer({
    Key? key,
    required this.maxProgress,
    required this.text,
    required this.onProgressChanged,
  }) : super(key: key);

  @override
  _UpdateProgressIndicatorContainerState createState() =>
      _UpdateProgressIndicatorContainerState();
}

class _UpdateProgressIndicatorContainerState
    extends State<UpdateProgressIndicatorContainer> {
  double currentProgress = 0.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 12.h,
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF25D366).withOpacity(0.2),
            Color(0xFF03C0FF).withOpacity(0.2),
          ],
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              body1Text(
                widget.text,
                color: AppColors.textDark,
              ),
              body1Text(
                '${currentProgress.toInt()}/${widget.maxProgress}',
                color: AppColors.textLight,
              ),
            ],
          ),
          const SizedBox(height: 15),
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              thumbColor: AppColors.primaryGreen,
              activeTrackColor: AppColors.primaryGreen,
              inactiveTrackColor: Colors.white,
              trackHeight: 10.0,
              thumbShape: const RoundSliderThumbShape(
                enabledThumbRadius: 12.0,
              ),
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
            ),
            child: Slider(
              value: currentProgress,
              min: 0,
              max: widget.maxProgress.toDouble(),
              onChanged: (value) {
                setState(() {
                  currentProgress = value;
                });

                // Call the callback with the updated progress value
                widget.onProgressChanged(currentProgress.toInt());
              },
            ),
          )
        ],
      ),
    );
  }
}
