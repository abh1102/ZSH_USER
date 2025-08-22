import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';


class VideoCallingAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget callWidget;
  final VoidCallback? onpressed;
  const VideoCallingAppBar(
      {super.key, required this.callWidget, this.onpressed});

  @override
  State<VideoCallingAppBar> createState() => _VideoCallingAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(64.h);
}

class _VideoCallingAppBarState extends State<VideoCallingAppBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AppBar(
        elevation: 50,
        automaticallyImplyLeading: false,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
            left: 20.w,
            right: 20.w,
            top: 10.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: simpleText(
                    "Video Call",
                    color: AppColors.textDark,
                    overflow: TextOverflow.ellipsis,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ), // First Icon Widget

              widget.callWidget,

              IconButton(
                onPressed: widget.onpressed,
                icon: Icon(
                  Icons.flip_camera_ios,
                  color: AppColors.textDark,
                  size: 20.0,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


