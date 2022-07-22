import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/screens/History/history_tab.dart';
import 'package:teer_common/screens/History/hottest_tab.dart';
import 'package:teer_common/services/database/database_service.dart';
import 'dart:math' as m;
import '../../models/teer_result.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({Key? key, this.gameProvider}) : super(key: key);
  final String? gameProvider;

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen>
    with TickerProviderStateMixin {
  TabController? controller;
  String? dropDownValue;
  late DateTimeRange _selectedDateRange;
  double sliderVal = 60;
  DateTime dateDuration = DateTime.now();
  @override
  void initState() {
    super.initState();
    controller = TabController(length: 2, vsync: this);
    dropDownValue = widget.gameProvider ?? 'Shillong Teer';
    _selectedDateRange = DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 60)),
        end: DateTime.now());
  }

  final items = ['Juwai', 'Shillong Teer', 'Khanapara'];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: FutureProvider<List<TeerResult>>.value(
        value: DatabaseService().filterTeer(dropDownValue.toString(),
            _selectedDateRange.start, _selectedDateRange.end),
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
                    iconSize: 26,
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
                    Tab(text: 'Hottest'),
                  ],
                  controller: controller,
                ),
                actions: [
                  GestureDetector(
                    onTap: () {
                      _showRangeSelector();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(DateFormat('dd.MM.yy')
                              .format(_selectedDateRange.start)),
                          const Text(' to '),
                          Text(DateFormat('dd.MM.yy')
                              .format(_selectedDateRange.end)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SliverFillRemaining(
                child: TabBarView(
                  controller: controller,
                  children: [
                    HistoryTab(sliderVal: sliderVal),
                    HottestNumbers(sliderVal: sliderVal),
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: horizontalSlider(size),
        ),
      ),
    );
  }

  Stack horizontalSlider(Size size) {
    return Stack(
      children: [
        Positioned(
          width: size.width,
          bottom: 0,
          right: 0,
          child: Transform.rotate(
            origin: const Offset(10, -190),
            angle: -m.pi / 2,
            child: Slider(
              value: sliderVal,
              onChanged: (val) {
                setState(() {
                  sliderVal = val;
                });
              },
              min: 1,
              max: 1095,
              onChangeEnd: (val) {
                setState(() {
                  DateTime dateDuration = DateTime.now().subtract(
                      Duration(days: int.parse(val.toStringAsFixed(0))));
                  _selectedDateRange =
                      DateTimeRange(start: dateDuration, end: DateTime.now());
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showRangeSelector() async {
    final DateTimeRange? result = await showDateRangePicker(
        initialEntryMode: DatePickerEntryMode.calendarOnly,
        initialDateRange: DateTimeRange(
            start: DateTime.now().subtract(const Duration(days: 60)),
            end: DateTime.now()),
        helpText: 'SELECT DATE RANGE FOR HISTORY',
        context: context,
        firstDate: DateTime(2014, 1, 1),
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
