import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/health_coach/logic/cubit/health_coach_cubit/health_coach_cubit.dart';
import 'package:zanadu/features/health_coach/logic/cubit/health_speciality_cubit/health_speciality_cubit.dart';
import 'package:zanadu/features/health_coach/logic/cubit/recommended_offering_cubit/recommended_offering_cubit.dart';
import 'package:zanadu/features/health_coach/presentations/health_coach_screen.dart';
import 'package:zanadu/features/home/logic/cubit/top_health_coach/top_health_coach_cubit.dart';
import 'package:zanadu/features/home/logic/provider/home_bottom_provider.dart';
import 'package:zanadu/features/home/presentations/home_screen.dart';
import 'package:zanadu/features/offerings/logic/cubit/customized_cubit/customized_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/offering/offering_cubit.dart';
import 'package:zanadu/features/offerings/logic/cubit/speciality_cubit/speciality_cubit.dart';
import 'package:zanadu/features/offerings/presentations/offering_screen.dart';
import 'package:zanadu/features/profile/logic/cubits/get_all_health_cubit/get_health_cubit.dart';
import 'package:zanadu/features/profile/logic/cubits/notification_cubit/notification_cubit.dart';
import 'package:zanadu/features/profile/presentations/zh_score_card.dart';
import 'package:zanadu/features/sessions/logic/cubit/cancel_reschedule_session_cubit/cancel_reschedule_session_cubit.dart';
import 'package:zanadu/features/sessions/logic/cubit/session_cubit/session_cubit.dart';
import 'package:zanadu/features/sessions/presentations/sessions_screen.dart';

class HomeBottomBar extends StatefulWidget {
  const HomeBottomBar({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomeBottomBarState createState() => _HomeBottomBarState();
}

class _HomeBottomBarState extends State<HomeBottomBar> {
  //int _currentIndex = 1; // Index of the selected tab

  final List<Widget> _pages = [
    // Add your different pages here
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => FiveHealthCoachCubit()),
      BlocProvider(create: (context) => NotificationCubit()),
      BlocProvider(create: (context) => AllOfferingCubit()),
      BlocProvider(create: (context) => SpecialityCoachCubit()),
    ], child: const HomeScreen()),

    BlocProvider(
      create: (context) => GetHealthCubit(),
      child: const MyZhScoreCardScreen(isAppBar: true),
    ),
    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AllSessionCubit()),
      BlocProvider(create: (context) => CancelRescheduleSessionCubit()),
    ], child: const SessionScreen()),

    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AllOfferingCubit()),
      BlocProvider(create: (context) => SpecialityCoachCubit()),
      BlocProvider(create: (context) => CustomizedOfferingCubit()),
    ], child: const OfferingScreen()),

    MultiBlocProvider(providers: [
      BlocProvider(create: (context) => AllHealthCoachCubit()),
      BlocProvider(create: (context) => HealthSpecialityCoachCubit()),
      BlocProvider(create: (context) => RecommendedOfferingCubit()),
    ], child: const HealthCoachScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    final tabIndexProvider = Provider.of<TabIndexProvider>(context);
    return Scaffold(
      body: _pages[tabIndexProvider.initialTabIndex], // Show the selected page
      bottomNavigationBar: MediaQuery(
        data: MediaQuery.of(context)
            .copyWith(textScaler: const TextScaler.linear(0.98)),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12), topRight: Radius.circular(12)),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                offset: const Offset(0, -4),
                blurRadius: 8,
                color: Colors.black.withOpacity(0.1),
              ),
            ],
          ),
          child: BottomNavigationBar(
            unselectedItemColor: AppColors.textLight,
            unselectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
            selectedItemColor: AppColors.textDark,
            selectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w400,
              fontSize: 11,
            ),
            type: BottomNavigationBarType.fixed,
            currentIndex: tabIndexProvider.initialTabIndex,
            onTap: (int index) {
              // Update the current index when a tab is tapped
              setState(() {
                tabIndexProvider.initialTabIndex = index;
              });
            },
            items: [
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: SvgPicture.asset(tabIndexProvider.initialTabIndex == 0
                      ? "assets/icons/Home.svg"
                      : "assets/icons/Home (1).svg"),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: SvgPicture.asset(tabIndexProvider.initialTabIndex == 1
                      ? "assets/icons/health_app_icon(1).svg"
                      : "assets/icons/health_app_icon.svg"),
                ),
                label: 'Health Score',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: SvgPicture.asset(tabIndexProvider.initialTabIndex == 2
                      ? "assets/icons/Video (1).svg"
                      : "assets/icons/Video.svg"),
                ),
                label: 'Sessions',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: SvgPicture.asset(tabIndexProvider.initialTabIndex == 3
                      ? "assets/icons/clipboard (1).svg"
                      : "assets/icons/clipboard.svg"),
                ),
                label: 'Offerings',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.only(top: 6.h),
                  child: SvgPicture.asset(tabIndexProvider.initialTabIndex == 4
                      ? "assets/icons/coach_1 1 (1).svg"
                      : "assets/icons/coach_1 1.svg"),
                ),
                label: 'Coach',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
