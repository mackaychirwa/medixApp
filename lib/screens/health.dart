import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/lefttitles.dart';
import '../widgets/sidenav.dart';

class PatientChart extends StatefulWidget {
  const PatientChart({Key? key}) : super(key: key);

  @override
  State<PatientChart> createState() => _PatientChartState();
}

class _PatientChartState extends State<PatientChart> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late List<BarChartGroupData> rawBarGroups;
  late List<BarChartGroupData> showingBarGroups;

  int touchedGroupIndex = -1;

  @override
  void initState() {
    super.initState();
    final barGroup1 = makeGroupData(0, 5, 12);
    final barGroup2 = makeGroupData(1, 16, 12);
    final barGroup3 = makeGroupData(2, 18, 5);
    final barGroup4 = makeGroupData(3, 20, 16);
    final barGroup5 = makeGroupData(4, 17, 6);
    final barGroup6 = makeGroupData(5, 19, 1.5);
    final barGroup7 = makeGroupData(6, 10, 1.5);

    final items = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
      barGroup7,
    ];

    rawBarGroups = items;
    showingBarGroups = rawBarGroups;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          iconSize: 28.0,
          onPressed: ()=> _scaffoldKey.currentState!.openDrawer(),
          color: Colors.black,
        ),
        actions: [
          IconButton(onPressed: (){},
            icon: const Icon(Icons.settings),
            color: Colors.black,
          ),
        ],
      ),
      key: _scaffoldKey,
      drawer: const SideNav(),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          _buildChart(),
          _buildCharts(),
        ],
      ),
    );
  }



  SliverToBoxAdapter _buildChart() {
    return SliverToBoxAdapter(
      child: Container(
        height: MediaQuery.of(context).size.height /2.5,
        width: MediaQuery.of(context).size.width,
        child: AspectRatio(
          aspectRatio: 1,
          child: Card(
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            color: const Color(0xff2c4260),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      makeTransactionsIcon(),
                      const SizedBox(
                        width: 38,
                      ),
                      const Text(
                        'Comparitive Anaysis',
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: 20,
                        barTouchData: BarTouchData(
                            touchTooltipData: BarTouchTooltipData(
                              tooltipBgColor: Colors.grey,
                              getTooltipItem: (_a, _b, _c, _d) => null,
                            ),
                            touchCallback: (FlTouchEvent event, response) {
                              if (response == null || response.spot == null) {
                                setState(() {
                                  touchedGroupIndex = -1;
                                  showingBarGroups = List.of(rawBarGroups);
                                });
                                return;
                              }

                              touchedGroupIndex =
                                  response.spot!.touchedBarGroupIndex;

                              setState(() {
                                if (!event.isInterestedForInteractions) {
                                  touchedGroupIndex = -1;
                                  showingBarGroups = List.of(rawBarGroups);
                                  return;
                                }
                                showingBarGroups = List.of(rawBarGroups);
                                if (touchedGroupIndex != -1) {
                                  var sum = 0.0;
                                  for (var rod
                                      in showingBarGroups[touchedGroupIndex]
                                          .barRods) {
                                    sum += rod.toY;
                                  }
                                  final avg = sum /
                                      showingBarGroups[touchedGroupIndex]
                                          .barRods
                                          .length;

                                  showingBarGroups[touchedGroupIndex] =
                                      showingBarGroups[touchedGroupIndex]
                                          .copyWith(
                                    barRods: showingBarGroups[touchedGroupIndex]
                                        .barRods
                                        .map((rod) {
                                      return rod.copyWith(toY: avg);
                                    }).toList(),
                                  );
                                }
                              });
                            }),
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: bottomTitles,
                              reservedSize: 42,
                            ),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 1,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
                        gridData: FlGridData(show: false),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  SliverToBoxAdapter _buildCharts() {
    return SliverToBoxAdapter(
      child: Container(
        padding: const EdgeInsets.all(10),
        width: double.infinity,
        height: 300,
        child: LineChart(
          LineChartData(borderData: FlBorderData(show: false), lineBarsData: [
            LineChartBarData(spots: [
              const FlSpot(0, 1),
              const FlSpot(1, 3),
              const FlSpot(2, 10),
              const FlSpot(3, 7),
              const FlSpot(4, 12),
              const FlSpot(5, 13),
              const FlSpot(6, 17),
              const FlSpot(7, 15),
              const FlSpot(8, 20)
            ])
          ]),
        ),
      ),
    );
  }
}
