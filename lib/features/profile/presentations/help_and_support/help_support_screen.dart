import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/profile/widgets/help_support_container.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/url_launcher.dart';
import 'package:zendesk_messaging/zendesk_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/core/routes.dart';
import 'package:zanadu/features/profile/widgets/help_support_container.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';
import 'package:zanadu/widgets/url_launcher.dart';

import '../../widgets/dia,og_box.dart';

class HelpSupportScreen extends StatefulWidget {
  const HelpSupportScreen({super.key});

  @override
  State<HelpSupportScreen> createState() => _HelpSupportScreenState();
}

class _HelpSupportScreenState extends State<HelpSupportScreen> {
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
                    "How can we help you?",
                    color: AppColors.textDark,
                  ),
                  height(28),
                  HelpSupportContainer(
                    onpressed: () {
                      Routes.goTo(Screens.helpSupportAbout);
                    },
                    text: "About us",
                    svg: "assets/icons/help-circle.svg",
                  ),
                  height(28),
                  HelpSupportContainer(
                    onpressed: () {
                      myLaunchUrl("https://app.zanaduhealth.com/faq");
                    },
                    text: "FAQ",
                    svg: "assets/icons/quiz.svg",
                  ),
                  height(28),
                  HelpSupportContainer(
                    onpressed: () {
                      showSupportDialog(context, "technical");
                    },
                    text: "Technical Issues",
                    svg: "assets/icons/settings.svg",
                  ),
                  height(28),
                  HelpSupportContainer(
                    onpressed: () {
                      myLaunchUrl("https://app.zanaduhealth.com/contact-us");
                    },
                    text: "Contact",
                    svg: "assets/icons/headphones.svg",
                  ),
                  height(28),
                  HelpSupportContainer(
                    onpressed: () {
                      myLaunchUrl("https://app.zanaduhealth.com/terms-of-service");
                    },
                    text: "Terms of Service",
                    svg: "assets/icons/file-text.svg",
                  ),
                  height(28),
                  HelpSupportContainer(
                    onpressed: () {
                      myLaunchUrl("https://app.zanaduhealth.com/privacy-policy");
                    },
                    text: "Privacy Policy",
                    svg: "assets/icons/Vector (3).svg",
                  )
                ],
              ),
            ),
          )),
    );
  }
}