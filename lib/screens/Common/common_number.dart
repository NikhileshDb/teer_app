import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teer_common/services/database/database_service.dart';
import '../../global_components/constants.dart';
import '../../models/common_numer.dart';
import 'body.dart';

class CommonNumber extends StatelessWidget {
  const CommonNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureProvider<CommonNumberModel?>.value(
      value: DatabaseService()
          .getCommonNumberBy("Shillong Teer", DateTime.parse("2022-04-23")),
      initialData: null,
      child: Scaffold(
        backgroundColor: kprimaryLight,
        appBar: AppBar(
          backgroundColor: Colors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          centerTitle: true,
          title: const Text(
            'COMMON NUMBERS',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: CommonNumberBody(size: size),
      ),
    );
  }
}
