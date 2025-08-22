import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:zanadu/common/utils/dialog_utils.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
import 'package:zanadu/features/profile/logic/provider/edit_profile_provider.dart';
import 'package:zanadu/features/profile/widgets/profile_avatar_camera_icon.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/features/signup/widgets/dynamic_pop_menu.dart';
import 'package:zanadu/features/signup/widgets/select_date.dart';
import 'package:zanadu/widgets/all_button.dart';
import 'package:zanadu/widgets/format_date.dart';
import 'package:zanadu/widgets/textfield_widget.dart';
import 'package:zanadu/widgets/valid_name.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isShowNameValidation = false;
  List<String> selectedHealthChallenges = [];
  String selectedGender = '';
  String selectHealthChallenges = '';
  String selectResidentState = '';
  Key infoPopupCustomExampleKey = const Key('info_popup_custom_example');
  String infoPopupCustomExampleText = 'This is a custom widget';
  PickedFile? selectedImage;

  final TextEditingController fullName = TextEditingController();
  final TextEditingController selectState = TextEditingController();
  final TextEditingController phone = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    fullName.text = myUser?.userInfo?.profile?.fullName ?? "";
    selectedGender = myUser?.userInfo?.profile?.gender ?? "";
    selectState.text = myUser?.userInfo?.profile?.state ?? "";
    phone.text = myUser?.userInfo?.profile?.phone ?? "";
    selectedHealthChallenges =
        myUser?.userInfo?.profile?.topHealthChallenges ?? [];
    // if (selectedHealthChallenges.isNotEmpty &&
    //     selectedHealthChallenges[0].startsWith(',')) {
    //   selectedHealthChallenges[0] = selectedHealthChallenges[0].substring(1);
    // }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    fullName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<LoginCubit>(context, listen: true);
    final provider = Provider.of<EditProfileProvider>(context);
    return BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is UserUpdatedState) {
            // Handle the updated user state
            // You can also add additional logic or UI updates here

            showGreenSnackBar("Your Account Successfully Updated");
          } else if (state is LoginErrorState) {
            // Handle error state
            showSnackBar(state.error);
          }
        },
        child: Scaffold(
          appBar: const AppBarWithBackButtonWOSilver(
              firstText: "Edit", secondText: "Profile"),
          body: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 28.w,
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          height(35),
                          Center(
                            child: ProfileAvatarWithCameraIcon(
                              provider: provider,
                              imageUrl: "assets/images/Rectangle 47.png",
                              onPressed: () async {
                                Routes.goBack();

                                context.read<LoginCubit>().removeProfilePhoto();
                                provider.removeSelectedImage();
                               
                              },
                            ),
                          ),
                          height(72),
                          simpleText(
                            "Name",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLight,
                          ),
                          height(8),
                          PrefixIconTextFieldWidget(
                            controller: fullName,
                            // initialValue:
                            //     myUser?.userInfo?.profile?.fullName ?? "",
                            prefixIcon: "assets/icons/user.svg",
                            onChanged: (value) {
                              if (!isValidName(value.trim())) {
                                setState(() {
                                  isShowNameValidation = true;
                                });
                              } else {
                                setState(() {
                                  isShowNameValidation = false;
                                });
                              }
                            },
                          ),
                          if (isShowNameValidation)
                            simpleText(
                              "You can not put only numbers or special character in name field",
                              color: AppColors.secondaryRedColor,
                              fontSize: 10,
                            ),
                          // Add additional text fields here
                          height(16),
                          simpleText(
                            "Email",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLight,
                          ),
                          height(8),
                          NoIconTextFieldWidget(
                            color: const Color(0xFFB7BBBF).withOpacity(0.3),
                            enabled: false,
                            initial: userEmail ?? "",
                          ),
                          height(16),
                          simpleText(
                            "Mobile Phone",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLight,
                          ),
                          height(8),
                          NoIconTextFieldWidget(
                            color: const Color(0xFFB7BBBF).withOpacity(0.3),
                            enabled: false,
                            initial: phone.text,
                          ),
                          height(16),

                          Row(
                            children: [
                              Expanded(
                                  child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  simpleText(
                                    "Date of Birth",
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    color: AppColors.textLight,
                                  ),
                                  height(8),
                                  SelectStartDateEditProfile(
                                      provider: provider),
                                ],
                              )),
                              width(20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    simpleText(
                                      "Select Gender",
                                      fontSize: 12,
                                      fontWeight: FontWeight.w400,
                                      color: AppColors.textLight,
                                    ),
                                    height(8),
                                    DynamicPopupMenu(
                                      selectedValue: selectedGender,
                                      items: const [
                                        'Male',
                                        'Female',
                                        'Non Binary',
                                        'Trans'
                                      ],
                                      onSelected: (String value) {
                                        setState(() {
                                          selectedGender = value;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),

                          height(16),
                          simpleText(
                            "Resident State",
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: AppColors.textLight,
                          ),
                          height(8),
                          NoIconTextFieldWidget(
                            controller: selectState,
                          ),
                          height(64),
                          GestureDetector(
                            onTap: () {
                              if (isValidName(fullName.text.trim()) == true) {
                                context.read<LoginCubit>().updateUser(
                                    fullName: fullName.text
                                        .trim(), // Replace with your updated data
                                    dob: provider.startDate == null
                                        ? myUser?.userInfo?.profile?.dOB
                                        : formatDate(provider.startDate),
                                    gender: selectedGender,
                                    topHealthChallenges:
                                        selectedHealthChallenges,
                                    state: selectState.text.trim(),
                                    image: provider.selectedImage?.path);
                              } else {
                                showSnackBar(
                                    "Name field can not have only numbers or special character");
                              }

                              //provider.selectedImage = null;
                            },
                            child: ColoredButton(
                              isLoading: cubit.state is LoginLoadingState,
                              text: "Update",
                              size: 16,
                              weight: FontWeight.w600,
                            ),
                          ),
                          height(16),
                        ])),
              ],
            ),
          )),
        ));
  }
}

