import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lykluk/utils/extensions/context_ext.dart';
import 'package:lykluk/utils/theme/app_colors.dart';

class RevenueChart extends StatelessWidget {
  const RevenueChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(aspectRatio: 1.8, child: LineChart(mainData(context)));
  }

  LineChartData mainData(BuildContext context) {
    final spots = [
      FlSpot(0, 0),
      FlSpot(0, 50000),
      FlSpot(1, 10000),
      FlSpot(2, 80000),
      FlSpot(3, 12000),
      FlSpot(4, 23986.97),
      FlSpot(5, 8000),
      FlSpot(6, 2000),
    ];

    return LineChartData(
      gridData: const FlGridData(show: false),
      
      titlesData: FlTitlesData(
        topTitles:  AxisTitles(sideTitles:SideTitles(
            showTitles: false,) ),
        rightTitles: AxisTitles(sideTitles:SideTitles(
            showTitles: false,) ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 25,
            getTitlesWidget: (value, _) {
              if (value == 0) return const Text('0');
              if (value == 1000) return const Text('1K');
              if (value == 10000) return const Text('10K');
              if (value == 100000) return const Text('100K', style: TextStyle(color: Colors.black));
              if (value == 1000000) return const Text('1M');
              return const SizedBox.shrink();
            },
          ),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: (value, _) {
              const days = [
                ""
                '16 Feb',
                '17 Feb',
                '18 Feb',
                '19 Feb',
                '20 Feb',
                '21 Feb',
                '22 Feb',
              ];
              if (value.toInt() < days.length) {
                return Text(
                  days[value.toInt()],
                  style: const TextStyle(fontSize: 10),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
      borderData: FlBorderData(show: false),
      minX: 0,
      maxX: 6,
      minY: 0,
      maxY: 100000,
      lineBarsData: [
        LineChartBarData(
          spots: spots,
          isCurved: true,
          color: const Color(0xFF9B5DE5),
          barWidth: 1.3,
          isStrokeCapRound: true,
        
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              stops: [0.1, 0.3, 0.5, 0.6, 0.7,1],
              colors: [
               Color(AppColors.primaryColor),
               Color(AppColors.primaryColor).withValues(alpha: 0.8),
               Color(AppColors.primaryColor).withValues(alpha: 0.6),
                Color(0xffF6EAFF),
                Color(0xffF6EAFF),
                Color(0xffF6EAFF)
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          dotData: FlDotData(show: true,),
        ),
      ],
      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          
          getTooltipColor: (v) {
            return context.colorScheme.surface;
          },
          getTooltipItems: (touchedSpots) {
            return touchedSpots.map((spot) {
              return LineTooltipItem(
                'TOTAL AMOUNT:',
                context.body10.copyWith(
                  fontWeight: FontWeight.w300,
                  fontSize: 8.sp,
                  color: context.colorScheme.primary,
                ),
                children: [
                  TextSpan(
                    text: "\n\$${spot.y.toStringAsFixed(2)}",
                    style: context.body10.copyWith(
                      fontWeight: FontWeight.w600,
                      color: context.colorScheme.primary,
                    ),
                  ),
                ],
              );
            }).toList();
          },
        ),
      ),
    );
  }
}
