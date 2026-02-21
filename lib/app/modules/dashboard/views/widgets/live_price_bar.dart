import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import '../../../../../core/values/app_colors.dart';

class LivePriceBar extends StatelessWidget {
  const LivePriceBar({super.key});

  @override
  Widget build(BuildContext context) {
    // These would typically come from a service or controller
    const prices =
        "GOLD 24K: ₹7,250 | GOLD 22K: ₹6,650 | SILVER: ₹85,000 | PLATINUM: ₹3,200 | ";

    return Container(
      height: 35,
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        border: Border.symmetric(
          horizontal: BorderSide(
            color: AppColors.primary.withValues(alpha: 0.3),
            width: 0.5,
          ),
        ),
      ),
      child: Marquee(
        text: prices,
        style: TextStyle(
          color: AppColors.primary,
          fontSize: 13,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.5,
        ),
        scrollAxis: Axis.horizontal,
        crossAxisAlignment: CrossAxisAlignment.center,
        blankSpace: 20.0,
        velocity: 30.0,
        pauseAfterRound: const Duration(seconds: 1),
        accelerationDuration: const Duration(seconds: 1),
        accelerationCurve: Curves.linear,
        decelerationDuration: const Duration(milliseconds: 500),
        decelerationCurve: Curves.easeOut,
      ),
    );
  }
}
