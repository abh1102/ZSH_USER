// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:zanadu/core/constants.dart';

// class DynamicPopupMenu extends StatelessWidget {
//   final String selectedValue;
//   final List<String> items;
//   final Function(String) onSelected;

//   DynamicPopupMenu({
//     required this.selectedValue,
//     required this.items,
//     required this.onSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 51,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: AppColors.textLight.withOpacity(0.6)),
//       ),
//       child: PopupMenuButton<String>(
//         color: AppColors.white,
//         onSelected: onSelected,
//         itemBuilder: (BuildContext context) {
//           return items.map((String item) {
//             return PopupMenuItem<String>(
//               value: item,
//               child:
//                   simpleText(item, color: AppColors.textLight.withOpacity(0.7)),
//             );
//           }).toList();
//         },
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               simpleText(
//                   selectedValue,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.textLight.withOpacity(0.7)),
//               SvgPicture.asset(
//                 'assets/icons/arrow-up.svg',
//                 width: 24,
//                 height: 24,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// class DynamicPopupMenuHealthChart extends StatelessWidget {
//   final String selectedValue;
//   final List<String> items;
//   final Function(String) onSelected;

//   DynamicPopupMenuHealthChart({
//     required this.selectedValue,
//     required this.items,
//     required this.onSelected,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       //  height: 56.0,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: AppColors.textLight.withOpacity(0.6)),
//       ),
//       child: PopupMenuButton<String>(
//         color: AppColors.white,
//         onSelected: onSelected,
//         itemBuilder: (BuildContext context) {
//           return items.map((String item) {
//             return PopupMenuItem<String>(
//               value: item,
//               child:
//                   simpleText(item, color: AppColors.textLight.withOpacity(0.7)),
//             );
//           }).toList();
//         },
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: 12.w,
//             vertical: 7.h,
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               simpleText(selectedValue,
//                   color: AppColors.textLight.withOpacity(0.7)),
//               SvgPicture.asset('assets/icons/arrow-up.svg'),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ignore: must_be_immutable
// class DynamicPopupMenuEditScreen extends StatefulWidget {
//   List<String> selectedValues;
//   final List<String> items;
//   final Function(List<String>) onSelected;

//   DynamicPopupMenuEditScreen({
//     super.key,
//     required this.selectedValues,
//     required this.items,
//     required this.onSelected,
//   });

//   @override
//   State<DynamicPopupMenuEditScreen> createState() =>
//       _DynamicPopupMenuEditScreenState();
// }

// class _DynamicPopupMenuEditScreenState
//     extends State<DynamicPopupMenuEditScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 51,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(8.0),
//         border: Border.all(color: AppColors.textLight.withOpacity(0.6)),
//       ),
//       child: PopupMenuButton<List<String>>(
//         color: AppColors.white,
//         onSelected: (List<String> newSelectedValues) {
//           setState(() {
//             widget.selectedValues = newSelectedValues;
//           });
//           widget.onSelected(newSelectedValues);
//         },
//         itemBuilder: (BuildContext context) {
//           return [
//             PopupMenuItem<List<String>>(
//               value: widget.selectedValues,
//               child: SizedBox(
//                 width: double.infinity,
//                 child: Wrap(
//                   children: widget.items.map((String item) {
//                     return GestureDetector(
//                       onTap: () {
//                         List<String> newSelectedValues =
//                             List.from(widget.selectedValues);

//                         if (newSelectedValues.contains(item)) {
//                           newSelectedValues.remove(item);
//                         } else if (newSelectedValues.length < 3) {
//                           newSelectedValues.add(item);
//                         }

//                         setState(() {
//                           widget.selectedValues = newSelectedValues;
//                         });

//                         widget.onSelected(newSelectedValues);
//                         Navigator.pop(context);
//                       },
//                       child: Container(
//                         padding: EdgeInsets.all(8),
//                         margin:
//                             EdgeInsets.symmetric(horizontal: 4, vertical: 4),
//                         color: widget.selectedValues.contains(item)
//                             ? Colors.blue.withOpacity(0.2)
//                             : null,
//                         child: simpleText(item,
//                             color: AppColors.textLight.withOpacity(0.7)),
//                       ),
//                     );
//                   }).toList(),
//                 ),
//               ),
//             ),
//           ];
//         },
//         child: Padding(
//           padding: EdgeInsets.symmetric(horizontal: 12),
//           child: Row(
//             children: [
//               Expanded(
//                 child: simpleText(
//                   widget.selectedValues.isNotEmpty
//                       ? widget.selectedValues.join(', ')
//                       : 'Select',
//                   fontSize: 12,
//                   fontWeight: FontWeight.w400,
//                   color: AppColors.textLight.withOpacity(0.7),
//                 ),
//               ),
//               SvgPicture.asset('assets/icons/arrow-up.svg',
//                   width: 24, height: 24),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }



