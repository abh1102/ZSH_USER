import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/health_coach/data/model/health_coach_model.dart';
import 'package:zanadu/features/offerings/presentations/browse_see_all.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/likes_converter.dart';

class AllBrowseSeeAllScreen extends StatefulWidget {
  final CoachInfo coachInfo;
  final List<MyVideos> videos;
  const AllBrowseSeeAllScreen(
      {super.key, required this.coachInfo, required this.videos});

  @override
  State<AllBrowseSeeAllScreen> createState() => _AllBrowseSeeAllScreenState();
}

class _AllBrowseSeeAllScreenState extends State<AllBrowseSeeAllScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
          firstText: "All", secondText: "Videos"),
      body: SafeArea(
        child: widget.videos.isEmpty
            ? Center(
                child: simpleText("There are no videos of coach"),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 28.h,
                    horizontal: 28.w,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: widget.videos.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: CoachVideoContainer(
                                likes: formatLikesCount(
                                    widget.videos[index].likes?.length ?? 0),
                                imgUrl: widget.videos[index].thumbnailImage,
                                onpressed: () {
                                  Routes.goTo(Screens.keyVideoDetailScren,
                                      arguments: {
                                        'videos': widget.videos[index],
                                        'coachId': widget.coachInfo.userId
                                      });
                                },
                                description:
                                    widget.videos[index].description ?? "",
                                title: widget.videos[index].title ?? "",
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
