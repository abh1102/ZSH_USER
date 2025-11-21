import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'zendeskservice.dart';
import '../../../../core/constants.dart';
import '../../../sessions/widgets/appbar_without_silver.dart';

class TicketHistoryScreen extends StatefulWidget {
  const TicketHistoryScreen({super.key});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {
  bool loading = true;
  List tickets = [];

  @override
  void initState() {
    super.initState();
    loadTickets();
  }

  // Future<void> loadTickets() async {
  //   try {
  //     tickets = await ZendeskService.fetchTickets();
  //   } catch (e) {
  //     print('Error loading tickets: $e');
  //     tickets = [];
  //   } finally {
  //     if (mounted) {
  //       setState(() => loading = false);
  //     }
  //   }
  // }
  Future<void> loadTickets() async {
    try {
      tickets = await ZendeskService.fetchTickets();
    } catch (e) {
      print('Error loading tickets: $e');
      tickets = [];
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }
  // STATUS CHIP UI
  Widget statusChip(String status) {
    Color bg;
    Color text;

    switch (status.toLowerCase()) {
      case "open":
        bg = Colors.orange.shade100;
        text = Colors.orange.shade800;
        break;
      case "pending":
        bg = Colors.blue.shade100;
        text = Colors.blue.shade800;
        break;
      case "solved":
        bg = Colors.green.shade100;
        text = Colors.green.shade800;
        break;
      default:
        bg = Colors.grey.shade200;
        text = Colors.grey.shade700;
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Text(
        status.toUpperCase(),
        style: TextStyle(
          color: text,
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
        firstText: "My",
        secondText: "Tickets",
      ),

      body: loading
          ? const Center(child: CircularProgressIndicator())
          : tickets.isEmpty
          ? Center(
        child: Text(
          "No tickets found",
          style: TextStyle(
            color: AppColors.textDark,
            fontSize: 16.sp,
          ),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(20.w),
        itemCount: tickets.length,
        itemBuilder: (context, index) {
          final t = tickets[index];

          return Container(
            margin: EdgeInsets.only(bottom: 15.h),
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              gradient: Insets.fixedGradient(opacity: 0.06),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 8,
                  offset: Offset(0, 3),
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Subject
                Text(
                  t["subject"] ?? "No Subject",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textDark,
                  ),
                ),
                SizedBox(height: 10.h),

                // Status Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    statusChip(t["status"]),
                    Icon(Icons.chevron_right, color: AppColors.textLight),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
