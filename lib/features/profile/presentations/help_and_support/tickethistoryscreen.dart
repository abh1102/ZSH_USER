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
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
      decoration: BoxDecoration(
        gradient: _getStatusGradient(status),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: _getStatusColor(status).withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        s.isEmpty ? 'OPEN' : s,
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
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
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
        child: Container(
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            gradient: LinearGradient(
              colors: [
                Colors.white,
                const Color(0xFFF8FDFF),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with gradient
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF00D4FF),
                      Color(0xFF0099FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D4FF).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.w,
                      height: 40.h,
                      // decoration: BoxDecoration(
                      //   color: Colors.white.withOpacity(0.2),
                      //   shape: BoxShape.circle,
                      // ),
                      // child: Icon(
                      //   Icons.support_agent,
                      //   color: Colors.white,
                      //   size: 24.sp,
                      // ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        'Ticket Details',
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        width: 32.w,
                        height: 32.h,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Colors.white,
                          size: 18.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              
              // Status Badge
              Container(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                decoration: BoxDecoration(
                  gradient: _getStatusGradient(status),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: _getStatusColor(status).withOpacity(0.3),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Text(
                  status.isEmpty ? 'OPEN' : status.toUpperCase(),
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              
              // Details
              _buildModernDetailRow('Ticket ID', ticketId, Icons.tag),
              SizedBox(height: 16.h),
              _buildModernDetailRow('Category', category, Icons.category),
              SizedBox(height: 16.h),
              _buildModernDetailRow('Description', description, Icons.description),
              SizedBox(height: 24.h),
              
              // Close Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF00D4FF),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildModernDetailRow(String label, String value, IconData icon) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE8F4FD)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF00D4FF),
                  Color(0xFF0099FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 18.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B7280),
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  value.isEmpty ? '-' : value,
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    final s = status.toUpperCase();
    switch (s) {
      case 'OPEN':
        return const Color(0xFFF59E0B);
      case 'RESOLVED':
        return const Color(0xFF10B981);
      case 'CLOSED':
        return const Color(0xFF6B7280);
      case 'REOPEN':
        return const Color(0xFFEF4444);
      default:
        return const Color(0xFF00D4FF);
    }
  }

  LinearGradient _getStatusGradient(String status) {
    final s = status.toUpperCase();
    switch (s) {
      case 'OPEN':
        return const LinearGradient(
          colors: [Color(0xFFF59E0B), Color(0xFFD97706)],
        );
      case 'RESOLVED':
        return const LinearGradient(
          colors: [Color(0xFF10B981), Color(0xFF059669)],
        );
      case 'CLOSED':
        return const LinearGradient(
          colors: [Color(0xFF6B7280), Color(0xFF4B5563)],
        );
      case 'REOPEN':
        return const LinearGradient(
          colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
        );
      default:
        return const LinearGradient(
          colors: [Color(0xFF00D4FF), Color(0xFF0099FF)],
        );
    }
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
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white,
                    const Color(0xFFF8FDFF),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFFE8F4FD)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                  BoxShadow(
                    color: const Color(0xFF00D4FF).withOpacity(0.1),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.all(20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Row
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                                decoration: BoxDecoration(
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFF00D4FF),
                                      Color(0xFF0099FF),
                                    ],
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.category,
                                      color: Colors.white,
                                      size: 16.sp,
                                    ),
                                    SizedBox(width: 6.w),
                                    Text(
                                      category.isEmpty ? 'Unknown' : category,
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                description.isEmpty ? 'No description available' : _truncateDescription(description),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: const Color(0xFF4B5563),
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        _statusText(status),
                      ],
                    ),
                    SizedBox(height: 16.h),
                    
                    // Footer with update button
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'ID: ${id.isEmpty ? 'N/A' : id}',
                          style: TextStyle(
                            fontSize: 11.sp,
                            color: const Color(0xFF9CA3AF),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        _updateStatusMenu(issueId: id),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
