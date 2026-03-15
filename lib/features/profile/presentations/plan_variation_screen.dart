import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:zanadu/core/constants.dart';
import 'package:zanadu/features/login/logic/login_cubit/login_cubit.dart';
import 'package:zanadu/features/profile/logic/cubit/plan_variation_cubit/plan_variation_cubit.dart';
import 'package:zanadu/features/sessions/widgets/appbar_without_silver.dart';

import '../data/model/plan_variation_model.dart';

class PlanVariationScreen extends StatefulWidget {
  const PlanVariationScreen({super.key});

  @override
  State<PlanVariationScreen> createState() => _PlanVariationScreenState();
}

class _PlanVariationScreenState extends State<PlanVariationScreen> {
  @override
  void initState() {
    super.initState();
    final userId = myUser?.userInfo?.userId ?? '';
    if (userId.isNotEmpty) {
      context.read<PlanVariationCubit>().fetchPlanVariation(userId);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWithBackButtonWOSilver(
        firstText: "Plan Of",
        secondText: "Variations",
      ),
      body: BlocBuilder<PlanVariationCubit, PlanVariationState>(
        builder: (context, state) {
          if (state is PlanVariationLoading) {
            return const Center(
              child: CircularProgressIndicator.adaptive(),
            );
          } else if (state is PlanVariationLoaded) {
            return _buildPlanContent(state.planVariation);
          } else if (state is PlanVariationError) {
            return _buildErrorState(state.error);
          } else {
            return const Center(
              child: Text('Something went wrong'),
            );
          }
        },
      ),
    );
  }

  Widget _buildPlanContent(PlanVariationModel planVariation) {
    if (planVariation.data == null || planVariation.data!.isEmpty) {
      return _buildEmptyState();
    }

    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 28.w, vertical: 28.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (planVariation.data!.length > 1) ...[
            _buildPlanSelector(planVariation),
            height(20),
          ],
          _buildPlanDetails(planVariation.data!.first),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.assignment_outlined,
              size: 80.w,
              color: Colors.grey[400],
            ),
            height(20),
            heading2Text(
              'No Plans Available',
              color: Colors.grey[600],
            ),
            height(10),
            simpleText(
              'Your coach hasn\'t created any plans for you yet. Check back later!',
              fontSize: 16,
              color: Colors.grey[500],
              align: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 28.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80.w,
              color: Colors.red[400],
            ),
            height(20),
            heading2Text(
              'Error Loading Plans',
              color: Colors.red[600],
            ),
            height(10),
            simpleText(
              error,
              fontSize: 16,
              color: Colors.red[500],
              align: TextAlign.center,
            ),
            height(20),
            ElevatedButton(
              onPressed: () {
                final userId = myUser?.userInfo?.userId ?? '';
                if (userId.isNotEmpty) {
                  context.read<PlanVariationCubit>().fetchPlanVariation(userId);
                }
              },
              child: const Text('Try Again'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlanSelector(PlanVariationModel planVariation) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: AppColors.primaryGreen.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(
            Icons.calendar_today,
            color: AppColors.primaryGreen,
            size: 20.w,
          ),
          width(12),
          Expanded(
            child: simpleText(
              'Plan created on ${_formatDate(planVariation.data!.first.createdAt ?? '')}',
              fontSize: 14,
              color: AppColors.primaryGreen,
            ),
          ),
          if (planVariation.data!.length > 1)
            Icon(
              Icons.arrow_drop_down,
              color: AppColors.primaryGreen,
            ),
        ],
      ),
    );
  }

  Widget _buildPlanDetails(PlanData planData) {
    if (planData.plans == null || planData.plans!.isEmpty) {
      return _buildEmptyPlanDetails();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading2Text(
          'Your Plan',
          color: AppColors.textDark,
        ),
        height(20),
        ...planData.plans!.asMap().entries.map((entry) {
          int index = entry.key;
          Plan plan = entry.value;
          return _buildPlanItem(index + 1, plan.note ?? '');
        }).toList(),
      ],
    );
  }

  Widget _buildEmptyPlanDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        heading2Text(
          'Your Plan',
          color: AppColors.textDark,
        ),
        height(20),
        Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            gradient: Insets.fixedGradient(opacity: 0.3),
            borderRadius: BorderRadius.circular(15),
          ),
          child: simpleText(
            'No plan items available',
            fontSize: 16,
            color: Colors.grey[600],
            align: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget _buildPlanItem(int index, String note) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: Insets.fixedGradient(opacity: 0.3),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: AppColors.primaryGreen.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32.w,
            height: 32.w,
            decoration: BoxDecoration(
              color: AppColors.primaryGreen,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: simpleText(
                '$index',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          width(16),
          Expanded(
            child: simpleText(
              note,
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textDark,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.day}/${date.month}/${date.year}';
    } catch (e) {
      return dateString;
    }
  }
}
