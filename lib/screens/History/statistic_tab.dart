import 'package:flutter/material.dart';

class StatisticTab extends StatefulWidget {
  const StatisticTab({Key? key}) : super(key: key);

  @override
  State<StatisticTab> createState() => _StatisticTabState();
}

class _StatisticTabState extends State<StatisticTab> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
          onPressed: () {
            // DatabaseService().filterTeer('Shillong Teer');
          },
          child: const Text('Fetch')),
    );
  }
}
