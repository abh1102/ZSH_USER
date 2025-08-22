import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/offerings/data/models/customized_offering_model.dart';

class CustomizedPlanContainer extends StatefulWidget {
  final List<CustomizedOfferingModel> offering;
  const CustomizedPlanContainer({super.key, required this.offering});

  @override
  State<CustomizedPlanContainer> createState() =>
      _CustomizedPlanContainerState();
}

class _CustomizedPlanContainerState extends State<CustomizedPlanContainer> {
  @override
  Widget build(BuildContext context) {
    String offeringNames = widget.offering
        .map((e) => e.offeringsName ?? '') // Use empty string if null
        .join(', ');
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 9.w,
        vertical: 13.h,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF25D366).withOpacity(0.2), // #25D366
            const Color(0xFF03C0FF).withOpacity(0.2), // #03C0FF
          ],
          stops: const [0.0507, 1.1795],
          transform: const GradientRotation(2.44), // 140 degrees in radians
        ),
        borderRadius: BorderRadius.circular(
          15,
        ),
      ),
      child: Row(
        children: [
          Image.asset(
            "assets/images/Rectangle 41920.png",
            width: 91.w,
            height: 101.h,
          ),
          width(18),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              simpleText(
                "My Customized Plan",
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
              height(8),

              // for (var i = 0; i < widget.offering.length;i++)
              //   body1Text(widget.offering[i].offeringsName.toString()),
              body2Text(offeringNames)
            ],
          ))
        ],
      ),
    );
  }
}
