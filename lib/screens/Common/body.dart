import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/common_numer.dart';

class CommonNumberBody extends StatefulWidget {
  const CommonNumberBody({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  State<CommonNumberBody> createState() => _CommonNumberBodyState();
}

class _CommonNumberBodyState extends State<CommonNumberBody> {
  @override
  Widget build(BuildContext context) {
    final _commonNumber = Provider.of<CommonNumberModel?>(context);
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('DISCLAIMER',
                  style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    textAlign: TextAlign.center,
                    'Common numbers displayed here are\nbased on certain calculations there is no\nguaranteed the accuracy of these numbers',
                  )
                ],
              ),
            ],
          ),
        ),
        Container(
          height: widget.size.height * 0.20,
          width: widget.size.width * 0.95,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              const Text(
                'COMMON NUMBER',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                _commonNumber == null || _commonNumber.commonNumber.isEmpty
                    ? "Sorry not available"
                    : _commonNumber.commonNumber.toString(),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
