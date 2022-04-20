import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/global_components/constants.dart';

import '../../models/teer_result.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<TeerResult>>(context);

    return DataTable(
        decoration: const BoxDecoration(color: kprimaryLight),
        headingTextStyle:
            const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        headingRowColor: MaterialStateProperty.all(kprimaryColor),
        horizontalMargin: 20,
        columns: const [
          DataColumn(label: Text('Date')),
          DataColumn(label: Text('FR')),
          DataColumn(label: Text('SR')),
        ],
        rows: data
            .map<DataRow>((e) => DataRow(
                  cells: [
                    DataCell(Text(DateFormat('dd-MM-yyyy').format(e.date))),
                    DataCell(Text(e.firstRound.toString())),
                    DataCell(Text(e.secondRound.toString())),
                  ],
                ))
            .toList());
  }
}
