// Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               simpleText(
//                 "Select Date",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.textLight,
//               ),
//               height(8),
//               SelectStartDateSession(provider: provider),
//               height(16),
//               simpleText(
//                 "Timings",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.textLight,
//               ),
//               height(8),
//               DynamicPopupMenu(
//                 selectedValue: scheduleTime,
//                 items: const [
//                   '09:00AM to 10:00 AM (EST)',
//                   '10:00AM to 11:00 AM (EST)',
//                   '06:00PM to 07:00 PM (EST)',
//                   '07:00PM to 08:00 PM (EST)'
//                 ],
//                 onSelected: (String value) {
//                   setState(() {
//                     scheduleTime = value;
//                   });
//                 },
//               ),
//               height(16),
//               simpleText(
//                 "Comment",
//                 fontSize: 12,
//                 fontWeight: FontWeight.w400,
//                 color: AppColors.textLight,
//               ),
//               height(8),
//               Container(
//                 padding: const EdgeInsets.all(7),
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     border: Border.all(
//                       color: AppColors.greyDark,
//                     )),
//                 child: const TextField(
//                   maxLines: 4,
//                   decoration: InputDecoration(
//                       border: InputBorder.none,
//                       hintStyle: TextStyle(
//                         color: Colors.grey,
//                       )),
//                 ),
//               ),
//               height(64),
//               ColoredButton(
//                 onpressed: () {
//                   oneSessionScheduledDialog(
//                       context,
//                       "Congratulations",
//                       "Your request for session has been sent to the coach.",
//                       "Done", () {
//                     Navigator.pop(context);
//                       Navigator.pop(context);
//                   });
                
//                 },
//                 text: "Request Session",
//                 size: 16,
//                 weight: FontWeight.w600,
//               )
//             ],
//           ),