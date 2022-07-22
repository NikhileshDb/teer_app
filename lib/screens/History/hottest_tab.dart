import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/screens/History/utilities/get_popular_number.dart';

import '../../models/teer_result.dart';
import 'error_box.dart';
import 'utilities/get_the_last_digit.dart';
import 'utilities/set_to_iterable_list.dart';

class HottestNumbers extends StatefulWidget {
  const HottestNumbers({Key? key, required this.sliderVal}) : super(key: key);
  final double sliderVal;

  @override
  State<HottestNumbers> createState() => _HottestNumbersState();
}

class _HottestNumbersState extends State<HottestNumbers> {
  @override
  Widget build(BuildContext context) {
    final _data = Provider.of<List<TeerResult>>(context);
    List firstRoundAllPopularItems = [];
    List secondRoundAllMostPopularItems = [];
    List<int?> firstRoundList = [];
    List<int?> secondRoundList = [];

    setState(() {
      final results = _data.map((doc) => doc.toMap());
      for (final result in results) {
        firstRoundList.add(result['firstRound']);
        secondRoundList.add(result['secondRound']);
      }
      firstRoundAllPopularItems.add(firstRoundList.mostPopularItems().toList());
      // firstRoundAllPopularItems
      //     .add(firstRoundList.secondMostPopularItems().toList());
      secondRoundAllMostPopularItems
          .add(secondRoundList.mostPopularItems().toList());
      // secondRoundAllMostPopularItems
      //     .add(secondRoundList.secondMostPopularItems().toList());
    });

    final popularNumber = setToIterableList(firstRoundAllPopularItems);
    final popularSecondRound =
        setToIterableList(secondRoundAllMostPopularItems);

    final allList = popularNumber + popularSecondRound;
    List<int> myList = allList.map((e) => int.parse(e.toString())).toList();

    final houseNumber = getEndNumber(myList);
    final hotHouseNumber = houseNumber.mostPopularItems().toList();

    return _data.isEmpty
        ? const ErrorBox(
            errorMessage: "No Result to Show",
          )
        : Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                  child: Text(
                      'Showing  Hot Number from ${widget.sliderVal.toStringAsFixed(0)} days Results',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700)),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                  child: Text('First Round',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700)),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: popularNumber
                        .map(
                          (e) => Container(
                            height: 80,
                            width: 80,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                            ),
                            child: Center(
                              child: Text(
                                e.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                  child: Text('Second Round',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700)),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: popularSecondRound
                        .map(
                          (e) => Container(
                            height: 80,
                            width: 80,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                            ),
                            child: Center(
                              child: Text(
                                e.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 10, bottom: 5),
                  child: Text('Ending',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700)),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: hotHouseNumber
                        .map(
                          (e) => Container(
                            height: 80,
                            width: 80,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 5, vertical: 2),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                            ),
                            child: Center(
                              child: Text(
                                e.toString(),
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            ),
          );
  }
}
