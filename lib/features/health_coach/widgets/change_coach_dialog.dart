import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/widgets/whitebg_blacktext_button.dart';

class ChangeCoachReasonDialog extends StatefulWidget {
  final VoidCallback? onpressed;
  final String selectReason;
  final ValueChanged<String> onLanguageSelected;

  const ChangeCoachReasonDialog({
    super.key,
    required this.selectReason,
    required this.onLanguageSelected,
    this.onpressed,
  });

  @override
  // ignore: library_private_types_in_public_api
  _ChangeCoachReasonDialogState createState() =>
      _ChangeCoachReasonDialogState();
}

class _ChangeCoachReasonDialogState extends State<ChangeCoachReasonDialog> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectReason;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 29.w,
          vertical: 64.h,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF25D366), Color(0xFF03C0FF)],
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                  child: heading1Text(
                "Why do you want to Change your Health Coach?",
                textAlign: TextAlign.center,
                color: Colors.white,
              )),
              height(28),
              buildLanguageRow('Lack of progress'),
              buildLanguageRow('Scheduling Conflict '),
              buildLanguageRow('Changes in Goal'),
              buildLanguageRow('Availability'),
              buildLanguageRow('Others'),
              height(18),
             if( selectedValue=='Others')
              Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Colors.white,
                ),
                child: const TextField(
                  maxLines: 4,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      )),
                ),
              ),
              height(55),
              WhiteBgBlackTextButton(text: "Done", onpressed: widget.onpressed),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLanguageRow(String language) {
    return Row(
      children: [
        Radio(
          value: language,
          groupValue: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
            widget.onLanguageSelected(value as String);
          },
          activeColor: Colors.white,
        ),
        width(20),
        Expanded(
          child: simpleText(
            language,
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