void showLoadingIndicator(BuildContext context) {
  showCupertinoModalPopup(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext context) {
      return const Center(
        child: CircularProgressIndicator.adaptive(),
      );
    },
  );
}

// ignore: must_be_immutable
class DynamicPopupMenuEditScreen extends StatefulWidget {
  List<String> selectedValues;
  final List<String> items;
  final Function(List<String>) onSelected;

  DynamicPopupMenuEditScreen({
    Key? key,
    required this.selectedValues,
    required this.items,
    required this.onSelected,
  }) : super(key: key);

  @override
  _DynamicPopupMenuEditScreenState createState() =>
      _DynamicPopupMenuEditScreenState();
}

class _DynamicPopupMenuEditScreenState
    extends State<DynamicPopupMenuEditScreen> {
  late List<String> newSelectedValues;

  @override
  void initState() {
    super.initState();
    newSelectedValues = List.from(widget.selectedValues);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 51,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.withOpacity(0.6)),
      ),
      child: GestureDetector(
        onTap: () {
          setState(() {
            newSelectedValues = [];
          });
          _showHealthChallengesDialog(context);
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  newSelectedValues.isNotEmpty
                      ? newSelectedValues.join(', ')
                      : 'Select',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
              ),
              Icon(Icons.arrow_drop_down, size: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showHealthChallengesDialog(BuildContext context) async {
    final selectedValues = await showDialog<List<String>>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text('Select Health Challenges'),
              content: SingleChildScrollView(
                child: Column(
                  children: widget.items.map((String item) {
                    return CheckboxListTile(
                      title: Text(item),
                      value: newSelectedValues.contains(item),
                      onChanged: (bool? value) {
                        setState(() {
                          if (value != null) {
                            if (value) {
                              if (newSelectedValues.length < 3) {
                                newSelectedValues.add(item);
                              }
                            } else {
                              newSelectedValues.remove(item);
                            }
                          }
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(newSelectedValues);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedValues != null) {
      setState(() {
        newSelectedValues = selectedValues;
      });

      widget.onSelected(newSelectedValues);
    }
  }
}
