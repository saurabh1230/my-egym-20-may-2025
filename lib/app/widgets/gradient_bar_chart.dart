import 'package:flutter/material.dart';

class GradientBarChart extends StatelessWidget {
  final List<double> data;
  final double barWidth;
  final double maxBarHeight;

  const GradientBarChart({
    super.key,
    required this.data,
    this.barWidth = 30.0,
    this.maxBarHeight = 100.0,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final availableHeight = constraints.maxHeight;
        final actualMaxHeight =
            maxBarHeight > availableHeight ? availableHeight : maxBarHeight;

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: List.generate(data.length, (index) {
            final value = data[index];
            final barHeight = (value / 100.0) * actualMaxHeight;
            final isMonday = index == 0;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: barWidth,
                  height: actualMaxHeight,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: barWidth,
                      height: barHeight,
                      decoration: BoxDecoration(
                        gradient: isMonday
                            ? LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.red.shade400,
                                  Colors.red.shade800,
                                ],
                              )
                            : LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.white.withOpacity(0.8),
                                  Colors.grey.shade400.withOpacity(0.6),
                                ],
                              ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: isMonday
                          ? Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  '${data[index].toInt()}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.0,
                                  ),
                                ),
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(
                  _getDayOfWeek(index),
                  style: const TextStyle(color: Colors.white70, fontSize: 12.0),
                ),
              ],
            );
          }),
        );
      },
    );
  }

  String _getDayOfWeek(int index) {
    switch (index) {
      case 0:
        return 'Mon';
      case 1:
        return 'Tue';
      case 2:
        return 'Wed';
      case 3:
        return 'Thu';
      case 4:
        return 'Fri';
      case 5:
        return 'Sat';
      default:
        return '';
    }
  }
}
