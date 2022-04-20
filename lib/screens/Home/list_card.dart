import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:teer_common/screens/History/result_history.dart';

class ListCard extends StatelessWidget {
  const ListCard({
    Key? key,
    this.firstRound,
    this.secondRound,
    required this.date,
    required this.provider,
  }) : super(key: key);
  final int? firstRound;
  final int? secondRound;
  final DateTime date;
  final String provider;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HistoryScreen(gamePlace: provider)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20, left: 20, right: 20),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.orangeAccent, Colors.redAccent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Icon(
                  Icons.label,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  provider,
                  style: const TextStyle(
                    color: Colors.white,
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
                      const Text(
                        'FIRST ROUND',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        firstRound.toString(),
                        style: const TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Column(children: [
                    const Text(
                      'SECOND ROUND',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      secondRound.toString(),
                      style: const TextStyle(
                        fontSize: 36,
                        color: Colors.white,
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
                  DateFormat('EEEE').format(date),
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('jm').format(date),
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(date),
                  style: const TextStyle(
                    color: Colors.white,
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
