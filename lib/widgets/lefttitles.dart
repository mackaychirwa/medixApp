import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

Widget leftTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  String text;
  if (value == 0) {
    text = '1K';
  } else if (value == 10) {
    text = '5K';
  } else if (value == 19) {
    text = '10K';
  } else {
    return Container();
  }
  return Text(text, style: style);
}

Widget bottomTitles(double value, TitleMeta meta) {
  const style = TextStyle(
    color: Color(0xff7589a2),
    fontWeight: FontWeight.bold,
    fontSize: 14,
  );
  Widget text;
  switch (value.toInt()) {
    case 0:
      text = const Text(
        'Mn',
        style: style,
      );
      break;
    case 1:
      text = const Text(
        'Te',
        style: style,
      );
      break;
    case 2:
      text = const Text(
        'Wd',
        style: style,
      );
      break;
    case 3:
      text = const Text(
        'Tu',
        style: style,
      );
      break;
    case 4:
      text = const Text(
        'Fr',
        style: style,
      );
      break;
    case 5:
      text = const Text(
        'St',
        style: style,
      );
      break;
    case 6:
      text = const Text(
        'Sn',
        style: style,
      );
      break;
    default:
      text = const Text(
        '',
        style: style,
      );
      break;
  }
  return Padding(padding: const EdgeInsets.only(top: 20), child: text);
}

BarChartGroupData makeGroupData(int x, double y1, double y2) {
  const Color leftBarColor = Color(0xff53fdd7);
  const Color rightBarColor = Color(0xffff5182);
  const double width = 7;
  return BarChartGroupData(barsSpace: 4, x: x, barRods: [
    BarChartRodData(
      toY: y1,
      color: leftBarColor,
      width: width,
    ),
    BarChartRodData(
      toY: y2,
      color: rightBarColor,
      width: width,
    ),
  ]);
}

Widget makeTransactionsIcon() {
  const width = 4.5;
  const space = 3.5;
  return Row(
    mainAxisSize: MainAxisSize.min,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        width: width,
        height: 10,
        color: Colors.white.withOpacity(0.4),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 28,
        color: Colors.white.withOpacity(0.8),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 42,
        color: Colors.white.withOpacity(1),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 28,
        color: Colors.white.withOpacity(0.8),
      ),
      const SizedBox(
        width: space,
      ),
      Container(
        width: width,
        height: 10,
        color: Colors.white.withOpacity(0.4),
      ),
    ],
  );
}
