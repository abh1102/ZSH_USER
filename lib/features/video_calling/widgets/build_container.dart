import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/generate_username.dart';

Widget buildOutgoingMessage(String messageText, String name, String time) {
  return Padding(
    padding: EdgeInsets.only(right: 8.w, bottom: 10.h),
    child: Align(
      alignment: Alignment.centerRight,
      child: ClipPath(
        clipper: OutgoingMessageClipper(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 17.h,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F0F2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
              bottomRight: Radius.circular(16.0),
            ),
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    simpleText(
                      extractFirstName(name),
                      fontSize: 10,
                    ),
                    width(6),
                    simpleText(
                      time,
                      fontSize: 8,
                    ),
                  ],
                ),
                height(10),
                Text(messageText),
                height(8),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildIncomingMessage(String messageText, String name, String time) {
  return Padding(
    padding: EdgeInsets.only(left: 8.w, bottom: 10.h),
    child: Align(
      alignment: Alignment.centerLeft,
      child: ClipPath(
        clipper: IncomingMessageClipper(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 12.w,
            vertical: 17.h,
          ),
          decoration: const BoxDecoration(
            color: Color(0xFFF0F0F2), // Background color for incoming messages
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16.0),
              topRight: Radius.circular(16.0),
              bottomLeft: Radius.circular(16.0),
            ),
          ),
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    simpleText(
                      extractFirstName(name),
                      fontSize: 10,
                    ),
                    width(8),
                    simpleText(
                      time,
                      fontSize: 8,
                    ),
                  ],
                ),
                height(10),
                Text(messageText),
                height(8),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class OutgoingMessageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(size.width, 0);
    path.lineTo(size.width, size.height); // Create a flat top
    path.quadraticBezierTo(
      size.width,
      size.height,
      size.width - 30.0,
      size.height,
    );
    path.lineTo(0, size.height + 30);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class IncomingMessageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(
      0,
      size.height,
    );
    path.quadraticBezierTo(
      size.width - 30.0,
      size.height,
      size.width,
      size.height,
    );
    path.lineTo(
      size.width,
      size.height - 30.0,
    ); // Create a flat top

    path.lineTo(
      size.width,
      0,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
