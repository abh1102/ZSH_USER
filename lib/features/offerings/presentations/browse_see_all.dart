import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/image_widget.dart';
import 'package:zanadu/widgets/likes_converter.dart';

class BrowseSeeAllScreen extends StatefulWidget {
  final CoachInfo coachInfo;
  const BrowseSeeAllScreen({super.key, required this.coachInfo});

  @override
  State<BrowseSeeAllScreen> createState() => _BrowseSeeAllScreenState();
}

class _BrowseSeeAllScreenState extends State<BrowseSeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Coach", secondText: "Videos"),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 28.w,
              vertical: 28.h,
            ),
            child: (widget.coachInfo.myVideos?.isEmpty == true ||
                    widget.coachInfo.myVideos!
                        .every((video) => video.isApproved == false))
                ? Center(child: simpleText("There is no videos of coach"))
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: widget.coachInfo.myVideos?.length,
                        itemBuilder: (context, index) {
                          var data = widget.coachInfo.myVideos?[index];
                          if (data?.isApproved == true) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: CoachVideoContainer(
                                likes:
                                    formatLikesCount(data?.likes?.length ?? 0),
                                imgUrl: widget.coachInfo.image,
                                onpressed: () {
                                  Routes.goTo(Screens.videoDetailScren,
                                      arguments: data);
                                },
                                description: data?.description ?? "",
                                title: data?.title ?? "",
                              ),
                            );
                          }
                          return const SizedBox();
                        },
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}

class CoachVideoContainer extends StatefulWidget {
  final VoidCallback? onpressed;
  final String likes;
  final String title;
  final String description;
  final String? imgUrl;
  const CoachVideoContainer({
    super.key,
    required this.title,
    required this.description,
    this.onpressed,
    this.imgUrl,
    required this.likes,
  });

  @override
  State<CoachVideoContainer> createState() => _CoachVideoContainerState();
}

class _CoachVideoContainerState extends State<CoachVideoContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onpressed,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 25.w,
        ),
        decoration: BoxDecoration(
          color: AppColors.lightBlue,
          borderRadius: BorderRadius.circular(
            15,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            heading2Text(widget.title),
            height(16),
            Stack(
              alignment: Alignment.center,
              children: [
                CustomImageWidget(
                  url: widget.imgUrl ?? defaultAvatar,
                  myradius: 12,
                  mywidth: double.infinity,
                  myheight: 130.h,
                ),
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: const Color(0xFF747474).withOpacity(0.6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            height(16),
            body2Text(widget.description),
            height(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.favorite_rounded,
                  color: Colors.red,
                  size: 18,
                ),
                width(8),
                Flexible(
                  child: simpleText(
                    widget.likes,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
