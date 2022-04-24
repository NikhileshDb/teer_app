import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../global_components/constants.dart';

class BuildBox extends StatelessWidget {
  const BuildBox({
    Key? key,
    required this.selectedDate,
    required this.commonNumber,
    required this.provider,
    required this.house,
    required this.ending,
  }) : super(key: key);

  final DateTime selectedDate;
  final List? commonNumber;
  final String provider;
  final int? house;
  final int? ending;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.2,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: ksecondaryLight,
        boxShadow: const [
          BoxShadow(
            color: Colors.grey,
            spreadRadius: 1,
            blurRadius: 3,
          )
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(provider.isEmpty ? '' : provider.toString().toUpperCase(),
              style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 10,
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: commonNumber!.isEmpty
                  ? [const Text('Sorry No Common Today')]
                  : commonNumber!
                      .map((e) => Text(
                            e == null ? "Sorry No Common Today" : e.toString(),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey.shade700,
                            ),
                          ))
                      .toList()),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('House'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(house == null ? 'X' : house.toString()),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ending'),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(ending == null ? 'X' : ending.toString()),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('EEEE d MMMM y').format(selectedDate),
            style: const TextStyle(color: Colors.blue),
          ),
        ],
      ),
    );
  }
}