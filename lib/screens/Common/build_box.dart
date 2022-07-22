import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      height: size.height * 0.4,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            provider.isEmpty ? '' : provider.toString().toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.amberAccent,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: commonNumber!.isEmpty
                  ? [const Text('Sorry No Common Today')]
                  : commonNumber!
                      .map((e) => Expanded(
                            child: FittedBox(
                              child: Text(
                                e == 0
                                    ? "Sorry No Common Today"
                                    : e.toString() + ',',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                softWrap: false,
                                maxLines: 2,
                              ),
                            ),
                          ))
                      .toList()),
          const SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('House',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(house == 0 ? 'X' : house.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Ending',
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(ending == 0 ? 'X' : ending.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                      )),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            DateFormat('EEEE d MMMM y').format(selectedDate),
            style: const TextStyle(
              color: Colors.amberAccent,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
