import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';

Future<File?> pickImage(ImageSource source) async {
  XFile? pickedFile = await ImagePicker().pickImage(source: source);
  if (pickedFile == null) return null;
  return File(pickedFile.path);
}

Future<File?> cropImage(File file) async {
  CroppedFile? croppedFile = await ImageCropper().cropImage(
    sourcePath: file.path,
    compressQuality: 50,
    aspectRatio: CropAspectRatio(ratioX: 16, ratioY: 9),
  );
  if (croppedFile == null) return null;
  return File(croppedFile.path);
}

void showImageSelectionDialog({required Function(File) onSelected}) {
  showDialog(
      context: Routes.currentContext,
      builder: (context) {
        return Dialog(
          insetPadding: Insets.dialogPadding,
          child: Container(
            padding: EdgeInsets.all(20.w),
            color: AppColors.white,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Upload Image", style: TextStyles.heading2),
                height(
                  10,
                ),
                ListTile(
                  onTap: () async {
                    // Close the dialog
                    Routes.goBack();

                    final pickedImage = await pickImage(ImageSource.camera);
                    if (pickedImage != null) {
                      final croppedImage = await cropImage(pickedImage);
                      if (croppedImage != null) {
                        onSelected(croppedImage);
                      }
                    }
                  },
                  leading: Icon(
                    Icons.camera_alt,
                    color: AppColors.primaryBlue,
                  ),
                  title: Text("Take a Photo"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                ),
                ListTile(
                  onTap: () async {
                    // Close the dialog
                    Routes.goBack();

                    final pickedImage = await pickImage(ImageSource.gallery);
                    if (pickedImage != null) {
                      final croppedImage = await cropImage(pickedImage);
                      if (croppedImage != null) {
                        onSelected(croppedImage);
                      }
                    }
                  },
                  leading: Icon(
                    Icons.photo_album,
                    color: AppColors.primaryBlue,
                  ),
                  title: Text("Upload from Gallery"),
                  trailing: Icon(Icons.arrow_forward_ios, size: 15),
                ),
              ],
            ),
          ),
        );
      });
}
