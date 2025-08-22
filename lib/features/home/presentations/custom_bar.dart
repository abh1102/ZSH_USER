// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:zanadu/core/constants.dart';

// class CustomBottomNavigationBar extends StatelessWidget {
//   final List<String> icons = [
//     "assets/icons/Home (1).svg",
//     "assets/icons/health_app_icon.svg",
//     "assets/icons/Video.svg",
//     "assets/icons/clipboard.svg",
//     "assets/icons/coach_1 1.svg",
//   ];

//   final List<String> selectedIcons = [
//     "assets/icons/Home.svg",
//     "assets/icons/health_app_icon(1).svg",
//     "assets/icons/Video (1).svg",
//     "assets/icons/clipboard (1).svg",
//     "assets/icons/coach_1 1 (1).svg",
//   ];

//   final List<String> labels = ['Home', 'Health Score', 'Sessions', 'Offerings', 'Coach'];

//   final int currentIndex;
//   final Function(int) onTap;

//   CustomBottomNavigationBar({super.key, required this.currentIndex, required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 10.0),
//       decoration: BoxDecoration(
//         // borderRadius: const BorderRadius.only(
//         //   topLeft: Radius.circular(12),
//         //   topRight: Radius.circular(12),
//         // ),
//         color: Colors.white,
//         boxShadow: [
//           BoxShadow(
//             offset: const Offset(0, -4),
//             blurRadius: 8,
//             color: Colors.black.withOpacity(0.1),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: List.generate(icons.length, (index) {
//           return GestureDetector(
//             onTap: () => onTap(index),
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 5.0),
//                   child: SvgPicture.asset(
//                     currentIndex == index ? selectedIcons[index] : icons[index],
//                     height: 24.0,
//                     width: 24.0,
                  
//                   ),
//                 ),
//                 FittedBox(fit: BoxFit.scaleDown,
//                   child: Text(
//                     labels[index],
//                     style: GoogleFonts.poppins(
//                       fontWeight: FontWeight.w400,
//                       fontSize: 11,
//                       color: currentIndex == index ? AppColors.textDark : AppColors.textLight,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           );
//         }),
//       ),
//     );
//   }
// }




// to call use this 
// CustomBottomNavigationBar(
//         currentIndex: tabIndexProvider.initialTabIndex,
//         onTap: (index) {
//           tabIndexProvider.setInitialTabIndex(index);
        
//         },
//       ),