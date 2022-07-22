import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Statistic extends StatefulWidget {
  const Statistic({super.key});

  @override
  State<Statistic> createState() => _StatisticState();
}

class _StatisticState extends State<Statistic> {
  final List<charts.Series>? seriesList = null;
  final bool animate = true;
  // Todo Number Horizontal bar charts
  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView();
  }
}
