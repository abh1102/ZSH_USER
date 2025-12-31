import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/features/profile/data/repository/profile_repository.dart';
import '../../../../core/constants.dart';
import '../../../sessions/widgets/appbar_without_silver.dart';

class TicketHistoryScreen extends StatefulWidget {
  const TicketHistoryScreen({super.key});

  @override
  State<TicketHistoryScreen> createState() => _TicketHistoryScreenState();
}

class _TicketHistoryScreenState extends State<TicketHistoryScreen> {
  bool loading = true;
  List<dynamic> tickets = [];
  final ProfileRepository _repository = ProfileRepository();

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
      tickets = await _repository.fetchTechnicalIssues();
    } catch (e) {
      print('Error loading tickets: $e');
      tickets = [];
    } finally {
      if (mounted) {
        setState(() => loading = false);
      }
    }
  }

  String _issueId(dynamic issue) {
    if (issue is Map) {
      return (issue['_id'] ?? issue['id'] ?? '').toString();
    }
    return '';
  }

  String _issueCategory(dynamic issue) {
    if (issue is Map) {
      return (issue['categoryName'] ?? issue['category'] ?? issue['issue'] ?? '')
          .toString();
    }
    return '';
  }

  String _issueDescription(dynamic issue) {
    if (issue is Map) {
      return (issue['description'] ?? issue['message'] ?? issue['details'] ?? '')
          .toString();
    }
    return '';
  }

  String _issueStatus(dynamic issue) {
    if (issue is Map) {
      return (issue['status'] ?? '').toString();
    }
    return '';
  }

  Widget _statusText(String status) {
    final s = status.toUpperCase();
    return Text(
      s.isEmpty ? 'OPEN' : s,
      style: TextStyle(
        fontSize: 14.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      ),
    );
  }

  String _truncateDescription(String description, {int maxWords = 100}) {
    if (description.isEmpty) return description;
    
    final words = description.split(' ');
    if (words.length <= maxWords) return description;
    
    return '${words.take(maxWords).join(' ')}...';
  }

  Future<void> _showTicketDetailsDialog({
    required String ticketId,
    required String category,
    required String description,
    required String status,
  }) async {
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Ticket Details',
          style: TextStyle(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDetailRow('Ticket ID:', ticketId),
              SizedBox(height: 12.h),
              _buildDetailRow('Category:', category),
              SizedBox(height: 12.h),
              _buildDetailRow('Status:', status),
              SizedBox(height: 12.h),
              _buildDetailRow('Description:', description),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.textDark,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          value.isEmpty ? '-' : value,
          style: TextStyle(
            fontSize: 13.sp,
            color: AppColors.textDark,
          ),
        ),
      ],
    );
  }

  Future<void> _showStatusUpdateDialog({
    required String issueId,
    required String newStatus,
  }) async {
    final TextEditingController controller = TextEditingController();
    bool submitting = false;

    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text(
                'Add Comment',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textDark,
                ),
              ),
              content: TextField(
                controller: controller,
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Write your comment...',
                  border: OutlineInputBorder(),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: submitting
                      ? null
                      : () {
                          Navigator.pop(context, false);
                        },
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: submitting
                      ? null
                      : () async {
                          final comment = controller.text.trim();
                          if (comment.isEmpty) {
                            return;
                          }
                          setStateDialog(() {
                            submitting = true;
                          });
                          try {
                            await _repository.updateTechnicalIssue(
                              technicalIssueId: issueId,
                              status: newStatus,
                              comment: comment,
                            );
                            if (context.mounted) {
                              Navigator.pop(context, true);
                            }
                          } catch (e) {
                            setStateDialog(() {
                              submitting = false;
                            });
                          }
                        },
                  child: submitting
                      ? SizedBox(
                          height: 18.h,
                          width: 18.w,
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Comment'),
                ),
              ],
            );
          },
        );
      },
    );

    if (result == true) {
      setState(() {
        loading = true;
      });
      await loadTickets();
    }
  }

  Widget _updateStatusMenu({
    required String issueId,
  }) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        _showStatusUpdateDialog(issueId: issueId, newStatus: value);
      },
      itemBuilder: (context) => const [
        PopupMenuItem(value: 'RESOLVED', child: Text('RESOLVED')),
        PopupMenuItem(value: 'CLOSED', child: Text('CLOSED')),
        PopupMenuItem(value: 'REOPEN', child: Text('REOPEN')),
      ],
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: AppColors.textLight.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update status',
              style: TextStyle(
                fontSize: 12.sp,
                color: AppColors.textDark,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 6.w),
            Icon(Icons.keyboard_arrow_down, size: 18.sp),
          ],
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
          final issue = tickets[index];
          final id = _issueId(issue);
          final category = _issueCategory(issue);
          final description = _issueDescription(issue);
          final status = _issueStatus(issue);

          return GestureDetector(
            onTap: () {
              _showTicketDetailsDialog(
                ticketId: id,
                category: category,
                description: description,
                status: status,
              );
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 16.h),
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
              decoration: BoxDecoration(
                color: const Color(0xFFCFF3D7),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ticket Category : ${category.isEmpty ? '-': category}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: AppColors.textDark,
                              ),
                            ),
                            SizedBox(height: 6.h),
                            Text(
                              description.isEmpty ? '-' : _truncateDescription(description),
                              style: TextStyle(
                                fontSize: 13.sp,
                                color: AppColors.textDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      _statusText(status),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _updateStatusMenu(issueId: id),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
