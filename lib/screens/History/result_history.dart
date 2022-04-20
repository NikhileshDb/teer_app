import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/screens/History/history_tab.dart';
import 'package:teer_common/screens/History/statistic_tab.dart';
import 'package:teer_common/services/database/database_service.dart';

import '../../models/teer_result.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key, this.gamePlace}) : super(key: key);
  final String? gamePlace;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  TabController? controller;
  String? dropDownValue;
  DateTimeRange? _selectedDateRange;
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    dropDownValue = widget.gamePlace;
  }

  final items = ['Juwai', 'Shillong Teer', 'Khanapara'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: FutureProvider<List<TeerResult>>.value(
        value: DatabaseService().filterTeer(dropDownValue.toString(),
            _selectedDateRange?.start, _selectedDateRange?.end),
        initialData: const [],
        child: Scaffold(
          body: CustomScrollView(
            scrollDirection: Axis.vertical,
            slivers: [
              SliverAppBar(
                floating: true,
                backgroundColor: Colors.black,
                title: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    dropdownColor: Colors.black,
                    iconSize: 34,
                    icon: const Icon(Icons.keyboard_arrow_down,
                        color: Colors.white),
                    alignment: AlignmentDirectional.centerStart,
                    value: dropDownValue,
                    isDense: true,
                    items: items.map(buildMenuItem).toList(),
                    onChanged: (value) => setState(() => dropDownValue = value),
                  ),
                ),
                bottom: TabBar(
                  tabs: const [
                    Tab(text: 'History'),
                    Tab(text: 'Statistic'),
                  ],
                  controller: controller,
                ),
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: controller,
                  children: const [
                    HistoryTab(),
                    StatisticTab(),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: _showRangeSelector,
            child: const Icon(Icons.filter_list),
          ),
        ),
      ),
    );
  }

  void _showRangeSelector() async {
    final DateTimeRange? result = await showDateRangePicker(
        context: context,
        firstDate: DateTime(2018, 1, 1),
        lastDate: DateTime.now(),
        currentDate: DateTime.now(),
        saveText: 'Done');
    if (result != null) {
      setState(() {
        _selectedDateRange = result;
      });
    }
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
}
