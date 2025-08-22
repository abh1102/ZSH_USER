import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zanadu/common/utils/image_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/profile/logic/provider/edit_profile_provider.dart';
import 'package:zanadu/widgets/image_widget.dart';
import 'package:zanadu/widgets/white_border_white_text_button.dart';

class ProfileAvatarWithCameraIcon extends StatefulWidget {
  final String imageUrl;
  final EditProfileProvider provider;
  final VoidCallback? onPressed;
  const ProfileAvatarWithCameraIcon({
    Key? key,
    required this.imageUrl,
    required this.provider,
    this.onPressed,
  }) : super(key: key);

  @override
  _ProfileAvatarWithCameraIconState createState() =>
      _ProfileAvatarWithCameraIconState();
}

class _ProfileAvatarWithCameraIconState
    extends State<ProfileAvatarWithCameraIcon> {
  Future<void> _cropImage() async {
    if (widget.provider.selectedImage != null) {
      File? croppedImage = await cropImage(widget.provider.selectedImage!);
      if (croppedImage != null) {
        widget.provider.setUploadImagePath(XFile(croppedImage.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1.6,
              color: AppColors.primaryGreen,
            ),
          ),
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: widget.provider.selectedImage != null
                  ? Image.file(
                      widget.provider.selectedImage!,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      myUser?.userInfo?.profile?.image ?? defaultAvatar,
                      fit: BoxFit.cover,
                    ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
            showChooseImageDialog(context,widget.onPressed);
            },
            child: Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.primaryGreen),
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset("assets/icons/Group (9).svg"),
              ),
            ),
          ),
        ),
      ],
    );
  }

  void showChooseImageDialog(BuildContext context, VoidCallback? onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          contentPadding: EdgeInsets.zero,
          content: Container(
            width: 350.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF25D366),
                  Color(0xFF03C0FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                bottom: 20.h,
                left: 18.w,
                right: 18.w,
                top: 18.w,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button (SVG picture)

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                              onPressed: () async {
                                Routes.goBack();
                                await widget.provider.pickImage();
                                await _cropImage();
                              },
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(12.0),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.blue,
                                size: 25.0,
                              ),
                            ),
                            height(16),
                            simpleText(
                              "Choose Image",
                              align: TextAlign.center,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                      width(15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            RawMaterialButton(
                              onPressed: onPressed,
                              shape: const CircleBorder(),
                              elevation: 2.0,
                              fillColor: Colors.white,
                              padding: const EdgeInsets.all(12.0),
                              child: const Icon(
                                Icons.remove_circle_outline_rounded,
                                color: Colors.blue,
                                size: 25.0,
                              ),
                            ),
                            height(16),
                            simpleText(
                              "Remove Image",
                              align: TextAlign.center,
                              color: AppColors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  height(25),
                  WhiteBorderWhiteTextButton(
                    text: "Cancel",
                    onpressed: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class ProfileAvatarWithCameraIconProfile extends StatefulWidget {
  final String? url;
  const ProfileAvatarWithCameraIconProfile({
    super.key,
    this.url,
  });

  @override
  State<ProfileAvatarWithCameraIconProfile> createState() =>
      _ProfileAvatarWithCameraIconProfileState();
}

class _ProfileAvatarWithCameraIconProfileState
    extends State<ProfileAvatarWithCameraIconProfile> {
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              width: 1.6,
              color: AppColors.primaryGreen,
            )),
        child: CircularCustomImageWidget(
          url: myUser?.userInfo?.profile?.image ?? defaultAvatar,
          mywidth: 100,
          myheight: 100,
        ));
  }
}
