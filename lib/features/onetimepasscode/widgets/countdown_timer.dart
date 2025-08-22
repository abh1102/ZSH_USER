import 'dart:async';

import 'package:flutter/material.dart';

class CountdownTimerWidget extends StatefulWidget {
  final Function? onTimerEnd;

  const CountdownTimerWidget({super.key, this.onTimerEnd});

  @override
  // ignore: library_private_types_in_public_api
  _CountdownTimerWidgetState createState() => _CountdownTimerWidgetState();
}

class _CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  int _remainingTimeInSeconds = 300; // 5 minutes

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      if (_remainingTimeInSeconds == 0) {
        timer.cancel();
        if (widget.onTimerEnd != null) {
          widget.onTimerEnd!();
        }
      } else {
        if (mounted) {
          setState(() {
            _remainingTimeInSeconds--;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final minutes = (_remainingTimeInSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (_remainingTimeInSeconds % 60).toString().padLeft(2, '0');

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$minutes:$seconds',
          style: TextStyle(fontSize: 24, color: Colors.black),
        ),
        // Place your OTP text field below the countdown timer
      ],
    );
  }
}
