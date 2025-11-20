import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/profile/logic/cubits/about_cubit/about_cubit.dart';
import 'package:zanadu/features/profile/presentations/help_and_support/repository/zendeskService.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/all_button.dart';

class HelpSupportTechnicalIssue extends StatefulWidget {
  const HelpSupportTechnicalIssue({super.key});

  @override
  State<HelpSupportTechnicalIssue> createState() =>
      _HelpSupportTechnicalIssueState();
}

class _HelpSupportTechnicalIssueState extends State<HelpSupportTechnicalIssue> {
  late AboutCubit aboutCubit;
  List<String> data = [];
  bool isLoading = true;
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    aboutCubit = BlocProvider.of<AboutCubit>(context);
    aboutCubit.getIssueList().then((value) {
      updateLoading(value);
    });
    super.initState();
  }

  void updateLoading(List<String>? value) {
    setState(() {
      data = value ?? [];
      isLoading = false;
    });
  }

  String selectedGender = "";

  String? _selectedFilePath;
  File? selectedFile;

  Future<void> openFileExplorer() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'png', 'jpg', 'jpeg', 'doc'],
    );

    if (result != null) {
      setState(() {
        _selectedFilePath = result.files.single.path;
        selectedFile = File(result.files.single.path!);
      });
    }
  }

  Widget buildPreviewWidget() {
    if (_selectedFilePath != null && File(_selectedFilePath!).existsSync()) {
      if (_selectedFilePath!.endsWith('.pdf')) {
        // Display PDF preview widget
        return GestureDetector(
          onTap: () {
            Routes.goTo(Screens.viewPdfScreen, arguments: selectedFile);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
                border: Border.all(
                  color: AppColors.textLight,
                ),
                borderRadius: BorderRadius.circular(12)),
            child: simpleText(
              "View File",
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        );
      } else if (_selectedFilePath!.endsWith('.png') ||
          _selectedFilePath!.endsWith('.jpg') ||
          _selectedFilePath!.endsWith('.jpeg')) {
        // Display image preview widget
        return Image.file(File(_selectedFilePath!));
      } else {
        // Display placeholder or thumbnail for other document types
        return const Icon(Icons.insert_drive_file);
      }
    } else {
      // Display placeholder when no document is selected or file does not exist
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AboutCubit>(context, listen: true);
    return BlocListener<AboutCubit, AboutState>(
      listener: (context, state) {
        if (state is AboutErrorState) {
          showSnackBar(state.error);
        }
        if (state is TechnicalIssuePostedState) {
          selectedGender = '';
          descriptionController.clear();
          _selectedFilePath = null;
          selectedFile = null;
          showTicketSuccessDialog(context);
        }
      },
      child: Scaffold(
        appBar: const AppBarWithBackButtonWOSilver(
          firstText: "Help &",
          secondText: "Support",
        ),
        body: SafeArea(
          child: isLoading
              ? const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8),
                    child: CircularProgressIndicator.adaptive(),
                  ),
                )
              : SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                      vertical: 28.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        heading2Text(
                          "Techincal Issues",
                          color: AppColors.textDark,
                        ),
                        height(21),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            gradient: Insets.fixedGradient(
                              opacity: 0.14,
                            ),
                          ),
                          padding: EdgeInsets.symmetric(
                            vertical: 15.h,
                            horizontal: 14.w,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              body1Text("Support Ticket / Dispute"),
                              height(37),
                              body2Text("Support Category"),
                              height(8),
                              DynamicPopupMenuWithBG(
                                color: Colors.white,
                                selectedValue: selectedGender,
                                items: data.map((e) => e).toList(),
                                onSelected: (String value) {
                                  setState(() {
                                    selectedGender = value;
                                  });
                                },
                              ),
                              height(16),
                              body2Text("Description"),
                              height(8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    15,
                                  ),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  maxLines: 5,
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                              height(16),
                              body2Text("Upload"),
                              height(8),
                              Container(
                                width: double.infinity,
                                constraints: BoxConstraints(minHeight: 174.h),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    border:
                                        Border.all(color: AppColors.greyLight)),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    buildPreviewWidget(),
                                    SizedBox(height: 20.h),
                                    _selectedFilePath != null
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              simpleText(
                                                "Document Selected",
                                                fontSize: 17,
                                                fontWeight: FontWeight.w500,
                                              ),
                                              IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _selectedFilePath = null;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                  ))
                                            ],
                                          )
                                        : GestureDetector(
                                            onTap: openFileExplorer,
                                            child: Column(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/icons/technical_issue.svg"),
                                                height(8),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 6.h,
                                                      horizontal: 22.w),
                                                  decoration: BoxDecoration(
                                                    gradient:
                                                        Insets.fixedGradient(),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            50),
                                                  ),
                                                  child: body2Text(
                                                    "Browse File",
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                height(8),
                                                body2Text("No file chosen")
                                              ],
                                            ),
                                          )
                                  ],
                                ),
                              ),
                              height(8),
                              body2Text(
                                "Supported Format  JPEG, JPG, PNG, PDF.",
                                color: AppColors.textLight,
                              ),
                            ],
                          ),
                        ),
                        height(28),
                        ColoredButtonWithoutHW(
                          text: "Submit",
                          isLoading: cubit.state is AboutLoadingState,
                          onpressed: () async {
                            if (selectedGender.isEmpty ||
                                descriptionController.text.trim().isEmpty) {
                              showSnackBar("Please fill all the details");
                              return;
                            }

                            cubit.emit(AboutLoadingState());

                            String? uploadToken;

                            // 👉 If file selected, upload first
                            if (selectedFile != null) {
                              uploadToken = await ZendeskService.uploadAttachment(selectedFile!);
                            }

                            // 👉 Then create ticket
                            bool success = await ZendeskService.createTicket(
                              category: selectedGender,
                              description: descriptionController.text.trim(),
                              uploadToken: uploadToken,
                            );

                            if (success) {
                              cubit.emit(TechnicalIssuePostedState("Technical Issue Created Successfully"));

                            } else {
                              cubit.emit(AboutErrorState("Zendesk ticket creation failed"));
                            }
                          },

                          size: 18,
                          weight: FontWeight.w500,
                          verticalPadding: 16,
                        )
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
  void showTicketSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Green Tick Icon
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.green.withOpacity(0.1),
                  ),
                  child: const Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 60,
                  ),
                ),

                const SizedBox(height: 20),

                const Text(
                  "Ticket Created!",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Your technical issue ticket has been submitted successfully.",
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 25),

                // OK Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // close dialog
                    Navigator.of(context).pop(); // navigate back to previous screen
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    minimumSize: const Size(120, 45),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

}

class DynamicPopupMenuWithBG extends StatelessWidget {
  final double? height;
  final String selectedValue;
  final Color? color;
  final List<String> items;
  final Function(String) onSelected;

  const DynamicPopupMenuWithBG({
    super.key,
    required this.selectedValue,
    required this.items,
    required this.onSelected,
    this.height,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      // height:height?? 56.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: PopupMenuButton<String>(
        onSelected: onSelected,
        itemBuilder: (BuildContext context) {
          return items.map((String item) {
            return PopupMenuItem<String>(
              value: item,
              child: simpleText(item, color: AppColors.textLight),
            );
          }).toList();
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              simpleText(selectedValue, color: AppColors.textDark),
              SvgPicture.asset('assets/icons/arrow-up.svg'),
            ],
          ),
        ),
      ),
    );
  }
}
