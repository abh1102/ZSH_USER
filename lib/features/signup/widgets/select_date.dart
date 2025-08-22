import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/profile/logic/provider/edit_profile_provider.dart';
import 'package:zanadu/features/sessions/logic/provider/session_provider.dart';
import 'package:zanadu/features/signup/logic/provider/signup_provider.dart';
import 'package:zanadu/widgets/format_date.dart';

class SelectStartDate extends StatelessWidget {
  const SelectStartDate({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final SignUpProvider provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        provider.pickStartDate();
      },
      child: Container(
        height: 50,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppColors.textLight.withOpacity(0.6))),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              simpleText(
                formatDate(provider.startDate),
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: provider.startDate != null
                    ? AppColors.textLight.withOpacity(0.7)
                    : Colors.grey,
              ),
              width(15),
              SvgPicture.asset(
                'assets/icons/Group (2).svg',
                width: 18,
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SelectStartDateEditProfile extends StatelessWidget {
  const SelectStartDateEditProfile({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final EditProfileProvider provider;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          provider.pickStartDate();
        },
        child: Container(
          height: 56,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.textLight.withOpacity(0.4))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                simpleText(
                  provider.startDate == null
                      ? myUser?.userInfo?.profile?.dOB ?? ""
                      : formatDate(provider.startDate),
                  color: provider.startDate != null
                      ? AppColors.textDark
                      : Colors.grey,
                ),
                width(15),
                SvgPicture.asset('assets/icons/Group (2).svg')
              ],
            ),
          ),
        ),
      );
    });
  }
}

class SelectStartDateSession extends StatelessWidget {
  const SelectStartDateSession({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final SessionProvider provider;

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () {
          provider.pickStartDate();
        },
        child: Container(
          height: 56.h,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: AppColors.greyDark)),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 17.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  formatDate(provider.startDate),
                  style: TextStyle(
                    color: provider.startDate != null
                        ? AppColors.textLight.withOpacity(0.7)
                        : Colors.grey,
                  ),
                ),
                width(15),
                SvgPicture.asset('assets/icons/Group (2).svg')
              ],
            ),
          ),
        ),
      );
    });
  }
}
