import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teer_common/screens/History/result_history.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    this.firstRound,
    this.secondRound,
    required this.date,
    required this.gameProvider,
  }) : super(key: key);
  final int? firstRound;
  final int? secondRound;
  final DateTime? date;
  final String? gameProvider;

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      customBorder:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      containedInkWell: true,
      splashColor: Colors.red,
      highlightColor: Colors.white.withOpacity(0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    HistoryScreen(gameProvider: gameProvider)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: const BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.label,
                  color: Colors.grey.shade700,
                  size: 24,
                ),
                Text(
                  gameProvider ?? "Not Available",
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10),
            Padding(
              padding:
                  const EdgeInsets.only(left: 30, right: 30, top: 0, bottom: 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        'FIRST ROUND',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        firstRound.toString(),
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.grey.shade900,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(children: [
                    Text(
                      'SECOND ROUND',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      secondRound.toString(),
                      style: TextStyle(
                        fontSize: 36,
                        color: Colors.grey.shade900,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ]),
                ],
              ),
            ),
            Row(
              children: [
                Text(
                  DateFormat('EEEE').format(date ?? DateTime.now()),
                  style: TextStyle(color: Colors.grey.shade900),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('jm').format(date ?? DateTime.now()),
                  style: TextStyle(
                    color: Colors.grey.shade900,
                  ),
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(date ?? DateTime.now()),
                  style: TextStyle(
                    color: Colors.grey.shade900,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
