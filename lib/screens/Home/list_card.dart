import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      splashColor: Colors.amberAccent,
      highlightColor: Colors.white.withOpacity(0),
      onTap: () {
        Navigator.pushNamed(context, '/history',
            arguments: {'gameProvider': gameProvider});
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10, top: 10),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.deepPurple,
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
                const Icon(
                  Icons.label,
                  color: Colors.orange,
                  size: 30,
                ),
                Text(
                  gameProvider ?? "Not Available",
                  style: const TextStyle(
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
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
                        firstRound == 111 ? 'XX' : firstRound.toString(),
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
                      secondRound == 111 ? 'XX' : secondRound.toString(),
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
                  DateFormat('EEEE').format(date ?? DateTime.now()),
                  style: const TextStyle(
                    color: Colors.amberAccent,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  DateFormat('jm').format(date ?? DateTime.now()),
                  style: const TextStyle(
                    color: Colors.amberAccent,
                  ),
                ),
                Text(
                  DateFormat('dd-MM-yyyy').format(date ?? DateTime.now()),
                  style: const TextStyle(
                    color: Colors.amberAccent,
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
