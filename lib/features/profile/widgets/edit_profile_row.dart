import 'package:flutter/material.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/profile/widgets/profile_avatar_camera_icon.dart';
import 'package:zanadu/widgets/all_button.dart';

class EditProfileRow extends StatefulWidget {
  
  const EditProfileRow({
    super.key,
  });

  @override
  State<EditProfileRow> createState() => _EditProfileRowState();
}

class _EditProfileRowState extends State<EditProfileRow> {
  @override

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ProfileAvatarWithCameraIconProfile(),
        width(15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              simpleText(
                myUser?.userInfo?.profile?.fullName ?? "",
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.textDark,
              ),
              height(2),
              simpleText(
                userEmail ?? "",
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textDark,
              ),
              height(8),
              GestureDetector(
                onTap: () {
                  Routes.goTo(Screens.editProfileScreen);
                },
                child: const ColoredButtonWithoutHW(
                  verticalPadding: 12,
                  text: "Edit Profile",
                  size: 16,
                  weight: FontWeight.w600,
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
