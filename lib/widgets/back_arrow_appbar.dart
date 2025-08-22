import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/back_arrow.dart';


PreferredSize backArrowAppBar(){
  return PreferredSize(preferredSize: Size(deviceWidth, 60.h), child:AppBar(elevation: 0,
      centerTitle: false,
      title: const BackArrow(),
      automaticallyImplyLeading: false,
    ) );
}
