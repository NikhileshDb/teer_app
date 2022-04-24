import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../global_components/constants.dart';
import '../../models/common_numer.dart';
import '../../services/database/database_service.dart';
import 'body_common_number.dart';
import 'date_change_notification.dart';

class CommoNumberScreen extends StatefulWidget {
  const CommoNumberScreen({Key? key}) : super(key: key);

  @override
  State<CommoNumberScreen> createState() => _CommoNumberScreenState();
}

class _CommoNumberScreenState extends State<CommoNumberScreen> {
  DateTime selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return NotificationListener<DateChangeNotfication>(
      onNotification: (notifications) {
        setState(() {
          selectedDate = notifications.date;
        });
        return true;
      },
      child: FutureProvider<List<CommonNumberModel?>?>.value(
        value: DatabaseService().getCommonNumberBy(selectedDate),
        initialData: const [],
        child: Scaffold(
          backgroundColor: kprimaryLight,
          appBar: AppBar(
            title: const Text('Common Number'),
            backgroundColor: Colors.black,
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          body: const BodyCommonNumber(),
        ),
      ),
    );
  }
}
