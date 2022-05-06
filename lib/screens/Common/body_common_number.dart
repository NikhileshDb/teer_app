import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/common_numer.dart';

import '../History/error_box.dart';
import 'build_box.dart';
import 'date_change_notification.dart';

class BodyCommonNumber extends StatefulWidget {
  const BodyCommonNumber({
    Key? key,
  }) : super(key: key);

  @override
  State<BodyCommonNumber> createState() => _BodyCommonNumberState();
}

class _BodyCommonNumberState extends State<BodyCommonNumber> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<CommonNumberModel?>? _data =
        Provider.of<List<CommonNumberModel?>?>(context);

    return Column(
      children: [
        const Text(
          'Common Number',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        _data!.isEmpty
            ? const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 80),
                child: ErrorBox(
                  errorMessage: 'No Data Found',
                ),
              )
            : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: _data
                      .map(
                        (e) => BuildBox(
                          selectedDate: selectedDate,
                          commonNumber: e!.commonNumber,
                          provider: e.provider,
                          house: e.house,
                          ending: e.ending,
                        ),
                      )
                      .toList(),

                  // for (final item in _data)
                ),
              ),
        const SizedBox(
          height: 10,
        ),
        TextButton(
          onPressed: () {
            _selectDate(context);
          },
          child: const Text(
            'Select Date',
            style: TextStyle(
              fontSize: 16,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.white),
            minimumSize: MaterialStateProperty.all(
                Size(size.width * 0.8, size.height * 0.06)),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30))),
          ),
        ),

        //&************Utility for adding docs in bulk
        // TextButton(
        //     onPressed: () {
        //       DatabaseService().addDoc();
        //     },
        //     child: const Text('ADD DATA'))
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 600)),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        DateChangeNotfication(date: selectedDate).dispatch(context);
      });
    }
  }
}
