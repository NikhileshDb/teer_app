import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/global_components/constants.dart';

import '../../models/teer_result.dart';

class HistoryTab extends StatefulWidget {
  const HistoryTab({Key? key, required this.sliderVal}) : super(key: key);
  final double sliderVal;

  @override
  State<HistoryTab> createState() => _HistoryTabState();
}

class _HistoryTabState extends State<HistoryTab> {
  bool sort = true;
  @override
  Widget build(BuildContext context) {
    final data = Provider.of<List<TeerResult>>(context);

    return SingleChildScrollView(
      child: DataTable(
          sortAscending: sort,
          sortColumnIndex: 0,
          decoration: const BoxDecoration(color: kprimaryLight),
          headingTextStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey.shade900),
          headingRowColor: MaterialStateProperty.all(Colors.grey.shade200),
          horizontalMargin: 20,
          columns: [
            DataColumn(
              label: Text('Date [${widget.sliderVal.toStringAsFixed(0)} days]'),
            ),
            const DataColumn(label: Text('FR')),
            const DataColumn(label: Text('SR')),
          ],
          rows: data
              .map<DataRow>((e) => DataRow(
                    cells: [
                      DataCell(Text(DateFormat('dd-MM-yyyy').format(e.date),
                          style: const TextStyle(fontSize: 16))),
                      DataCell(Text(e.firstRound.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                      DataCell(Text(e.secondRound.toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold))),
                    ],
                  ))
              .toList()),
    );
  }
}
