import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/profile/logic/cubits/about_cubit/about_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';

class HelpSupportAboutUs extends StatefulWidget {
  const HelpSupportAboutUs({super.key});

  @override
  State<HelpSupportAboutUs> createState() => _HelpSupportAboutUsState();
}

class _HelpSupportAboutUsState extends State<HelpSupportAboutUs> {
  late AboutCubit aboutCubit;

  @override
  void initState() {
    // TODO: implement initState

    aboutCubit = BlocProvider.of<AboutCubit>(context);
    aboutCubit.getAboutData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
        firstText: "Help &",
        secondText: "Support",
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 28.w,
            vertical: 28.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              heading2Text(
                "About Us",
                color: AppColors.textDark,
              ),
              height(21),
              BlocBuilder<AboutCubit, AboutState>(
                builder: (context, state) {
                  if (state is AboutLoadingState) {
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  } else if (state is AboutLoadedState) {
                    // Access the loaded plan from the state
                    if (state.abouts.isEmpty) {
                      return Center(
                          child: simpleText("There is no new About Us"));
                    }
                    return ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: state.abouts.length,
                        itemBuilder: (context, index) {
                          var data = state.abouts[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 28),
                            child: ExpandableRow(
                              title: data.title ?? "",
                              dropdownText: data.content ?? "",
                            ),
                          );
                        });
                  } else if (state is AboutErrorState) {
                    return Text('Error: ${state.error}');
                  } else {
                    return SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class ExpandableRow extends StatefulWidget {
  final String title;
  final String dropdownText;

  const ExpandableRow({
    super.key,
    required this.title,
    required this.dropdownText,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ExpandableRowState createState() => _ExpandableRowState();
}

class _ExpandableRowState extends State<ExpandableRow> {
  bool isExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: toggleExpansion,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              body1Text(
                widget.title,
                color: AppColors.textDark,
              ),
              RotationTransition(
                turns: AlwaysStoppedAnimation(isExpanded ? 0.25 : 0),
                child: SvgPicture.asset("assets/icons/Vector (4).svg"),
              ),
            ],
          ),
        ),
        height(10),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? null : 0,
          child: isExpanded
              ? simpleText(
                  widget.dropdownText,
                  color: const Color(
                    0xff979797,
                  ),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                )
              : const SizedBox.shrink(),
        ),
        height(10),
        isExpanded
            ? const SizedBox()
            : Divider(
                color: AppColors.greyLight,
              )
      ],
    );
  }
}
